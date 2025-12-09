// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'achievement_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

PaginatedAchievements _$PaginatedAchievementsFromJson(
  Map<String, dynamic> json,
) {
  return _PaginatedAchievements.fromJson(json);
}

/// @nodoc
mixin _$PaginatedAchievements {
  int get currentPage => throw _privateConstructorUsedError;
  int get totalPages => throw _privateConstructorUsedError;
  int get pageSize => throw _privateConstructorUsedError;
  int get totalCount => throw _privateConstructorUsedError;
  bool get hasPrevious => throw _privateConstructorUsedError;
  bool get hasNext => throw _privateConstructorUsedError;
  List<Achievement> get items => throw _privateConstructorUsedError;

  /// Serializes this PaginatedAchievements to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PaginatedAchievements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PaginatedAchievementsCopyWith<PaginatedAchievements> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaginatedAchievementsCopyWith<$Res> {
  factory $PaginatedAchievementsCopyWith(
    PaginatedAchievements value,
    $Res Function(PaginatedAchievements) then,
  ) = _$PaginatedAchievementsCopyWithImpl<$Res, PaginatedAchievements>;
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<Achievement> items,
  });
}

/// @nodoc
class _$PaginatedAchievementsCopyWithImpl<
  $Res,
  $Val extends PaginatedAchievements
>
    implements $PaginatedAchievementsCopyWith<$Res> {
  _$PaginatedAchievementsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PaginatedAchievements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
    Object? items = null,
  }) {
    return _then(
      _value.copyWith(
            currentPage: null == currentPage
                ? _value.currentPage
                : currentPage // ignore: cast_nullable_to_non_nullable
                      as int,
            totalPages: null == totalPages
                ? _value.totalPages
                : totalPages // ignore: cast_nullable_to_non_nullable
                      as int,
            pageSize: null == pageSize
                ? _value.pageSize
                : pageSize // ignore: cast_nullable_to_non_nullable
                      as int,
            totalCount: null == totalCount
                ? _value.totalCount
                : totalCount // ignore: cast_nullable_to_non_nullable
                      as int,
            hasPrevious: null == hasPrevious
                ? _value.hasPrevious
                : hasPrevious // ignore: cast_nullable_to_non_nullable
                      as bool,
            hasNext: null == hasNext
                ? _value.hasNext
                : hasNext // ignore: cast_nullable_to_non_nullable
                      as bool,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<Achievement>,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$PaginatedAchievementsImplCopyWith<$Res>
    implements $PaginatedAchievementsCopyWith<$Res> {
  factory _$$PaginatedAchievementsImplCopyWith(
    _$PaginatedAchievementsImpl value,
    $Res Function(_$PaginatedAchievementsImpl) then,
  ) = __$$PaginatedAchievementsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    int currentPage,
    int totalPages,
    int pageSize,
    int totalCount,
    bool hasPrevious,
    bool hasNext,
    List<Achievement> items,
  });
}

/// @nodoc
class __$$PaginatedAchievementsImplCopyWithImpl<$Res>
    extends
        _$PaginatedAchievementsCopyWithImpl<$Res, _$PaginatedAchievementsImpl>
    implements _$$PaginatedAchievementsImplCopyWith<$Res> {
  __$$PaginatedAchievementsImplCopyWithImpl(
    _$PaginatedAchievementsImpl _value,
    $Res Function(_$PaginatedAchievementsImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of PaginatedAchievements
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currentPage = null,
    Object? totalPages = null,
    Object? pageSize = null,
    Object? totalCount = null,
    Object? hasPrevious = null,
    Object? hasNext = null,
    Object? items = null,
  }) {
    return _then(
      _$PaginatedAchievementsImpl(
        currentPage: null == currentPage
            ? _value.currentPage
            : currentPage // ignore: cast_nullable_to_non_nullable
                  as int,
        totalPages: null == totalPages
            ? _value.totalPages
            : totalPages // ignore: cast_nullable_to_non_nullable
                  as int,
        pageSize: null == pageSize
            ? _value.pageSize
            : pageSize // ignore: cast_nullable_to_non_nullable
                  as int,
        totalCount: null == totalCount
            ? _value.totalCount
            : totalCount // ignore: cast_nullable_to_non_nullable
                  as int,
        hasPrevious: null == hasPrevious
            ? _value.hasPrevious
            : hasPrevious // ignore: cast_nullable_to_non_nullable
                  as bool,
        hasNext: null == hasNext
            ? _value.hasNext
            : hasNext // ignore: cast_nullable_to_non_nullable
                  as bool,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<Achievement>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$PaginatedAchievementsImpl implements _PaginatedAchievements {
  const _$PaginatedAchievementsImpl({
    this.currentPage = 1,
    this.totalPages = 1,
    this.pageSize = 10,
    this.totalCount = 0,
    this.hasPrevious = false,
    this.hasNext = false,
    final List<Achievement> items = const [],
  }) : _items = items;

  factory _$PaginatedAchievementsImpl.fromJson(Map<String, dynamic> json) =>
      _$$PaginatedAchievementsImplFromJson(json);

  @override
  @JsonKey()
  final int currentPage;
  @override
  @JsonKey()
  final int totalPages;
  @override
  @JsonKey()
  final int pageSize;
  @override
  @JsonKey()
  final int totalCount;
  @override
  @JsonKey()
  final bool hasPrevious;
  @override
  @JsonKey()
  final bool hasNext;
  final List<Achievement> _items;
  @override
  @JsonKey()
  List<Achievement> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  @override
  String toString() {
    return 'PaginatedAchievements(currentPage: $currentPage, totalPages: $totalPages, pageSize: $pageSize, totalCount: $totalCount, hasPrevious: $hasPrevious, hasNext: $hasNext, items: $items)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PaginatedAchievementsImpl &&
            (identical(other.currentPage, currentPage) ||
                other.currentPage == currentPage) &&
            (identical(other.totalPages, totalPages) ||
                other.totalPages == totalPages) &&
            (identical(other.pageSize, pageSize) ||
                other.pageSize == pageSize) &&
            (identical(other.totalCount, totalCount) ||
                other.totalCount == totalCount) &&
            (identical(other.hasPrevious, hasPrevious) ||
                other.hasPrevious == hasPrevious) &&
            (identical(other.hasNext, hasNext) || other.hasNext == hasNext) &&
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    currentPage,
    totalPages,
    pageSize,
    totalCount,
    hasPrevious,
    hasNext,
    const DeepCollectionEquality().hash(_items),
  );

  /// Create a copy of PaginatedAchievements
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PaginatedAchievementsImplCopyWith<_$PaginatedAchievementsImpl>
  get copyWith =>
      __$$PaginatedAchievementsImplCopyWithImpl<_$PaginatedAchievementsImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$PaginatedAchievementsImplToJson(this);
  }
}

abstract class _PaginatedAchievements implements PaginatedAchievements {
  const factory _PaginatedAchievements({
    final int currentPage,
    final int totalPages,
    final int pageSize,
    final int totalCount,
    final bool hasPrevious,
    final bool hasNext,
    final List<Achievement> items,
  }) = _$PaginatedAchievementsImpl;

  factory _PaginatedAchievements.fromJson(Map<String, dynamic> json) =
      _$PaginatedAchievementsImpl.fromJson;

  @override
  int get currentPage;
  @override
  int get totalPages;
  @override
  int get pageSize;
  @override
  int get totalCount;
  @override
  bool get hasPrevious;
  @override
  bool get hasNext;
  @override
  List<Achievement> get items;

  /// Create a copy of PaginatedAchievements
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PaginatedAchievementsImplCopyWith<_$PaginatedAchievementsImpl>
  get copyWith => throw _privateConstructorUsedError;
}

Achievement _$AchievementFromJson(Map<String, dynamic> json) {
  return _Achievement.fromJson(json);
}

/// @nodoc
mixin _$Achievement {
  String get milestoneId => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'achievedOn')
  DateTime? get achievedOn => throw _privateConstructorUsedError;
  int get progress => throw _privateConstructorUsedError;

  /// Serializes this Achievement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementCopyWith<Achievement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementCopyWith<$Res> {
  factory $AchievementCopyWith(
    Achievement value,
    $Res Function(Achievement) then,
  ) = _$AchievementCopyWithImpl<$Res, Achievement>;
  @useResult
  $Res call({
    String milestoneId,
    String? icon,
    String name,
    @JsonKey(name: 'achievedOn') DateTime? achievedOn,
    int progress,
  });
}

/// @nodoc
class _$AchievementCopyWithImpl<$Res, $Val extends Achievement>
    implements $AchievementCopyWith<$Res> {
  _$AchievementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? milestoneId = null,
    Object? icon = freezed,
    Object? name = null,
    Object? achievedOn = freezed,
    Object? progress = null,
  }) {
    return _then(
      _value.copyWith(
            milestoneId: null == milestoneId
                ? _value.milestoneId
                : milestoneId // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            achievedOn: freezed == achievedOn
                ? _value.achievedOn
                : achievedOn // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as int,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AchievementImplCopyWith<$Res>
    implements $AchievementCopyWith<$Res> {
  factory _$$AchievementImplCopyWith(
    _$AchievementImpl value,
    $Res Function(_$AchievementImpl) then,
  ) = __$$AchievementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String milestoneId,
    String? icon,
    String name,
    @JsonKey(name: 'achievedOn') DateTime? achievedOn,
    int progress,
  });
}

/// @nodoc
class __$$AchievementImplCopyWithImpl<$Res>
    extends _$AchievementCopyWithImpl<$Res, _$AchievementImpl>
    implements _$$AchievementImplCopyWith<$Res> {
  __$$AchievementImplCopyWithImpl(
    _$AchievementImpl _value,
    $Res Function(_$AchievementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? milestoneId = null,
    Object? icon = freezed,
    Object? name = null,
    Object? achievedOn = freezed,
    Object? progress = null,
  }) {
    return _then(
      _$AchievementImpl(
        milestoneId: null == milestoneId
            ? _value.milestoneId
            : milestoneId // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        achievedOn: freezed == achievedOn
            ? _value.achievedOn
            : achievedOn // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as int,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementImpl implements _Achievement {
  const _$AchievementImpl({
    required this.milestoneId,
    this.icon,
    required this.name,
    @JsonKey(name: 'achievedOn') this.achievedOn,
    this.progress = 0,
  });

  factory _$AchievementImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementImplFromJson(json);

  @override
  final String milestoneId;
  @override
  final String? icon;
  @override
  final String name;
  @override
  @JsonKey(name: 'achievedOn')
  final DateTime? achievedOn;
  @override
  @JsonKey()
  final int progress;

  @override
  String toString() {
    return 'Achievement(milestoneId: $milestoneId, icon: $icon, name: $name, achievedOn: $achievedOn, progress: $progress)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementImpl &&
            (identical(other.milestoneId, milestoneId) ||
                other.milestoneId == milestoneId) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.achievedOn, achievedOn) ||
                other.achievedOn == achievedOn) &&
            (identical(other.progress, progress) ||
                other.progress == progress));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, milestoneId, icon, name, achievedOn, progress);

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      __$$AchievementImplCopyWithImpl<_$AchievementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementImplToJson(this);
  }
}

abstract class _Achievement implements Achievement {
  const factory _Achievement({
    required final String milestoneId,
    final String? icon,
    required final String name,
    @JsonKey(name: 'achievedOn') final DateTime? achievedOn,
    final int progress,
  }) = _$AchievementImpl;

  factory _Achievement.fromJson(Map<String, dynamic> json) =
      _$AchievementImpl.fromJson;

  @override
  String get milestoneId;
  @override
  String? get icon;
  @override
  String get name;
  @override
  @JsonKey(name: 'achievedOn')
  DateTime? get achievedOn;
  @override
  int get progress;

  /// Create a copy of Achievement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementImplCopyWith<_$AchievementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AchievementDetail _$AchievementDetailFromJson(Map<String, dynamic> json) {
  return _AchievementDetail.fromJson(json);
}

/// @nodoc
mixin _$AchievementDetail {
  AchievementMilestone get milestone => throw _privateConstructorUsedError;
  List<Requirement> get requirements => throw _privateConstructorUsedError;

  /// Serializes this AchievementDetail to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AchievementDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementDetailCopyWith<AchievementDetail> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementDetailCopyWith<$Res> {
  factory $AchievementDetailCopyWith(
    AchievementDetail value,
    $Res Function(AchievementDetail) then,
  ) = _$AchievementDetailCopyWithImpl<$Res, AchievementDetail>;
  @useResult
  $Res call({AchievementMilestone milestone, List<Requirement> requirements});

  $AchievementMilestoneCopyWith<$Res> get milestone;
}

/// @nodoc
class _$AchievementDetailCopyWithImpl<$Res, $Val extends AchievementDetail>
    implements $AchievementDetailCopyWith<$Res> {
  _$AchievementDetailCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AchievementDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? milestone = null, Object? requirements = null}) {
    return _then(
      _value.copyWith(
            milestone: null == milestone
                ? _value.milestone
                : milestone // ignore: cast_nullable_to_non_nullable
                      as AchievementMilestone,
            requirements: null == requirements
                ? _value.requirements
                : requirements // ignore: cast_nullable_to_non_nullable
                      as List<Requirement>,
          )
          as $Val,
    );
  }

  /// Create a copy of AchievementDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AchievementMilestoneCopyWith<$Res> get milestone {
    return $AchievementMilestoneCopyWith<$Res>(_value.milestone, (value) {
      return _then(_value.copyWith(milestone: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AchievementDetailImplCopyWith<$Res>
    implements $AchievementDetailCopyWith<$Res> {
  factory _$$AchievementDetailImplCopyWith(
    _$AchievementDetailImpl value,
    $Res Function(_$AchievementDetailImpl) then,
  ) = __$$AchievementDetailImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({AchievementMilestone milestone, List<Requirement> requirements});

  @override
  $AchievementMilestoneCopyWith<$Res> get milestone;
}

/// @nodoc
class __$$AchievementDetailImplCopyWithImpl<$Res>
    extends _$AchievementDetailCopyWithImpl<$Res, _$AchievementDetailImpl>
    implements _$$AchievementDetailImplCopyWith<$Res> {
  __$$AchievementDetailImplCopyWithImpl(
    _$AchievementDetailImpl _value,
    $Res Function(_$AchievementDetailImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AchievementDetail
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? milestone = null, Object? requirements = null}) {
    return _then(
      _$AchievementDetailImpl(
        milestone: null == milestone
            ? _value.milestone
            : milestone // ignore: cast_nullable_to_non_nullable
                  as AchievementMilestone,
        requirements: null == requirements
            ? _value._requirements
            : requirements // ignore: cast_nullable_to_non_nullable
                  as List<Requirement>,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementDetailImpl implements _AchievementDetail {
  const _$AchievementDetailImpl({
    required this.milestone,
    final List<Requirement> requirements = const [],
  }) : _requirements = requirements;

  factory _$AchievementDetailImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementDetailImplFromJson(json);

  @override
  final AchievementMilestone milestone;
  final List<Requirement> _requirements;
  @override
  @JsonKey()
  List<Requirement> get requirements {
    if (_requirements is EqualUnmodifiableListView) return _requirements;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_requirements);
  }

  @override
  String toString() {
    return 'AchievementDetail(milestone: $milestone, requirements: $requirements)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementDetailImpl &&
            (identical(other.milestone, milestone) ||
                other.milestone == milestone) &&
            const DeepCollectionEquality().equals(
              other._requirements,
              _requirements,
            ));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    milestone,
    const DeepCollectionEquality().hash(_requirements),
  );

  /// Create a copy of AchievementDetail
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementDetailImplCopyWith<_$AchievementDetailImpl> get copyWith =>
      __$$AchievementDetailImplCopyWithImpl<_$AchievementDetailImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementDetailImplToJson(this);
  }
}

abstract class _AchievementDetail implements AchievementDetail {
  const factory _AchievementDetail({
    required final AchievementMilestone milestone,
    final List<Requirement> requirements,
  }) = _$AchievementDetailImpl;

  factory _AchievementDetail.fromJson(Map<String, dynamic> json) =
      _$AchievementDetailImpl.fromJson;

  @override
  AchievementMilestone get milestone;
  @override
  List<Requirement> get requirements;

  /// Create a copy of AchievementDetail
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementDetailImplCopyWith<_$AchievementDetailImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AchievementMilestone _$AchievementMilestoneFromJson(Map<String, dynamic> json) {
  return _AchievementMilestone.fromJson(json);
}

/// @nodoc
mixin _$AchievementMilestone {
  String get milestoneId => throw _privateConstructorUsedError;
  String? get icon => throw _privateConstructorUsedError;
  String get milestoneName => throw _privateConstructorUsedError;
  String get milestoneDescription => throw _privateConstructorUsedError;
  @JsonKey(name: 'achievedOn')
  DateTime? get achievedOn => throw _privateConstructorUsedError;

  /// Serializes this AchievementMilestone to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AchievementMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AchievementMilestoneCopyWith<AchievementMilestone> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AchievementMilestoneCopyWith<$Res> {
  factory $AchievementMilestoneCopyWith(
    AchievementMilestone value,
    $Res Function(AchievementMilestone) then,
  ) = _$AchievementMilestoneCopyWithImpl<$Res, AchievementMilestone>;
  @useResult
  $Res call({
    String milestoneId,
    String? icon,
    String milestoneName,
    String milestoneDescription,
    @JsonKey(name: 'achievedOn') DateTime? achievedOn,
  });
}

/// @nodoc
class _$AchievementMilestoneCopyWithImpl<
  $Res,
  $Val extends AchievementMilestone
>
    implements $AchievementMilestoneCopyWith<$Res> {
  _$AchievementMilestoneCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AchievementMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? milestoneId = null,
    Object? icon = freezed,
    Object? milestoneName = null,
    Object? milestoneDescription = null,
    Object? achievedOn = freezed,
  }) {
    return _then(
      _value.copyWith(
            milestoneId: null == milestoneId
                ? _value.milestoneId
                : milestoneId // ignore: cast_nullable_to_non_nullable
                      as String,
            icon: freezed == icon
                ? _value.icon
                : icon // ignore: cast_nullable_to_non_nullable
                      as String?,
            milestoneName: null == milestoneName
                ? _value.milestoneName
                : milestoneName // ignore: cast_nullable_to_non_nullable
                      as String,
            milestoneDescription: null == milestoneDescription
                ? _value.milestoneDescription
                : milestoneDescription // ignore: cast_nullable_to_non_nullable
                      as String,
            achievedOn: freezed == achievedOn
                ? _value.achievedOn
                : achievedOn // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$AchievementMilestoneImplCopyWith<$Res>
    implements $AchievementMilestoneCopyWith<$Res> {
  factory _$$AchievementMilestoneImplCopyWith(
    _$AchievementMilestoneImpl value,
    $Res Function(_$AchievementMilestoneImpl) then,
  ) = __$$AchievementMilestoneImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String milestoneId,
    String? icon,
    String milestoneName,
    String milestoneDescription,
    @JsonKey(name: 'achievedOn') DateTime? achievedOn,
  });
}

/// @nodoc
class __$$AchievementMilestoneImplCopyWithImpl<$Res>
    extends _$AchievementMilestoneCopyWithImpl<$Res, _$AchievementMilestoneImpl>
    implements _$$AchievementMilestoneImplCopyWith<$Res> {
  __$$AchievementMilestoneImplCopyWithImpl(
    _$AchievementMilestoneImpl _value,
    $Res Function(_$AchievementMilestoneImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of AchievementMilestone
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? milestoneId = null,
    Object? icon = freezed,
    Object? milestoneName = null,
    Object? milestoneDescription = null,
    Object? achievedOn = freezed,
  }) {
    return _then(
      _$AchievementMilestoneImpl(
        milestoneId: null == milestoneId
            ? _value.milestoneId
            : milestoneId // ignore: cast_nullable_to_non_nullable
                  as String,
        icon: freezed == icon
            ? _value.icon
            : icon // ignore: cast_nullable_to_non_nullable
                  as String?,
        milestoneName: null == milestoneName
            ? _value.milestoneName
            : milestoneName // ignore: cast_nullable_to_non_nullable
                  as String,
        milestoneDescription: null == milestoneDescription
            ? _value.milestoneDescription
            : milestoneDescription // ignore: cast_nullable_to_non_nullable
                  as String,
        achievedOn: freezed == achievedOn
            ? _value.achievedOn
            : achievedOn // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$AchievementMilestoneImpl implements _AchievementMilestone {
  const _$AchievementMilestoneImpl({
    required this.milestoneId,
    this.icon,
    required this.milestoneName,
    required this.milestoneDescription,
    @JsonKey(name: 'achievedOn') this.achievedOn,
  });

  factory _$AchievementMilestoneImpl.fromJson(Map<String, dynamic> json) =>
      _$$AchievementMilestoneImplFromJson(json);

  @override
  final String milestoneId;
  @override
  final String? icon;
  @override
  final String milestoneName;
  @override
  final String milestoneDescription;
  @override
  @JsonKey(name: 'achievedOn')
  final DateTime? achievedOn;

  @override
  String toString() {
    return 'AchievementMilestone(milestoneId: $milestoneId, icon: $icon, milestoneName: $milestoneName, milestoneDescription: $milestoneDescription, achievedOn: $achievedOn)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AchievementMilestoneImpl &&
            (identical(other.milestoneId, milestoneId) ||
                other.milestoneId == milestoneId) &&
            (identical(other.icon, icon) || other.icon == icon) &&
            (identical(other.milestoneName, milestoneName) ||
                other.milestoneName == milestoneName) &&
            (identical(other.milestoneDescription, milestoneDescription) ||
                other.milestoneDescription == milestoneDescription) &&
            (identical(other.achievedOn, achievedOn) ||
                other.achievedOn == achievedOn));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    milestoneId,
    icon,
    milestoneName,
    milestoneDescription,
    achievedOn,
  );

  /// Create a copy of AchievementMilestone
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AchievementMilestoneImplCopyWith<_$AchievementMilestoneImpl>
  get copyWith =>
      __$$AchievementMilestoneImplCopyWithImpl<_$AchievementMilestoneImpl>(
        this,
        _$identity,
      );

  @override
  Map<String, dynamic> toJson() {
    return _$$AchievementMilestoneImplToJson(this);
  }
}

abstract class _AchievementMilestone implements AchievementMilestone {
  const factory _AchievementMilestone({
    required final String milestoneId,
    final String? icon,
    required final String milestoneName,
    required final String milestoneDescription,
    @JsonKey(name: 'achievedOn') final DateTime? achievedOn,
  }) = _$AchievementMilestoneImpl;

  factory _AchievementMilestone.fromJson(Map<String, dynamic> json) =
      _$AchievementMilestoneImpl.fromJson;

  @override
  String get milestoneId;
  @override
  String? get icon;
  @override
  String get milestoneName;
  @override
  String get milestoneDescription;
  @override
  @JsonKey(name: 'achievedOn')
  DateTime? get achievedOn;

  /// Create a copy of AchievementMilestone
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AchievementMilestoneImplCopyWith<_$AchievementMilestoneImpl>
  get copyWith => throw _privateConstructorUsedError;
}

Requirement _$RequirementFromJson(Map<String, dynamic> json) {
  return _Requirement.fromJson(json);
}

/// @nodoc
mixin _$Requirement {
  int get progress => throw _privateConstructorUsedError;
  int get quota => throw _privateConstructorUsedError;
  String get timeFrame => throw _privateConstructorUsedError;

  /// Serializes this Requirement to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Requirement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RequirementCopyWith<Requirement> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequirementCopyWith<$Res> {
  factory $RequirementCopyWith(
    Requirement value,
    $Res Function(Requirement) then,
  ) = _$RequirementCopyWithImpl<$Res, Requirement>;
  @useResult
  $Res call({int progress, int quota, String timeFrame});
}

/// @nodoc
class _$RequirementCopyWithImpl<$Res, $Val extends Requirement>
    implements $RequirementCopyWith<$Res> {
  _$RequirementCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Requirement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? quota = null,
    Object? timeFrame = null,
  }) {
    return _then(
      _value.copyWith(
            progress: null == progress
                ? _value.progress
                : progress // ignore: cast_nullable_to_non_nullable
                      as int,
            quota: null == quota
                ? _value.quota
                : quota // ignore: cast_nullable_to_non_nullable
                      as int,
            timeFrame: null == timeFrame
                ? _value.timeFrame
                : timeFrame // ignore: cast_nullable_to_non_nullable
                      as String,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$RequirementImplCopyWith<$Res>
    implements $RequirementCopyWith<$Res> {
  factory _$$RequirementImplCopyWith(
    _$RequirementImpl value,
    $Res Function(_$RequirementImpl) then,
  ) = __$$RequirementImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int progress, int quota, String timeFrame});
}

/// @nodoc
class __$$RequirementImplCopyWithImpl<$Res>
    extends _$RequirementCopyWithImpl<$Res, _$RequirementImpl>
    implements _$$RequirementImplCopyWith<$Res> {
  __$$RequirementImplCopyWithImpl(
    _$RequirementImpl _value,
    $Res Function(_$RequirementImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of Requirement
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? progress = null,
    Object? quota = null,
    Object? timeFrame = null,
  }) {
    return _then(
      _$RequirementImpl(
        progress: null == progress
            ? _value.progress
            : progress // ignore: cast_nullable_to_non_nullable
                  as int,
        quota: null == quota
            ? _value.quota
            : quota // ignore: cast_nullable_to_non_nullable
                  as int,
        timeFrame: null == timeFrame
            ? _value.timeFrame
            : timeFrame // ignore: cast_nullable_to_non_nullable
                  as String,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$RequirementImpl implements _Requirement {
  const _$RequirementImpl({
    this.progress = 0,
    this.quota = 0,
    required this.timeFrame,
  });

  factory _$RequirementImpl.fromJson(Map<String, dynamic> json) =>
      _$$RequirementImplFromJson(json);

  @override
  @JsonKey()
  final int progress;
  @override
  @JsonKey()
  final int quota;
  @override
  final String timeFrame;

  @override
  String toString() {
    return 'Requirement(progress: $progress, quota: $quota, timeFrame: $timeFrame)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RequirementImpl &&
            (identical(other.progress, progress) ||
                other.progress == progress) &&
            (identical(other.quota, quota) || other.quota == quota) &&
            (identical(other.timeFrame, timeFrame) ||
                other.timeFrame == timeFrame));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, progress, quota, timeFrame);

  /// Create a copy of Requirement
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RequirementImplCopyWith<_$RequirementImpl> get copyWith =>
      __$$RequirementImplCopyWithImpl<_$RequirementImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RequirementImplToJson(this);
  }
}

abstract class _Requirement implements Requirement {
  const factory _Requirement({
    final int progress,
    final int quota,
    required final String timeFrame,
  }) = _$RequirementImpl;

  factory _Requirement.fromJson(Map<String, dynamic> json) =
      _$RequirementImpl.fromJson;

  @override
  int get progress;
  @override
  int get quota;
  @override
  String get timeFrame;

  /// Create a copy of Requirement
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RequirementImplCopyWith<_$RequirementImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
