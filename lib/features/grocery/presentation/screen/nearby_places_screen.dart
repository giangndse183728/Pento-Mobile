import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/services/location_service.dart';
import '../../../../core/widgets/app_dialog.dart';
import '../../data/models/place_models.dart';
import '../providers/nearby_places_provider.dart';

class NearbyPlacesScreen extends ConsumerStatefulWidget {
  const NearbyPlacesScreen({
    super.key,
    required this.foodGroup,
  });

  final String foodGroup;

  @override
  ConsumerState<NearbyPlacesScreen> createState() =>
      _NearbyPlacesScreenState();
}

class _NearbyPlacesScreenState extends ConsumerState<NearbyPlacesScreen> {
  GoogleMapController? _mapController;
  Place? _selectedPlace;
  final LocationService _locationService = LocationService.instance;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final placesAsync = ref.watch(nearbyPlacesProvider(widget.foodGroup));

    return AppScaffold(
      title: 'Nearby Stores',
      centerTitle: false,
      transparentAppBar: true,
      showNotificationButton: false,
      showBackButton: true,
      padding: EdgeInsets.zero,
      body: placesAsync.when(
        data: (places) {
          if (places.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.store_outlined,
                    size: 64.sp,
                    color: AppColors.blueGray.withValues(alpha: 0.5),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    'No nearby stores found',
                    style: TextStyle(
                      fontSize: 16.sp,
                      color: Colors.black54,
                    ),
                  ),
                ],
              ),
            );
          }

          final markers = _buildMarkers(places);
          final initialCameraPosition = places.isNotEmpty
              ? CameraPosition(
                  target: LatLng(
                    places.first.location.lat,
                    places.first.location.lng,
                  ),
                  zoom: 13,
                )
              : const CameraPosition(
                  target: LatLng(0, 0),
                  zoom: 13,
                );

          return Column(
            children: [
              // Map Section
              Expanded(
                flex: 2,
                child: Stack(
                  children: [
                    GoogleMap(
                      initialCameraPosition: initialCameraPosition,
                      markers: markers,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: false,
                      mapType: MapType.normal,
                      onMapCreated: (controller) {
                        _mapController = controller;
                        _fitBounds(places);
                      },
                      onTap: (LatLng position) {
                        setState(() {
                          _selectedPlace = null;
                        });
                      },
                    ),
                    Positioned(
                      bottom: 24.h,
                      left: 8.w,
                      child: FloatingActionButton(
                        mini: true,
                        backgroundColor: AppColors.blueGray,
                        child: Icon(
                          Icons.my_location,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                        onPressed: () async {
                          final currentPos = await _getCurrentLocation();
                          if (currentPos != null) {
                            _mapController?.animateCamera(
                              CameraUpdate.newLatLng(currentPos),
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
              // List Section
              Expanded(
                flex: 1,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.r),
                      topRight: Radius.circular(20.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.1),
                        blurRadius: 10,
                        offset: const Offset(0, -5),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(16.w),
                        child: Row(
                          children: [
                            Icon(
                              Icons.store,
                              size: 20.sp,
                              color: AppColors.blueGray,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Stores (${places.length})',
                              style: AppTextStyles.sectionHeader(
                                color: AppColors.blueGray,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: ListView.builder(
                          padding: EdgeInsets.symmetric(horizontal: 16.w),
                          itemCount: places.length,
                          itemBuilder: (context, index) {
                            final place = places[index];
                            final isSelected = _selectedPlace?.placeId == place.placeId;

                            return _PlaceListItem(
                              place: place,
                              isSelected: isSelected,
                              onTap: () {
                                setState(() {
                                  _selectedPlace = place;
                                });
                                _moveToPlace(place);
                              },
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(
            color: AppColors.blueGray,
          ),
        ),
        error: (error, stack) {
          // Check if it's a 403 error and show subscription dialog
          if (error is NetworkException && error.isForbidden) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showSubscriptionDialog(context);
            });
          }

          return Center(
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
                  'Failed to load nearby stores',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: Colors.black54,
                  ),
                ),
                SizedBox(height: 16.h),
                ElevatedButton(
                  onPressed: () {
                    ref.invalidate(nearbyPlacesProvider(widget.foodGroup));
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.blueGray,
                  ),
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Set<Marker> _buildMarkers(List<Place> places) {
    return places.map((place) {
      return Marker(
        markerId: MarkerId(place.placeId),
        position: LatLng(place.location.lat, place.location.lng),
        infoWindow: InfoWindow(
          title: place.name,
          snippet: place.address,
        ),
        icon: BitmapDescriptor.defaultMarkerWithHue(
          BitmapDescriptor.hueRed,
        ),
      );
    }).toSet();
  }

  void _fitBounds(List<Place> places) {
    if (places.isEmpty || _mapController == null) return;

    double minLat = places.first.location.lat;
    double maxLat = places.first.location.lat;
    double minLng = places.first.location.lng;
    double maxLng = places.first.location.lng;

    for (final place in places) {
      minLat = minLat < place.location.lat ? minLat : place.location.lat;
      maxLat = maxLat > place.location.lat ? maxLat : place.location.lat;
      minLng = minLng < place.location.lng ? minLng : place.location.lng;
      maxLng = maxLng > place.location.lng ? maxLng : place.location.lng;
    }

    _mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        LatLngBounds(
          southwest: LatLng(minLat, minLng),
          northeast: LatLng(maxLat, maxLng),
        ),
        50.w,
      ),
    );
  }

  void _moveToPlace(Place place) {
    if (_mapController == null) return;

    _mapController!.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(place.location.lat, place.location.lng),
          zoom: 15,
        ),
      ),
    );
  }

  Future<LatLng?> _getCurrentLocation() async {
    final position = await _locationService.getCurrentLocation();
    if (position == null) return null;
    return LatLng(position.latitude, position.longitude);
  }

  void _showSubscriptionDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (dialogContext) => AppDialog(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.lock_outline_rounded,
              size: 48.sp,
              color: AppColors.blueGray,
            ),
            SizedBox(height: 16.h),
            Text(
              'Feature Not Available',
              style: AppTextStyles.sectionHeader().copyWith(
                fontSize: 20.sp,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 12.h),
            Text(
              'This feature is only available for subscribed users. '
              'Please subscribe to access nearby stores.',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.blueGray,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.of(dialogContext).pop(),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: AppColors.blueGray,
                      side: BorderSide(
                        color: AppColors.powderBlue,
                        width: 2,
                      ),
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Cancel',
                      style: AppTextStyles.inputLabel.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(dialogContext).pop();
                      context.push(AppRoutes.subscription);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.blueGray,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Subscribe',
                      style: AppTextStyles.inputLabel.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _PlaceListItem extends StatelessWidget {
  const _PlaceListItem({
    required this.place,
    required this.isSelected,
    required this.onTap,
  });

  final Place place;
  final bool isSelected;
  final VoidCallback onTap;

  Future<void> _openMaps(double lat, double lng) async {
    final url = Uri.parse(
      'https://www.google.com/maps/search/?api=1&query=$lat,$lng',
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 12.h),
      decoration: BoxDecoration(
        color: isSelected
            ? AppColors.blueGray.withValues(alpha: 0.1)
            : Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected
              ? AppColors.blueGray
              : Colors.black12,
          width: isSelected ? 2 : 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.r),
          child: Padding(
            padding: EdgeInsets.all(12.w),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        place.name,
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w600,
                          color: AppColors.blueGray,
                        ),
                      ),
                      if (place.address.isNotEmpty) ...[
                        SizedBox(height: 4.h),
                        Text(
                          place.address,
                          style: TextStyle(
                            fontSize: 12.sp,
                            color: Colors.black54,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                      if (place.rating > 0) ...[
                        SizedBox(height: 6.h),
                        Row(
                          children: [
                            Icon(
                              Icons.star,
                              size: 14.sp,
                              color: Colors.amber,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${place.rating.toStringAsFixed(1)}',
                              style: TextStyle(
                                fontSize: 12.sp,
                                color: Colors.black54,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            if (place.userRatingsTotal > 0) ...[
                              SizedBox(width: 4.w),
                              Text(
                                '(${place.userRatingsTotal} reviews)',
                                style: TextStyle(
                                  fontSize: 11.sp,
                                  color: Colors.black54,
                                ),
                              ),
                            ],
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                IconButton(
                  icon: Icon(
                    Icons.directions,
                    size: 24.sp,
                    color: AppColors.blueGray,
                  ),
                  onPressed: () => _openMaps(
                    place.location.lat,
                    place.location.lng,
                  ),
                  tooltip: 'Open in Maps',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

