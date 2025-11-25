import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../constants/app_colors.dart';
import '../constants/app_typography.dart';
import '../network/api_client.dart';
import '../network/endpoints.dart';

class ImageSearchBottomSheet extends StatefulWidget {
  const ImageSearchBottomSheet({
    super.key,
    required this.initialQuery,
    required this.onImageSelected,
  });

  final String initialQuery;
  final Function(ImageSearchResult) onImageSelected;

  @override
  State<ImageSearchBottomSheet> createState() =>
      _ImageSearchBottomSheetState();
}

class _ImageSearchBottomSheetState extends State<ImageSearchBottomSheet> {
  final TextEditingController _searchController = TextEditingController();
  List<ImageSearchResult> _images = [];
  bool _isLoading = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _searchController.text = widget.initialQuery;
    _searchImages(widget.initialQuery);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _searchImages(String query) async {
    if (query.trim().isEmpty) return;

    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final response = await ApiClient.instance.localDio.post(
        ApiEndpoints.imageSearch,
        data: {
          'query': query,
          'num': 9, // Request 9 images for 3x3 grid
        },
      );

      if (response.statusCode != 200) {
        throw Exception('API returned status ${response.statusCode}');
      }

      final dynamic data = response.data;
      List<ImageSearchResult> results = [];

      if (data is List) {
        results = data
            .whereType<Map<String, dynamic>>()
            .map((json) => ImageSearchResult.fromJson(json))
            .toList();
      } else if (data is Map && data.containsKey('results')) {
        // Handle if response is wrapped in an object with 'results' key
        final images = data['results'] as List<dynamic>;
        results = images
            .whereType<Map<String, dynamic>>()
            .map((json) => ImageSearchResult.fromJson(json))
            .toList();
      } else if (data is Map && data.containsKey('images')) {
        // Handle if response is wrapped in an object with 'images' key
        final images = data['images'] as List<dynamic>;
        results = images
            .whereType<Map<String, dynamic>>()
            .map((json) => ImageSearchResult.fromJson(json))
            .toList();
      }

      setState(() {
        _images = results;
        _isLoading = false;
      });
    } catch (e) {


      setState(() {
        _error = 'Failed to search images. Please try again.';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24.r),
          topRight: Radius.circular(24.r),
        ),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: EdgeInsets.only(top: 12.h),
            width: 40.w,
            height: 4.h,
            decoration: BoxDecoration(
              color: AppColors.babyBlue,
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),

          // Title
          Padding(
            padding: EdgeInsets.all(20.w),
            child: Text(
              'Search Food Image',
              style: AppTextStyles.sectionHeader().copyWith(
                fontSize: 20.sp,
                color: AppColors.blueGray,
              ),
            ),
          ),

          // Search field
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search for food images...',
                prefixIcon: Icon(Icons.search, color: AppColors.blueGray),
                suffixIcon: IconButton(
                  icon: Icon(Icons.send, color: AppColors.blueGray),
                  onPressed: () => _searchImages(_searchController.text),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppColors.babyBlue),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(
                    color: AppColors.blueGray,
                    width: 2,
                  ),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
              onSubmitted: _searchImages,
            ),
          ),

          SizedBox(height: 16.h),

          // Images grid
          Expanded(
            child: _isLoading
                ? Center(
                    child: CircularProgressIndicator(
                      color: AppColors.blueGray,
                    ),
                  )
                : _error != null
                    ? Center(
                        child: Padding(
                          padding: EdgeInsets.all(20.w),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.error_outline,
                                size: 64.sp,
                                color: Colors.red.shade300,
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                _error!,
                                style: TextStyle(
                                  fontSize: 16.sp,
                                  color: Colors.black54,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              SizedBox(height: 16.h),
                              ElevatedButton(
                                onPressed: () =>
                                    _searchImages(_searchController.text),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.blueGray,
                                ),
                                child: const Text('Retry'),
                              ),
                            ],
                          ),
                        ),
                      )
                    : _images.isEmpty
                        ? Center(
                            child: Text(
                              'No images found',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.black54,
                              ),
                            ),
                          )
                        : GridView.builder(
                            padding: EdgeInsets.all(20.w),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 3,
                              crossAxisSpacing: 12.w,
                              mainAxisSpacing: 12.h,
                              childAspectRatio: 1,
                            ),
                            itemCount: _images.length > 9 ? 9 : _images.length,
                            itemBuilder: (context, index) {
                              final image = _images[index];
                              return GestureDetector(
                                onTap: () {
                                  widget.onImageSelected(image);
                                  Navigator.pop(context);
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12.r),
                                    border: Border.all(
                                      color: AppColors.babyBlue,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withAlpha(26),
                                        blurRadius: 8,
                                        offset: Offset(0, 2.h),
                                      ),
                                    ],
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10.r),
                                    child: Image.network(
                                      image.link,
                                      fit: BoxFit.cover,
                                      loadingBuilder:
                                          (context, child, loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        }
                                        return Container(
                                          color: AppColors.iceberg,
                                          child: Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.blueGray,
                                              value: loadingProgress
                                                          .expectedTotalBytes !=
                                                      null
                                                  ? loadingProgress
                                                          .cumulativeBytesLoaded /
                                                      loadingProgress
                                                          .expectedTotalBytes!
                                                  : null,
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder:
                                          (context, error, stackTrace) {
                                        return Container(
                                          color: AppColors.iceberg,
                                          child: Icon(
                                            Icons.broken_image,
                                            color: AppColors.blueGray,
                                            size: 32.sp,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
          ),
        ],
      ),
    );
  }
}

class ImageSearchResult {
  final String title;
  final String link;

  ImageSearchResult({
    required this.title,
    required this.link,
  });

  factory ImageSearchResult.fromJson(Map<String, dynamic> json) {
    return ImageSearchResult(
      title: (json['title'] ?? '') as String,
      link: (json['link'] ?? '') as String,
    );
  }
}

