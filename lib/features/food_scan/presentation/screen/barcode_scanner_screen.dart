import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../providers/food_scan_provider.dart';

class BarcodeScannerScreen extends ConsumerStatefulWidget {
  const BarcodeScannerScreen({super.key});

  @override
  ConsumerState<BarcodeScannerScreen> createState() =>
      _BarcodeScannerScreenState();
}

class _BarcodeScannerScreenState extends ConsumerState<BarcodeScannerScreen>
    with WidgetsBindingObserver, SingleTickerProviderStateMixin {
  late final MobileScannerController _controller;
  late final AnimationController _animationController;
  late final Animation<double> _scanLineAnimation;

  bool _isProcessing = false;
  bool _isTorchOn = false;
  String? _errorMessage;

  // Scan zone dimensions
  static const double _scanZoneSize = 280;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);

    _controller = MobileScannerController(
      detectionSpeed: DetectionSpeed.noDuplicates,
      facing: CameraFacing.back,
      torchEnabled: false,
    );

    // Animation for scan line
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2000),
    )..repeat(reverse: true);

    _scanLineAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _animationController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (!_controller.value.isRunning) return;

    switch (state) {
      case AppLifecycleState.paused:
      case AppLifecycleState.inactive:
        _controller.stop();
        break;
      case AppLifecycleState.resumed:
        if (!_isProcessing) {
          _controller.start();
        }
        break;
      default:
        break;
    }
  }

  Rect _calculateScanWindow(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final scanSize = _scanZoneSize.w;
    final left = (size.width - scanSize) / 2;
    final top = (size.height - scanSize) / 2;
    return Rect.fromLTWH(left, top, scanSize, scanSize);
  }

  Future<void> _toggleTorch() async {
    await _controller.toggleTorch();
    setState(() {
      _isTorchOn = !_isTorchOn;
    });
  }

  Future<void> _handleBarcode(String barcode) async {
    if (_isProcessing) return;

    setState(() {
      _isProcessing = true;
      _errorMessage = null;
    });

    await _controller.stop();

    try {
      final response = await ref.read(scanBarcodeProvider(barcode).future);

      if (!mounted) return;

      if (!response.success || response.item == null) {
        setState(() {
          _errorMessage =
              response.error ?? 'Food not found for barcode: $barcode';
          _isProcessing = false;
        });

        await _controller.start();

        Future.delayed(const Duration(seconds: 3), () {
          if (mounted) {
            setState(() {
              _errorMessage = null;
            });
          }
        });
        return;
      }

      final foodReference = response.item!;
      final compartmentId =
          GoRouterState.of(context).uri.queryParameters['compartmentId'];

      final queryParams = <String, String>{
        'compartmentId': compartmentId ?? '',
        'foodRefId': foodReference.referenceId ?? '',
        'foodRefName': foodReference.name,
        'barcode': barcode,
        'fromScanner': 'true',
      };

      // Add optional fields if available
      if (foodReference.foodGroup != null) {
        queryParams['foodGroup'] = foodReference.foodGroup!;
      }
      if (foodReference.unitType != null) {
        queryParams['unitType'] = foodReference.unitType!;
      }
      if (foodReference.imageUrl != null) {
        final imageUrlStr = foodReference.imageUrl is String
            ? foodReference.imageUrl as String
            : foodReference.imageUrl?.toString();
        if (imageUrlStr != null && imageUrlStr.isNotEmpty) {
          queryParams['imageUrl'] = imageUrlStr;
        }
      }
      queryParams['shelfLifePantry'] =
          foodReference.typicalShelfLifeDaysPantry.toString();
      queryParams['shelfLifeFridge'] =
          foodReference.typicalShelfLifeDaysFridge.toString();
      queryParams['shelfLifeFreezer'] =
          foodReference.typicalShelfLifeDaysFreezer.toString();

      final uri = Uri(
        path: AppRoutes.addFood,
        queryParameters: queryParams,
      );

      final result = await context.push<bool>(uri.toString());

      if (!mounted) return;

      if (result == true) {
        if (context.mounted) {
          context.pop();
        }
        return;
      }

      setState(() {
        _isProcessing = false;
        _errorMessage = null;
      });

      await _controller.start();
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _errorMessage = 'Food not found for barcode: $barcode';
        _isProcessing = false;
      });

      await _controller.start();

      Future.delayed(const Duration(seconds: 3), () {
        if (mounted) {
          setState(() {
            _errorMessage = null;
          });
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final scanWindow = _calculateScanWindow(context);

    return AppScaffold(
      title: 'Scan Barcode',
      showBackButton: true,
      showAvatarButton: false,
      showNotificationButton: false,
      forcePillMode: true,
      padding: EdgeInsets.zero,
      body: Stack(
        children: [
          // Camera preview with scan window
          Positioned.fill(
            child: MobileScanner(
              controller: _controller,
              scanWindow: scanWindow,
              onDetect: (capture) {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  if (barcode.rawValue != null) {
                    _handleBarcode(barcode.rawValue!);
                    break;
                  }
                }
              },
            ),
          ),

          // Dark overlay with cutout
          Positioned.fill(
            child: CustomPaint(
              painter: _ScanOverlayPainter(
                scanRect: scanWindow,
                overlayColor: Colors.black.withValues(alpha: 0.6),
              ),
            ),
          ),

          // Scan zone frame with corners
          Positioned.fill(
            child: Center(
              child: SizedBox(
                width: _scanZoneSize.w,
                height: _scanZoneSize.w,
                child: Stack(
                  children: [
                    // Corner decorations
                    ..._buildCornerDecorations(),

                    // Animated scan line
                    AnimatedBuilder(
                      animation: _scanLineAnimation,
                      builder: (context, child) {
                        return Positioned(
                          top: _scanLineAnimation.value *
                              (_scanZoneSize.w - 4),
                          left: 20.w,
                          right: 20.w,
                          child: Container(
                            height: 3,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  Colors.transparent,
                                  AppColors.babyBlue,
                                  AppColors.powderBlue,
                                  AppColors.babyBlue,
                                  Colors.transparent,
                                ],
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.babyBlue.withValues(
                                    alpha: 0.6,
                                  ),
                                  blurRadius: 8,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Instructions card
          Positioned(
            top: MediaQuery.of(context).padding.top + kToolbarHeight + 16.h,
            left: 24.w,
            right: 24.w,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 14.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.95),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.15),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.qr_code_scanner,
                    color: AppColors.blueGray,
                    size: 22.sp,
                  ),
                  SizedBox(width: 10.w),
                  Text(
                    'Position barcode within the frame',
                    style: TextStyle(
                      color: AppColors.blueGray,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Processing overlay
          if (_isProcessing)
            Positioned.fill(
              child: Container(
                color: Colors.black.withValues(alpha: 0.75),
                child: Center(
                  child: Container(
                    padding: EdgeInsets.all(28.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.2),
                          blurRadius: 20,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SizedBox(
                          width: 48.w,
                          height: 48.w,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppColors.blueGray,
                            ),
                          ),
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          'Looking up product...',
                          style: AppTextStyles.sectionHeader(
                            color: AppColors.blueGray,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Please wait',
                          style: TextStyle(
                            color: AppColors.blueGray.withValues(alpha: 0.7),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

          // Error message
          if (_errorMessage != null)
            Positioned(
              bottom: 100.h,
              left: 24.w,
              right: 24.w,
              child: Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.red.shade600,
                      Colors.red.shade500,
                    ],
                  ),
                  borderRadius: BorderRadius.circular(14.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.red.withValues(alpha: 0.4),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8.w),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.2),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Icon(
                        Icons.error_outline,
                        color: Colors.white,
                        size: 22.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Expanded(
                      child: Text(
                        _errorMessage!,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

          // Bottom controls
          Positioned(
            bottom: 24.h,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Torch toggle button
                GestureDetector(
                  onTap: _toggleTorch,
                  child: Container(
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: _isTorchOn
                          ? AppColors.babyBlue
                          : Colors.white.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: _isTorchOn
                            ? AppColors.babyBlue
                            : Colors.white.withValues(alpha: 0.5),
                        width: 2,
                      ),
                      boxShadow: _isTorchOn
                          ? [
                              BoxShadow(
                                color: AppColors.babyBlue.withValues(
                                  alpha: 0.5,
                                ),
                                blurRadius: 16,
                                spreadRadius: 2,
                              ),
                            ]
                          : null,
                    ),
                    child: Icon(
                      _isTorchOn ? Icons.flashlight_on : Icons.flashlight_off,
                      color: Colors.white,
                      size: 28.sp,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Torch status label
          Positioned(
            bottom: 90.h,
            left: 0,
            right: 0,
            child: Center(
              child: Text(
                _isTorchOn ? 'Tap to turn off flash' : 'Tap to turn on flash',
                style: TextStyle(
                  color: Colors.white.withValues(alpha: 0.8),
                  fontSize: 12.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildCornerDecorations() {
    const cornerLength = 32.0;
    const cornerThickness = 4.0;
    final cornerColor = AppColors.babyBlue;

    return [
      // Top-left corner
      Positioned(
        top: 0,
        left: 0,
        child: _buildCorner(
          cornerLength,
          cornerThickness,
          cornerColor,
          topLeft: true,
        ),
      ),
      // Top-right corner
      Positioned(
        top: 0,
        right: 0,
        child: _buildCorner(
          cornerLength,
          cornerThickness,
          cornerColor,
          topRight: true,
        ),
      ),
      // Bottom-left corner
      Positioned(
        bottom: 0,
        left: 0,
        child: _buildCorner(
          cornerLength,
          cornerThickness,
          cornerColor,
          bottomLeft: true,
        ),
      ),
      // Bottom-right corner
      Positioned(
        bottom: 0,
        right: 0,
        child: _buildCorner(
          cornerLength,
          cornerThickness,
          cornerColor,
          bottomRight: true,
        ),
      ),
    ];
  }

  Widget _buildCorner(
    double length,
    double thickness,
    Color color, {
    bool topLeft = false,
    bool topRight = false,
    bool bottomLeft = false,
    bool bottomRight = false,
  }) {
    return SizedBox(
      width: length.w,
      height: length.w,
      child: CustomPaint(
        painter: _CornerPainter(
          color: color,
          thickness: thickness,
          topLeft: topLeft,
          topRight: topRight,
          bottomLeft: bottomLeft,
          bottomRight: bottomRight,
        ),
      ),
    );
  }
}

class _ScanOverlayPainter extends CustomPainter {
  final Rect scanRect;
  final Color overlayColor;

  _ScanOverlayPainter({
    required this.scanRect,
    required this.overlayColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = overlayColor;

    // Draw overlay with cutout
    final path = Path()
      ..addRect(Rect.fromLTWH(0, 0, size.width, size.height))
      ..addRRect(
        RRect.fromRectAndRadius(
          scanRect,
          Radius.circular(16.r),
        ),
      )
      ..fillType = PathFillType.evenOdd;

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _ScanOverlayPainter oldDelegate) {
    return oldDelegate.scanRect != scanRect ||
        oldDelegate.overlayColor != overlayColor;
  }
}

class _CornerPainter extends CustomPainter {
  final Color color;
  final double thickness;
  final bool topLeft;
  final bool topRight;
  final bool bottomLeft;
  final bool bottomRight;

  _CornerPainter({
    required this.color,
    required this.thickness,
    this.topLeft = false,
    this.topRight = false,
    this.bottomLeft = false,
    this.bottomRight = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = thickness
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    if (topLeft) {
      path.moveTo(0, size.height);
      path.lineTo(0, 0);
      path.lineTo(size.width, 0);
    } else if (topRight) {
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width, size.height);
    } else if (bottomLeft) {
      path.moveTo(0, 0);
      path.lineTo(0, size.height);
      path.lineTo(size.width, size.height);
    } else if (bottomRight) {
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width, 0);
    }

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant _CornerPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.thickness != thickness;
  }
}
