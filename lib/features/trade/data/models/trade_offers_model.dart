// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'trade_offers_model.freezed.dart';
part 'trade_offers_model.g.dart';

@freezed
class TradeOfferItem with _$TradeOfferItem {
  const factory TradeOfferItem({
    @JsonKey(name: 'itemId') required String itemId,
    @JsonKey(name: 'foodItemId') required String foodItemId,
    @JsonKey(name: 'foodName') required String foodName,
    @JsonKey(name: 'foodImageUri') String? foodImageUri,
    @JsonKey(name: 'quantity') required double quantity,
    @JsonKey(name: 'unitAbbreviation') required String unitAbbreviation,
  }) = _TradeOfferItem;

  factory TradeOfferItem.fromJson(Map<String, dynamic> json) =>
      _$TradeOfferItemFromJson(json);
}

@freezed
class TradeOffer with _$TradeOffer {
  const factory TradeOffer({
    @JsonKey(name: 'offerId') required String offerId,
    @JsonKey(name: 'startDate') required DateTime startDate,
    @JsonKey(name: 'endDate') required DateTime endDate,
    @JsonKey(name: 'pickupOption') required String pickupOption,
    @JsonKey(name: 'postedBy') required String postedBy,
    @JsonKey(name: 'createdOnUtc') required DateTime createdOnUtc,
    @JsonKey(name: 'postedByName') String? postedByName,
    @JsonKey(name: 'postedByAvatarUrl') String? postedByAvatarUrl,
    @JsonKey(name: 'items') @Default([]) List<TradeOfferItem> items,
  }) = _TradeOffer;

  factory TradeOffer.fromJson(Map<String, dynamic> json) =>
      _$TradeOfferFromJson(json);
}

@freezed
class PaginatedTradeOffers with _$PaginatedTradeOffers {
  const factory PaginatedTradeOffers({
    @Default([]) List<TradeOffer> items,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(12) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
  }) = _PaginatedTradeOffers;

  factory PaginatedTradeOffers.fromJson(Map<String, dynamic> json) =>
      _$PaginatedTradeOffersFromJson(json);
}

@freezed
class CreateTradeOfferItem with _$CreateTradeOfferItem {
  const factory CreateTradeOfferItem({
    @JsonKey(name: 'foodItemId') required String foodItemId,
    @JsonKey(name: 'quantity') required double quantity,
    @JsonKey(name: 'unitId') required String unitId,
    }) = _CreateTradeOfferItem;

  factory CreateTradeOfferItem.fromJson(Map<String, dynamic> json) =>
      _$CreateTradeOfferItemFromJson(json);
}

@freezed
class CreateTradeOfferRequest with _$CreateTradeOfferRequest {
  const factory CreateTradeOfferRequest({
    @JsonKey(name: 'startDate') required DateTime startDate,
    @JsonKey(name: 'endDate') required DateTime endDate,
    @JsonKey(name: 'pickupOption') required String pickupOption,
    @JsonKey(name: 'items') required List<CreateTradeOfferItem> items,
  }) = _CreateTradeOfferRequest;

  factory CreateTradeOfferRequest.fromJson(Map<String, dynamic> json) =>
      _$CreateTradeOfferRequestFromJson(json);
}

@freezed
class MyPost with _$MyPost {
  const factory MyPost({
    @JsonKey(name: 'offerId') required String offerId,
    @JsonKey(name: 'itemId') required String itemId,
    @JsonKey(name: 'foodItemId') required String foodItemId,
    @JsonKey(name: 'foodName') required String foodName,
    @JsonKey(name: 'foodImageUri') String? foodImageUri,
    @JsonKey(name: 'postedByName') String? postedByName,
    @JsonKey(name: 'postedByAvatarUrl') String? postedByAvatarUrl,
    @JsonKey(name: 'quantity') required double quantity,
    @JsonKey(name: 'unitAbbreviation') required String unitAbbreviation,
    @JsonKey(name: 'startDate') required DateTime startDate,
    @JsonKey(name: 'endDate') required DateTime endDate,
    @JsonKey(name: 'pickupOption') required String pickupOption,
    @JsonKey(name: 'postedBy') required String postedBy,
    @JsonKey(name: 'createdOnUtc') required DateTime createdOnUtc,
  }) = _MyPost;

  factory MyPost.fromJson(Map<String, dynamic> json) =>
      _$MyPostFromJson(json);
}

@freezed
class TradeRequestItem with _$TradeRequestItem {
  const factory TradeRequestItem({
    @JsonKey(name: 'itemId') required String itemId,
    @JsonKey(name: 'foodItemId') required String foodItemId,
    @JsonKey(name: 'foodName') required String foodName,
    @JsonKey(name: 'foodImageUri') String? foodImageUri,
    @JsonKey(name: 'quantity') required double quantity,
    @JsonKey(name: 'unitAbbreviation') required String unitAbbreviation,
  }) = _TradeRequestItem;

  factory TradeRequestItem.fromJson(Map<String, dynamic> json) =>
      _$TradeRequestItemFromJson(json);
}

@freezed
class TradeRequest with _$TradeRequest {
  const factory TradeRequest({
    @JsonKey(name: 'requestId') required String requestId,
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'firstName') required String firstName,
    @JsonKey(name: 'avatarUrl') String? avatarUrl,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'createdOn') required DateTime createdOn,
    @JsonKey(name: 'items') @Default([]) List<TradeRequestItem> items,
  }) = _TradeRequest;

  factory TradeRequest.fromJson(Map<String, dynamic> json) =>
      _$TradeRequestFromJson(json);
}

// Trade Session Models
@freezed
class TradeSession with _$TradeSession {
  const factory TradeSession({
    @JsonKey(name: 'tradeSessionId') required String tradeSessionId,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'startedOn') required DateTime startedOn,
    @JsonKey(name: 'totalOfferedItems') required int totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems') required int totalRequestedItems,
    @JsonKey(name: 'avatarUrls') @Default([]) List<String> avatarUrls,
  }) = _TradeSession;

  factory TradeSession.fromJson(Map<String, dynamic> json) =>
      _$TradeSessionFromJson(json);
}

@freezed
class PaginatedTradeSessions with _$PaginatedTradeSessions {
  const factory PaginatedTradeSessions({
    @Default([]) List<TradeSession> items,
    @Default(1) int currentPage,
    @Default(1) int totalPages,
    @Default(10) int pageSize,
    @Default(0) int totalCount,
    @Default(false) bool hasPrevious,
    @Default(false) bool hasNext,
  }) = _PaginatedTradeSessions;

  factory PaginatedTradeSessions.fromJson(Map<String, dynamic> json) =>
      _$PaginatedTradeSessionsFromJson(json);
}

@freezed
class TradeSessionUser with _$TradeSessionUser {
  const factory TradeSessionUser({
    @JsonKey(name: 'userId') required String userId,
    @JsonKey(name: 'firstName') required String firstName,
    @JsonKey(name: 'lastName') required String lastName,
    @JsonKey(name: 'avatarUrl') String? avatarUrl,
  }) = _TradeSessionUser;

  factory TradeSessionUser.fromJson(Map<String, dynamic> json) =>
      _$TradeSessionUserFromJson(json);
}

@freezed
class TradeSessionInfo with _$TradeSessionInfo {
  const factory TradeSessionInfo({
    @JsonKey(name: 'tradeSessionId') required String tradeSessionId,
    @JsonKey(name: 'tradeOfferId') required String tradeOfferId,
    @JsonKey(name: 'tradeRequestId') required String tradeRequestId,
    @JsonKey(name: 'offerHouseholdId') required String offerHouseholdId,
    @JsonKey(name: 'offerHouseholdName') required String offerHouseholdName,
    @JsonKey(name: 'requestHouseholdId') required String requestHouseholdId,
    @JsonKey(name: 'requestHouseholdName') required String requestHouseholdName,
    @JsonKey(name: 'status') required String status,
    @JsonKey(name: 'startedOn') required DateTime startedOn,
    @JsonKey(name: 'totalOfferedItems') required int totalOfferedItems,
    @JsonKey(name: 'totalRequestedItems') required int totalRequestedItems,
    @JsonKey(name: 'confirmedByOfferUser') TradeSessionUser? confirmedByOfferUser,
    @JsonKey(name: 'confirmedByRequestUser') TradeSessionUser? confirmedByRequestUser,
  }) = _TradeSessionInfo;

  factory TradeSessionInfo.fromJson(Map<String, dynamic> json) =>
      _$TradeSessionInfoFromJson(json);
}

@freezed
class TradeSessionMessage with _$TradeSessionMessage {
  const factory TradeSessionMessage({
    @JsonKey(name: 'tradeSessionMessageId') required String tradeSessionMessageId,
    @JsonKey(name: 'user') required TradeSessionUser user,
    @JsonKey(name: 'messageText') required String messageText,
    @JsonKey(name: 'sentOn') required DateTime sentOn,
  }) = _TradeSessionMessage;

  factory TradeSessionMessage.fromJson(Map<String, dynamic> json) =>
      _$TradeSessionMessageFromJson(json);
}

@freezed
class TradeSessionItem with _$TradeSessionItem {
  const factory TradeSessionItem({
    @JsonKey(name: 'tradeItemId') required String tradeItemId,
    @JsonKey(name: 'foodItemId') required String foodItemId,
    @JsonKey(name: 'name') required String name,
    @JsonKey(name: 'originalName') required String originalName,
    @JsonKey(name: 'imageUrl') String? imageUrl,
    @JsonKey(name: 'foodGroup') required String foodGroup,
    @JsonKey(name: 'quantity') required double quantity,
    @JsonKey(name: 'unitAbbreviation') required String unitAbbreviation,
    @JsonKey(name: 'unitId') required String unitId,
    @JsonKey(name: 'expirationDate') required String expirationDate,
    @JsonKey(name: 'from') required String from,
  }) = _TradeSessionItem;

  factory TradeSessionItem.fromJson(Map<String, dynamic> json) =>
      _$TradeSessionItemFromJson(json);
}

@freezed
class TradeSessionDetail with _$TradeSessionDetail {
  const factory TradeSessionDetail({
    @JsonKey(name: 'tradeSession') required TradeSessionInfo tradeSession,
    @JsonKey(name: 'messages') @Default([]) List<TradeSessionMessage> messages,
    @JsonKey(name: 'items') @Default([]) List<TradeSessionItem> items,
  }) = _TradeSessionDetail;

  factory TradeSessionDetail.fromJson(Map<String, dynamic> json) =>
      _$TradeSessionDetailFromJson(json);
}

