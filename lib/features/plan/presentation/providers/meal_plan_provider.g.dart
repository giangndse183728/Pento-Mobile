// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'meal_plan_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$mealPlanHash() => r'72a29dd7b5af91761af258b06ee0ab2131a7a950';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$MealPlan
    extends BuildlessAutoDisposeAsyncNotifier<List<MealPlanItem>> {
  late final int month;
  late final int year;

  FutureOr<List<MealPlanItem>> build({required int month, required int year});
}

/// Provider to fetch meal plans for a specific month/year
///
/// Copied from [MealPlan].
@ProviderFor(MealPlan)
const mealPlanProvider = MealPlanFamily();

/// Provider to fetch meal plans for a specific month/year
///
/// Copied from [MealPlan].
class MealPlanFamily extends Family<AsyncValue<List<MealPlanItem>>> {
  /// Provider to fetch meal plans for a specific month/year
  ///
  /// Copied from [MealPlan].
  const MealPlanFamily();

  /// Provider to fetch meal plans for a specific month/year
  ///
  /// Copied from [MealPlan].
  MealPlanProvider call({required int month, required int year}) {
    return MealPlanProvider(month: month, year: year);
  }

  @override
  MealPlanProvider getProviderOverride(covariant MealPlanProvider provider) {
    return call(month: provider.month, year: provider.year);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'mealPlanProvider';
}

/// Provider to fetch meal plans for a specific month/year
///
/// Copied from [MealPlan].
class MealPlanProvider
    extends AutoDisposeAsyncNotifierProviderImpl<MealPlan, List<MealPlanItem>> {
  /// Provider to fetch meal plans for a specific month/year
  ///
  /// Copied from [MealPlan].
  MealPlanProvider({required int month, required int year})
    : this._internal(
        () => MealPlan()
          ..month = month
          ..year = year,
        from: mealPlanProvider,
        name: r'mealPlanProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$mealPlanHash,
        dependencies: MealPlanFamily._dependencies,
        allTransitiveDependencies: MealPlanFamily._allTransitiveDependencies,
        month: month,
        year: year,
      );

  MealPlanProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.month,
    required this.year,
  }) : super.internal();

  final int month;
  final int year;

  @override
  FutureOr<List<MealPlanItem>> runNotifierBuild(covariant MealPlan notifier) {
    return notifier.build(month: month, year: year);
  }

  @override
  Override overrideWith(MealPlan Function() create) {
    return ProviderOverride(
      origin: this,
      override: MealPlanProvider._internal(
        () => create()
          ..month = month
          ..year = year,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        month: month,
        year: year,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<MealPlan, List<MealPlanItem>>
  createElement() {
    return _MealPlanProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is MealPlanProvider &&
        other.month == month &&
        other.year == year;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, month.hashCode);
    hash = _SystemHash.combine(hash, year.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin MealPlanRef on AutoDisposeAsyncNotifierProviderRef<List<MealPlanItem>> {
  /// The parameter `month` of this provider.
  int get month;

  /// The parameter `year` of this provider.
  int get year;
}

class _MealPlanProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<MealPlan, List<MealPlanItem>>
    with MealPlanRef {
  _MealPlanProviderElement(super.provider);

  @override
  int get month => (origin as MealPlanProvider).month;
  @override
  int get year => (origin as MealPlanProvider).year;
}

String _$focusedMonthHash() => r'f7b485079b4d8986abd647fdb6dc9513f9a6d9bd';

/// Provider for the currently focused month in calendar
///
/// Copied from [FocusedMonth].
@ProviderFor(FocusedMonth)
final focusedMonthProvider =
    AutoDisposeNotifierProvider<FocusedMonth, DateTime>.internal(
      FocusedMonth.new,
      name: r'focusedMonthProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$focusedMonthHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FocusedMonth = AutoDisposeNotifier<DateTime>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
