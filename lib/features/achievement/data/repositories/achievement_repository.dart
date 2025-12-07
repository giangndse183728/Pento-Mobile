import '../../../../core/network/endpoints.dart';
import '../../../../core/network/network_service.dart';
import '../models/achievement_model.dart';

class AchievementRepository {
  final NetworkService _network = NetworkService.instance;

  static const int defaultPageSize = 10;

  Future<PaginatedAchievements> getAchievements({
    int pageNumber = 1,
    int pageSize = defaultPageSize,
    bool? isAchieved,
    AchievementSortBy? sortBy,
    SortOrder? sortOrder,
  }) async {
    final queryParams = <String, dynamic>{
      'pageNumber': pageNumber,
      'pageSize': pageSize,
    };

    if (isAchieved != null) {
      queryParams['isAchieved'] = isAchieved;
    }

    if (sortBy != null) {
      queryParams['sortBy'] = sortBy.name;
    }

    if (sortOrder != null) {
      queryParams['sortOrder'] = sortOrder.name.toUpperCase();
    }

    final queryString = queryParams.entries
        .map((e) => '${e.key}=${Uri.encodeComponent(e.value.toString())}')
        .join('&');

    final result = await _network.get<PaginatedAchievements>(
      '${ApiEndpoints.getAchievement}?$queryString',
      onSuccess: (data) {
        return PaginatedAchievements.fromJson(data as Map<String, dynamic>);
      },
    );

    return result;
  }

  Future<AchievementDetail> getAchievementById(String milestoneId) async {
    final path = ApiEndpoints.getAchievementById.replaceFirst(
      '{milestoneId}',
      milestoneId,
    );
    final detail = await _network.get<AchievementDetail>(
      path,
      onSuccess: (data) {
        return AchievementDetail.fromJson(data as Map<String, dynamic>);
      },
    );
    return detail;
  }
}

