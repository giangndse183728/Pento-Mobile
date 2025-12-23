// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trade_offers_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TradeOfferItemImpl _$$TradeOfferItemImplFromJson(Map<String, dynamic> json) =>
    _$TradeOfferItemImpl(
      itemId: json['itemId'] as String,
      foodItemId: json['foodItemId'] as String,
      foodName: json['foodName'] as String,
      foodImageUri: json['foodImageUri'] as String?,
      quantity: (json['quantity'] as num).toDouble(),
      unitAbbreviation: json['unitAbbreviation'] as String,
    );

Map<String, dynamic> _$$TradeOfferItemImplToJson(
  _$TradeOfferItemImpl instance,
) => <String, dynamic>{
  'itemId': instance.itemId,
  'foodItemId': instance.foodItemId,
  'foodName': instance.foodName,
  'foodImageUri': instance.foodImageUri,
  'quantity': instance.quantity,
  'unitAbbreviation': instance.unitAbbreviation,
};

_$TradeOfferImpl _$$TradeOfferImplFromJson(Map<String, dynamic> json) =>
    _$TradeOfferImpl(
      offerId: json['offerId'] as String,
      status: json['status'] as String,
      pendingRequests: (json['pendingRequests'] as num?)?.toInt() ?? 0,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      pickupOption: json['pickupOption'] as String,
      postedBy: json['postedBy'] as String,
      createdOnUtc: DateTime.parse(json['createdOnUtc'] as String),
      postedByName: json['postedByName'] as String?,
      postedByAvatarUrl: json['postedByAvatarUrl'] as String?,
      items:
          (json['items'] as List<dynamic>?)
              ?.map((e) => TradeOfferItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TradeOfferImplToJson(_$TradeOfferImpl instance) =>
    <String, dynamic>{
      'offerId': instance.offerId,
      'status': instance.status,
      'pendingRequests': instance.pendingRequests,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'pickupOption': instance.pickupOption,
      'postedBy': instance.postedBy,
      'createdOnUtc': instance.createdOnUtc.toIso8601String(),
      'postedByName': instance.postedByName,
      'postedByAvatarUrl': instance.postedByAvatarUrl,
      'items': instance.items,
    };

_$PaginatedTradeOffersImpl _$$PaginatedTradeOffersImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedTradeOffersImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => TradeOffer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 12,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  hasPrevious: json['hasPrevious'] as bool? ?? false,
  hasNext: json['hasNext'] as bool? ?? false,
);

Map<String, dynamic> _$$PaginatedTradeOffersImplToJson(
  _$PaginatedTradeOffersImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
};

_$CreateTradeOfferItemImpl _$$CreateTradeOfferItemImplFromJson(
  Map<String, dynamic> json,
) => _$CreateTradeOfferItemImpl(
  foodItemId: json['foodItemId'] as String,
  quantity: (json['quantity'] as num).toDouble(),
  unitId: json['unitId'] as String,
);

Map<String, dynamic> _$$CreateTradeOfferItemImplToJson(
  _$CreateTradeOfferItemImpl instance,
) => <String, dynamic>{
  'foodItemId': instance.foodItemId,
  'quantity': instance.quantity,
  'unitId': instance.unitId,
};

_$CreateTradeOfferRequestImpl _$$CreateTradeOfferRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateTradeOfferRequestImpl(
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  pickupOption: json['pickupOption'] as String,
  items: (json['items'] as List<dynamic>)
      .map((e) => CreateTradeOfferItem.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$$CreateTradeOfferRequestImplToJson(
  _$CreateTradeOfferRequestImpl instance,
) => <String, dynamic>{
  'startDate': instance.startDate.toIso8601String(),
  'endDate': instance.endDate.toIso8601String(),
  'pickupOption': instance.pickupOption,
  'items': instance.items,
};

_$MyPostImpl _$$MyPostImplFromJson(Map<String, dynamic> json) => _$MyPostImpl(
  offerId: json['offerId'] as String,
  itemId: json['itemId'] as String,
  foodItemId: json['foodItemId'] as String,
  foodName: json['foodName'] as String,
  foodImageUri: json['foodImageUri'] as String?,
  postedByName: json['postedByName'] as String?,
  postedByAvatarUrl: json['postedByAvatarUrl'] as String?,
  quantity: (json['quantity'] as num).toDouble(),
  unitAbbreviation: json['unitAbbreviation'] as String,
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  pickupOption: json['pickupOption'] as String,
  postedBy: json['postedBy'] as String,
  createdOnUtc: DateTime.parse(json['createdOnUtc'] as String),
);

Map<String, dynamic> _$$MyPostImplToJson(_$MyPostImpl instance) =>
    <String, dynamic>{
      'offerId': instance.offerId,
      'itemId': instance.itemId,
      'foodItemId': instance.foodItemId,
      'foodName': instance.foodName,
      'foodImageUri': instance.foodImageUri,
      'postedByName': instance.postedByName,
      'postedByAvatarUrl': instance.postedByAvatarUrl,
      'quantity': instance.quantity,
      'unitAbbreviation': instance.unitAbbreviation,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'pickupOption': instance.pickupOption,
      'postedBy': instance.postedBy,
      'createdOnUtc': instance.createdOnUtc.toIso8601String(),
    };

_$TradeRequestItemImpl _$$TradeRequestItemImplFromJson(
  Map<String, dynamic> json,
) => _$TradeRequestItemImpl(
  itemId: json['itemId'] as String,
  foodItemId: json['foodItemId'] as String,
  foodName: json['foodName'] as String,
  foodImageUri: json['foodImageUri'] as String?,
  quantity: (json['quantity'] as num).toDouble(),
  unitAbbreviation: json['unitAbbreviation'] as String,
);

Map<String, dynamic> _$$TradeRequestItemImplToJson(
  _$TradeRequestItemImpl instance,
) => <String, dynamic>{
  'itemId': instance.itemId,
  'foodItemId': instance.foodItemId,
  'foodName': instance.foodName,
  'foodImageUri': instance.foodImageUri,
  'quantity': instance.quantity,
  'unitAbbreviation': instance.unitAbbreviation,
};

_$TradeRequestImpl _$$TradeRequestImplFromJson(Map<String, dynamic> json) =>
    _$TradeRequestImpl(
      tradeRequestId: json['tradeRequestId'] as String,
      tradeOfferId: json['tradeOfferId'] as String,
      offerHouseholdName: json['offerHouseholdName'] as String,
      requestHouseholdName: json['requestHouseholdName'] as String,
      status: json['status'] as String,
      createdOn: DateTime.parse(json['createdOn'] as String),
      updatedOn: DateTime.parse(json['updatedOn'] as String),
      totalItems: (json['totalItems'] as num).toInt(),
    );

Map<String, dynamic> _$$TradeRequestImplToJson(_$TradeRequestImpl instance) =>
    <String, dynamic>{
      'tradeRequestId': instance.tradeRequestId,
      'tradeOfferId': instance.tradeOfferId,
      'offerHouseholdName': instance.offerHouseholdName,
      'requestHouseholdName': instance.requestHouseholdName,
      'status': instance.status,
      'createdOn': instance.createdOn.toIso8601String(),
      'updatedOn': instance.updatedOn.toIso8601String(),
      'totalItems': instance.totalItems,
    };

_$PaginatedTradeRequestsImpl _$$PaginatedTradeRequestsImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedTradeRequestsImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => TradeRequest.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  hasPrevious: json['hasPrevious'] as bool? ?? false,
  hasNext: json['hasNext'] as bool? ?? false,
);

Map<String, dynamic> _$$PaginatedTradeRequestsImplToJson(
  _$PaginatedTradeRequestsImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
};

_$TradeSessionImpl _$$TradeSessionImplFromJson(Map<String, dynamic> json) =>
    _$TradeSessionImpl(
      tradeSessionId: json['tradeSessionId'] as String,
      status: json['status'] as String,
      startedOn: DateTime.parse(json['startedOn'] as String),
      totalOfferedItems: (json['totalOfferedItems'] as num).toInt(),
      totalRequestedItems: (json['totalRequestedItems'] as num).toInt(),
      avatarUrls:
          (json['avatarUrls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$TradeSessionImplToJson(_$TradeSessionImpl instance) =>
    <String, dynamic>{
      'tradeSessionId': instance.tradeSessionId,
      'status': instance.status,
      'startedOn': instance.startedOn.toIso8601String(),
      'totalOfferedItems': instance.totalOfferedItems,
      'totalRequestedItems': instance.totalRequestedItems,
      'avatarUrls': instance.avatarUrls,
    };

_$PaginatedTradeSessionsImpl _$$PaginatedTradeSessionsImplFromJson(
  Map<String, dynamic> json,
) => _$PaginatedTradeSessionsImpl(
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => TradeSession.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  currentPage: (json['currentPage'] as num?)?.toInt() ?? 1,
  totalPages: (json['totalPages'] as num?)?.toInt() ?? 1,
  pageSize: (json['pageSize'] as num?)?.toInt() ?? 10,
  totalCount: (json['totalCount'] as num?)?.toInt() ?? 0,
  hasPrevious: json['hasPrevious'] as bool? ?? false,
  hasNext: json['hasNext'] as bool? ?? false,
);

Map<String, dynamic> _$$PaginatedTradeSessionsImplToJson(
  _$PaginatedTradeSessionsImpl instance,
) => <String, dynamic>{
  'items': instance.items,
  'currentPage': instance.currentPage,
  'totalPages': instance.totalPages,
  'pageSize': instance.pageSize,
  'totalCount': instance.totalCount,
  'hasPrevious': instance.hasPrevious,
  'hasNext': instance.hasNext,
};

_$TradeSessionUserImpl _$$TradeSessionUserImplFromJson(
  Map<String, dynamic> json,
) => _$TradeSessionUserImpl(
  userId: json['userId'] as String,
  firstName: json['firstName'] as String,
  lastName: json['lastName'] as String,
  avatarUrl: json['avatarUrl'] as String?,
);

Map<String, dynamic> _$$TradeSessionUserImplToJson(
  _$TradeSessionUserImpl instance,
) => <String, dynamic>{
  'userId': instance.userId,
  'firstName': instance.firstName,
  'lastName': instance.lastName,
  'avatarUrl': instance.avatarUrl,
};

_$TradeSessionInfoImpl _$$TradeSessionInfoImplFromJson(
  Map<String, dynamic> json,
) => _$TradeSessionInfoImpl(
  tradeSessionId: json['tradeSessionId'] as String,
  tradeOfferId: json['tradeOfferId'] as String,
  tradeRequestId: json['tradeRequestId'] as String,
  offerHouseholdId: json['offerHouseholdId'] as String,
  offerHouseholdName: json['offerHouseholdName'] as String,
  requestHouseholdId: json['requestHouseholdId'] as String,
  requestHouseholdName: json['requestHouseholdName'] as String,
  status: json['status'] as String,
  startedOn: DateTime.parse(json['startedOn'] as String),
  totalOfferedItems: (json['totalOfferedItems'] as num).toInt(),
  totalRequestedItems: (json['totalRequestedItems'] as num).toInt(),
  confirmedByOfferUser: json['confirmedByOfferUser'] == null
      ? null
      : TradeSessionUser.fromJson(
          json['confirmedByOfferUser'] as Map<String, dynamic>,
        ),
  confirmedByRequestUser: json['confirmedByRequestUser'] == null
      ? null
      : TradeSessionUser.fromJson(
          json['confirmedByRequestUser'] as Map<String, dynamic>,
        ),
);

Map<String, dynamic> _$$TradeSessionInfoImplToJson(
  _$TradeSessionInfoImpl instance,
) => <String, dynamic>{
  'tradeSessionId': instance.tradeSessionId,
  'tradeOfferId': instance.tradeOfferId,
  'tradeRequestId': instance.tradeRequestId,
  'offerHouseholdId': instance.offerHouseholdId,
  'offerHouseholdName': instance.offerHouseholdName,
  'requestHouseholdId': instance.requestHouseholdId,
  'requestHouseholdName': instance.requestHouseholdName,
  'status': instance.status,
  'startedOn': instance.startedOn.toIso8601String(),
  'totalOfferedItems': instance.totalOfferedItems,
  'totalRequestedItems': instance.totalRequestedItems,
  'confirmedByOfferUser': instance.confirmedByOfferUser,
  'confirmedByRequestUser': instance.confirmedByRequestUser,
};

_$TradeSessionMessageImpl _$$TradeSessionMessageImplFromJson(
  Map<String, dynamic> json,
) => _$TradeSessionMessageImpl(
  tradeSessionMessageId: json['tradeSessionMessageId'] as String,
  user: TradeSessionUser.fromJson(json['user'] as Map<String, dynamic>),
  messageText: json['messageText'] as String,
  sentOn: DateTime.parse(json['sentOn'] as String),
);

Map<String, dynamic> _$$TradeSessionMessageImplToJson(
  _$TradeSessionMessageImpl instance,
) => <String, dynamic>{
  'tradeSessionMessageId': instance.tradeSessionMessageId,
  'user': instance.user,
  'messageText': instance.messageText,
  'sentOn': instance.sentOn.toIso8601String(),
};

_$TradeSessionItemImpl _$$TradeSessionItemImplFromJson(
  Map<String, dynamic> json,
) => _$TradeSessionItemImpl(
  tradeItemId: json['tradeItemId'] as String,
  foodItemId: json['foodItemId'] as String,
  name: json['name'] as String,
  originalName: json['originalName'] as String,
  imageUrl: json['imageUrl'] as String?,
  foodGroup: json['foodGroup'] as String,
  quantity: (json['quantity'] as num).toDouble(),
  unitAbbreviation: json['unitAbbreviation'] as String,
  unitId: json['unitId'] as String,
  expirationDate: json['expirationDate'] as String,
  from: json['from'] as String,
);

Map<String, dynamic> _$$TradeSessionItemImplToJson(
  _$TradeSessionItemImpl instance,
) => <String, dynamic>{
  'tradeItemId': instance.tradeItemId,
  'foodItemId': instance.foodItemId,
  'name': instance.name,
  'originalName': instance.originalName,
  'imageUrl': instance.imageUrl,
  'foodGroup': instance.foodGroup,
  'quantity': instance.quantity,
  'unitAbbreviation': instance.unitAbbreviation,
  'unitId': instance.unitId,
  'expirationDate': instance.expirationDate,
  'from': instance.from,
};

_$TradeSessionDetailImpl _$$TradeSessionDetailImplFromJson(
  Map<String, dynamic> json,
) => _$TradeSessionDetailImpl(
  tradeSession: TradeSessionInfo.fromJson(
    json['tradeSession'] as Map<String, dynamic>,
  ),
  messages:
      (json['messages'] as List<dynamic>?)
          ?.map((e) => TradeSessionMessage.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  items:
      (json['items'] as List<dynamic>?)
          ?.map((e) => TradeSessionItem.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TradeSessionDetailImplToJson(
  _$TradeSessionDetailImpl instance,
) => <String, dynamic>{
  'tradeSession': instance.tradeSession,
  'messages': instance.messages,
  'items': instance.items,
};

_$TradeRequestDetailItemImpl _$$TradeRequestDetailItemImplFromJson(
  Map<String, dynamic> json,
) => _$TradeRequestDetailItemImpl(
  tradeItemId: json['tradeItemId'] as String,
  foodItemId: json['foodItemId'] as String,
  name: json['name'] as String,
  originalName: json['originalName'] as String,
  imageUrl: json['imageUrl'] as String?,
  foodGroup: json['foodGroup'] as String,
  quantity: (json['quantity'] as num).toDouble(),
  unitAbbreviation: json['unitAbbreviation'] as String,
  unitId: json['unitId'] as String,
  expirationDate: json['expirationDate'] as String,
  from: json['from'] as String,
);

Map<String, dynamic> _$$TradeRequestDetailItemImplToJson(
  _$TradeRequestDetailItemImpl instance,
) => <String, dynamic>{
  'tradeItemId': instance.tradeItemId,
  'foodItemId': instance.foodItemId,
  'name': instance.name,
  'originalName': instance.originalName,
  'imageUrl': instance.imageUrl,
  'foodGroup': instance.foodGroup,
  'quantity': instance.quantity,
  'unitAbbreviation': instance.unitAbbreviation,
  'unitId': instance.unitId,
  'expirationDate': instance.expirationDate,
  'from': instance.from,
};

_$TradeRequestDetailImpl _$$TradeRequestDetailImplFromJson(
  Map<String, dynamic> json,
) => _$TradeRequestDetailImpl(
  tradeRequest: TradeRequest.fromJson(
    json['tradeRequest'] as Map<String, dynamic>,
  ),
  items:
      (json['items'] as List<dynamic>?)
          ?.map(
            (e) => TradeRequestDetailItem.fromJson(e as Map<String, dynamic>),
          )
          .toList() ??
      const [],
);

Map<String, dynamic> _$$TradeRequestDetailImplToJson(
  _$TradeRequestDetailImpl instance,
) => <String, dynamic>{
  'tradeRequest': instance.tradeRequest,
  'items': instance.items,
};

_$CreateTradeReportRequestImpl _$$CreateTradeReportRequestImplFromJson(
  Map<String, dynamic> json,
) => _$CreateTradeReportRequestImpl(
  tradeSessionId: json['tradeSessionId'] as String,
  reason: $enumDecode(_$TradeReportReasonEnumMap, json['reason']),
  severity: $enumDecode(_$FoodSafetyIssueLevelEnumMap, json['severity']),
  description: json['description'] as String,
);

Map<String, dynamic> _$$CreateTradeReportRequestImplToJson(
  _$CreateTradeReportRequestImpl instance,
) => <String, dynamic>{
  'tradeSessionId': instance.tradeSessionId,
  'reason': _$TradeReportReasonEnumMap[instance.reason]!,
  'severity': _$FoodSafetyIssueLevelEnumMap[instance.severity]!,
  'description': instance.description,
};

const _$TradeReportReasonEnumMap = {
  TradeReportReason.foodSafetyConcern: 'FoodSafetyConcern',
  TradeReportReason.expiredFood: 'ExpiredFood',
  TradeReportReason.poorHygiene: 'PoorHygiene',
  TradeReportReason.misleadingInformation: 'MisleadingInformation',
  TradeReportReason.inappropriateBehavior: 'InappropriateBehavior',
  TradeReportReason.other: 'Other',
};

const _$FoodSafetyIssueLevelEnumMap = {
  FoodSafetyIssueLevel.minor: 'Minor',
  FoodSafetyIssueLevel.serious: 'Serious',
  FoodSafetyIssueLevel.critical: 'Critical',
};

_$TradeReportResponseImpl _$$TradeReportResponseImplFromJson(
  Map<String, dynamic> json,
) => _$TradeReportResponseImpl(
  tradeReportId: json['tradeReportId'] as String,
  tradeSessionId: json['tradeSessionId'] as String,
  reason: json['reason'] as String,
  severity: json['severity'] as String,
  description: json['description'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$$TradeReportResponseImplToJson(
  _$TradeReportResponseImpl instance,
) => <String, dynamic>{
  'tradeReportId': instance.tradeReportId,
  'tradeSessionId': instance.tradeSessionId,
  'reason': instance.reason,
  'severity': instance.severity,
  'description': instance.description,
  'createdAt': instance.createdAt.toIso8601String(),
};
