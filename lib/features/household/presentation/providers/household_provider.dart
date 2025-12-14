import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../authentication/presentation/providers/user_session_provider.dart';
import '../../data/models/household_models.dart';
import '../../data/repositories/household_repository.dart';

part 'household_provider.g.dart';

@riverpod
class HouseholdProvider extends _$HouseholdProvider {
  late final HouseholdRepository _repository;

  @override
  FutureOr<Household?> build() {
    _repository = HouseholdRepository();
    return _loadCurrentHousehold();
  }

  /// Load current household on initialization
  Future<Household?> _loadCurrentHousehold() async {
    try {
      return await _repository.getCurrentHousehold();
    } catch (e) {
      return null;
    }
  }

  /// Create a new household
  /// Returns the invite code
  Future<String> createHousehold({required String name}) async {
    state = const AsyncValue.loading();

    final createResponse = await _repository.createHousehold(
      CreateHouseholdRequest(name: name),
    );

    // After creating, fetch the full household details
    final household = await _repository.getCurrentHousehold();
    state = AsyncValue.data(household);

    return createResponse.inviteCode;
  }

  /// Join an existing household
  Future<void> joinHousehold({required String inviteCode}) async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final request = JoinHouseholdRequest(inviteCode: inviteCode);
      return await _repository.joinHousehold(request);
    });
  }

  /// Refresh current household
  Future<void> refresh() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      return await _repository.getCurrentHousehold();
    });
  }

  /// Leave the current household
  Future<void> leaveHousehold() async {
    await _repository.leaveHousehold();
    // After leaving, set state to null (no household)
    state = const AsyncValue.data(null);
    // Update user session to clear householdId
    final session = ref.read(userSessionNotifierProvider);
    if (session != null && session.userId != null) {
      ref.read(userSessionNotifierProvider.notifier).updateProfileData(
        userId: session.userId!,
        email: session.email,
        preferredUsername: session.preferredUsername,
        avatarUrl: session.avatarUrl,
        name: session.name,
        householdId: null, // Clear householdId
      );
    }
  }

  /// Kick a member from the household
  Future<void> kickHouseholdMember(String userId) async {
    await _repository.kickHouseholdMember(userId);
    // After kicking, refresh the household to get updated member list
    await refresh();
  }
}

