// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chatbot_provider.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$ChatbotState {
  List<ChatMessage> get messages => throw _privateConstructorUsedError;
  bool get isSending => throw _privateConstructorUsedError;
  String? get errorMessage => throw _privateConstructorUsedError;
  int? get errorStatusCode => throw _privateConstructorUsedError;

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ChatbotStateCopyWith<ChatbotState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatbotStateCopyWith<$Res> {
  factory $ChatbotStateCopyWith(
    ChatbotState value,
    $Res Function(ChatbotState) then,
  ) = _$ChatbotStateCopyWithImpl<$Res, ChatbotState>;
  @useResult
  $Res call({
    List<ChatMessage> messages,
    bool isSending,
    String? errorMessage,
    int? errorStatusCode,
  });
}

/// @nodoc
class _$ChatbotStateCopyWithImpl<$Res, $Val extends ChatbotState>
    implements $ChatbotStateCopyWith<$Res> {
  _$ChatbotStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? isSending = null,
    Object? errorMessage = freezed,
    Object? errorStatusCode = freezed,
  }) {
    return _then(
      _value.copyWith(
            messages: null == messages
                ? _value.messages
                : messages // ignore: cast_nullable_to_non_nullable
                      as List<ChatMessage>,
            isSending: null == isSending
                ? _value.isSending
                : isSending // ignore: cast_nullable_to_non_nullable
                      as bool,
            errorMessage: freezed == errorMessage
                ? _value.errorMessage
                : errorMessage // ignore: cast_nullable_to_non_nullable
                      as String?,
            errorStatusCode: freezed == errorStatusCode
                ? _value.errorStatusCode
                : errorStatusCode // ignore: cast_nullable_to_non_nullable
                      as int?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ChatbotStateImplCopyWith<$Res>
    implements $ChatbotStateCopyWith<$Res> {
  factory _$$ChatbotStateImplCopyWith(
    _$ChatbotStateImpl value,
    $Res Function(_$ChatbotStateImpl) then,
  ) = __$$ChatbotStateImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    List<ChatMessage> messages,
    bool isSending,
    String? errorMessage,
    int? errorStatusCode,
  });
}

/// @nodoc
class __$$ChatbotStateImplCopyWithImpl<$Res>
    extends _$ChatbotStateCopyWithImpl<$Res, _$ChatbotStateImpl>
    implements _$$ChatbotStateImplCopyWith<$Res> {
  __$$ChatbotStateImplCopyWithImpl(
    _$ChatbotStateImpl _value,
    $Res Function(_$ChatbotStateImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? messages = null,
    Object? isSending = null,
    Object? errorMessage = freezed,
    Object? errorStatusCode = freezed,
  }) {
    return _then(
      _$ChatbotStateImpl(
        messages: null == messages
            ? _value._messages
            : messages // ignore: cast_nullable_to_non_nullable
                  as List<ChatMessage>,
        isSending: null == isSending
            ? _value.isSending
            : isSending // ignore: cast_nullable_to_non_nullable
                  as bool,
        errorMessage: freezed == errorMessage
            ? _value.errorMessage
            : errorMessage // ignore: cast_nullable_to_non_nullable
                  as String?,
        errorStatusCode: freezed == errorStatusCode
            ? _value.errorStatusCode
            : errorStatusCode // ignore: cast_nullable_to_non_nullable
                  as int?,
      ),
    );
  }
}

/// @nodoc

class _$ChatbotStateImpl implements _ChatbotState {
  const _$ChatbotStateImpl({
    final List<ChatMessage> messages = const <ChatMessage>[],
    this.isSending = false,
    this.errorMessage,
    this.errorStatusCode,
  }) : _messages = messages;

  final List<ChatMessage> _messages;
  @override
  @JsonKey()
  List<ChatMessage> get messages {
    if (_messages is EqualUnmodifiableListView) return _messages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_messages);
  }

  @override
  @JsonKey()
  final bool isSending;
  @override
  final String? errorMessage;
  @override
  final int? errorStatusCode;

  @override
  String toString() {
    return 'ChatbotState(messages: $messages, isSending: $isSending, errorMessage: $errorMessage, errorStatusCode: $errorStatusCode)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ChatbotStateImpl &&
            const DeepCollectionEquality().equals(other._messages, _messages) &&
            (identical(other.isSending, isSending) ||
                other.isSending == isSending) &&
            (identical(other.errorMessage, errorMessage) ||
                other.errorMessage == errorMessage) &&
            (identical(other.errorStatusCode, errorStatusCode) ||
                other.errorStatusCode == errorStatusCode));
  }

  @override
  int get hashCode => Object.hash(
    runtimeType,
    const DeepCollectionEquality().hash(_messages),
    isSending,
    errorMessage,
    errorStatusCode,
  );

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ChatbotStateImplCopyWith<_$ChatbotStateImpl> get copyWith =>
      __$$ChatbotStateImplCopyWithImpl<_$ChatbotStateImpl>(this, _$identity);
}

abstract class _ChatbotState implements ChatbotState {
  const factory _ChatbotState({
    final List<ChatMessage> messages,
    final bool isSending,
    final String? errorMessage,
    final int? errorStatusCode,
  }) = _$ChatbotStateImpl;

  @override
  List<ChatMessage> get messages;
  @override
  bool get isSending;
  @override
  String? get errorMessage;
  @override
  int? get errorStatusCode;

  /// Create a copy of ChatbotState
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ChatbotStateImplCopyWith<_$ChatbotStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
