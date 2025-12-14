import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../../../core/exceptions/network_exception.dart';
import '../../../authentication/presentation/providers/user_session_provider.dart';
import '../../data/models/chat_message.dart';
import '../../data/repositories/chatbot_repository.dart';

part 'chatbot_provider.g.dart';
part 'chatbot_provider.freezed.dart';

@freezed
class ChatbotState with _$ChatbotState {
  const factory ChatbotState({
    @Default(<ChatMessage>[]) List<ChatMessage> messages,
    @Default(false) bool isSending,
    String? errorMessage,
    int? errorStatusCode,
  }) = _ChatbotState;
}

@riverpod
class ChatbotViewModel extends _$ChatbotViewModel {
  final ChatbotRepository _repository = ChatbotRepository();

  @override
  ChatbotState build() {
    return const ChatbotState();
  }

  Future<void> sendMessage(String rawMessage) async {
    final trimmed = rawMessage.trim();
    if (trimmed.isEmpty) {
      return;
    }

    final previousMessages = state.messages;
    final now = DateTime.now();
    final userMessage = ChatMessage(
      id: _buildMessageId(now),
      role: ChatRole.user,
      content: trimmed,
      createdAt: now,
      updatedAt: now,
    );

    state = state.copyWith(
      messages: [...previousMessages, userMessage],
      isSending: true,
      errorMessage: null,
      errorStatusCode: null,
    );

    try {
      final userSession = ref.read(userSessionNotifierProvider);
      final userId = userSession?.userId;
      if (userId == null) {
        throw NetworkException(
          message: 'User not authenticated',
          statusCode: 401,
        );
      }

      final reply = await _repository.sendMessage(
        message: trimmed,
        userId: userId,
      );
      final botTime = DateTime.now();
      final botMessage = ChatMessage(
        id: _buildMessageId(botTime),
        role: ChatRole.assistant,
        content: reply,
        createdAt: botTime,
        updatedAt: botTime,
      );

      state = state.copyWith(
        messages: [...state.messages, botMessage],
        isSending: false,
      );
    } catch (error) {
      final message = error is NetworkException
          ? error.message
          : 'Unable to send message. Please try again.';
      final statusCode = error is NetworkException
          ? error.statusCode
          : null;
      state = state.copyWith(
        messages: previousMessages,
        isSending: false,
        errorMessage: message,
        errorStatusCode: statusCode,
      );
    }
  }

  String _buildMessageId(DateTime timestamp) =>
      timestamp.microsecondsSinceEpoch.toString();
}

