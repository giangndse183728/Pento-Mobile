import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_typography.dart';
import '../../../../core/layouts/app_scaffold.dart';
import '../../../../core/routing/app_routes.dart';
import '../../../../core/widgets/app_dialog.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import '../../../../core/services/tts_service.dart';
import '../../data/models/chat_message.dart';
import '../providers/chatbot_provider.dart';

const _assistantAvatarPath = 'assets/image/logo2.PNG';

class ChatbotScreen extends ConsumerStatefulWidget {
  const ChatbotScreen({super.key});

  @override
  ConsumerState<ChatbotScreen> createState() => _ChatbotScreenState();
}

class _ChatbotScreenState extends ConsumerState<ChatbotScreen> {
  late final TextEditingController _messageController;
  late final ScrollController _scrollController;
  final TtsService _ttsService = TtsService.instance;
  bool _isTtsEnabled = false;

  @override
  void initState() {
    super.initState();
    _messageController = TextEditingController();
    _scrollController = ScrollController();
    _ttsService.initialize();
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _ttsService.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<ChatbotState>(
      chatbotViewModelProvider,
      (previous, next) {
        final prevLength = previous?.messages.length ?? 0;
        if (next.messages.length > prevLength) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _scrollToBottom();
          });

          // Speak the latest assistant message if TTS is enabled
          final latestMessage = next.messages.last;
          if (latestMessage.role == ChatRole.assistant &&
              _isTtsEnabled) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _ttsService.speak(latestMessage.content);
            });
          }
        }
        final error = next.errorMessage;
        final statusCode = next.errorStatusCode;
        if (error != null && error != previous?.errorMessage) {
          if (statusCode == 403) {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              _showSubscriptionDialog(context);
            });
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(error)),
            );
          }
        }
      },
    );

    final state = ref.watch(chatbotViewModelProvider);

    return AppScaffold(
      title: 'Chatbot',
      showAvatarButton: false,
      showNotificationButton: false,
      forcePillMode: true,
      actions: [
        IconButton(
          icon: Icon(
            _isTtsEnabled ? Icons.volume_up : Icons.volume_off,
            color: _isTtsEnabled
                ? AppColors.blueGray
                : AppColors.blueGray.withValues(alpha: 0.5),
          ),
          onPressed: _toggleTts,
          tooltip: _isTtsEnabled ? 'Disable TTS' : 'Enable TTS',
        ),
      ],
      body: Column(
        children: [
          Expanded(
            child: state.messages.isEmpty
                ? _buildEmptyState()
                : ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).padding.top + kToolbarHeight,
                      bottom: 16.h,
                    ),
                    itemCount: state.messages.length + (state.isSending ? 1 : 0),
                    itemBuilder: (context, index) {
                      if (index >= state.messages.length) {
                        return const _AssistantTypingBubble();
                      }
                      final message = state.messages[index];
                      return _MessageBubble(message: message);
                    },
                  ),
          ),
          _ChatInputBar(
            controller: _messageController,
            isSending: state.isSending,
            onSend: _handleSend,
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 32.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 100.w,
              height: 100.w,
              child: ClipOval(
                child: Image.asset(
                  _assistantAvatarPath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Say hello to your kitchen assistant.',
              style: AppTextStyles.sectionHeader(),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Ask for cooking tips, leftover ideas, or anything food '
              'related.',
              style: TextStyle(
                color: AppColors.blueGray,
                fontSize: 14.sp,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  void _handleSend() {
    final message = _messageController.text.trim();
    if (message.isEmpty) {
      return;
    }
    _messageController.clear();
    _ttsService.stop(); // Stop any ongoing speech
    ref.read(chatbotViewModelProvider.notifier).sendMessage(message);
  }

  Future<void> _toggleTts() async {
    setState(() {
      _isTtsEnabled = !_isTtsEnabled;
    });
    await _ttsService.setEnabled(_isTtsEnabled);
    if (!_isTtsEnabled) {
      await _ttsService.stop();
    }
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent + 80.h,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
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
              'Please subscribe to access the chatbot.',
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

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.role == ChatRole.user;
    final bubbleColor = isUser
        ? AppColors.blueGray.withValues(alpha: 0.15)
        : Colors.white;
    final textColor = isUser ? Colors.black87 : AppColors.blueGray;

    final bubble = Container(
      constraints: BoxConstraints(maxWidth: 280.w),
      margin: EdgeInsets.only(
        top: 8.h,
        bottom: 8.h,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 12.h,
      ),
      decoration: BoxDecoration(
        color: bubbleColor,
        borderRadius: BorderRadius.circular(18.r),
        border: Border.all(
          color: AppColors.powderBlue.withValues(alpha: 0.4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isUser
              ? Text(
                  message.content,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: textColor,
                  ),
                )
              : MarkdownBody(
                  data: message.content,
                  styleSheet: MarkdownStyleSheet(
                    p: TextStyle(
                      fontSize: 14.sp,
                      color: textColor,
                    ),
                    h1: TextStyle(
                      fontSize: 18.sp,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    h2: TextStyle(
                      fontSize: 16.sp,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    h3: TextStyle(
                      fontSize: 15.sp,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    strong: TextStyle(
                      fontSize: 14.sp,
                      color: textColor,
                      fontWeight: FontWeight.bold,
                    ),
                    em: TextStyle(
                      fontSize: 14.sp,
                      color: textColor,
                      fontStyle: FontStyle.italic,
                    ),
                    code: TextStyle(
                      fontSize: 13.sp,
                      color: textColor,
                      fontFamily: 'monospace',
                      backgroundColor: AppColors.powderBlue.withValues(alpha: 0.2),
                    ),
                    codeblockDecoration: BoxDecoration(
                      color: AppColors.powderBlue.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    listBullet: TextStyle(
                      fontSize: 14.sp,
                      color: textColor,
                    ),
                    blockquote: TextStyle(
                      fontSize: 14.sp,
                      color: textColor.withValues(alpha: 0.8),
                      fontStyle: FontStyle.italic,
                    ),
                    a: TextStyle(
                      fontSize: 14.sp,
                      color: AppColors.blueGray,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
          SizedBox(height: 6.h),
          Text(
            _formatTimestamp(message.createdAt),
            style: TextStyle(
              fontSize: 11.sp,
              color: textColor.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );

    if (isUser) {
      return Align(
        alignment: Alignment.centerRight,
        child: bubble,
      );
    }

    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const _AssistantAvatar(),
          SizedBox(width: 8.w),
          bubble,
        ],
      ),
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    final time = TimeOfDay.fromDateTime(timestamp);
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'AM' : 'PM';
    return '$hour:$minute $period';
  }
}

class _ChatInputBar extends StatelessWidget {
  const _ChatInputBar({
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    final bottomPadding = MediaQuery.of(context).padding.bottom;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.fromLTRB(
        16.w,
        12.h,
        16.w,
        bottomPadding + 90.h,
      ),
      decoration: BoxDecoration(
        color: AppColors.iceberg,
        border: Border(
          top: BorderSide(
            color: AppColors.powderBlue.withValues(alpha: 0.6),
          ),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'Ask anything about your pantry...',
                hintStyle: AppTextStyles.inputHint,
                filled: true,
                fillColor: Colors.white,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.w,
                  vertical: 14.h,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: AppColors.babyBlue,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: AppColors.babyBlue,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                  borderSide: BorderSide(
                    color: AppColors.blueGray,
                    width: 1.6,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(width: 12.w),
          SizedBox(
            height: 48.h,
            width: 48.h,
            child: ElevatedButton(
              onPressed: isSending ? null : onSend,
              style: ElevatedButton.styleFrom(
                shape: const CircleBorder(),
                backgroundColor: AppColors.blueGray,
                padding: EdgeInsets.zero,
              ),
              child: isSending
                  ? SizedBox(
                      width: 18.w,
                      height: 18.w,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(
                      Icons.send_rounded,
                      color: Colors.white,
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantTypingBubble extends StatelessWidget {
  const _AssistantTypingBubble();

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const _AssistantAvatar(),
          SizedBox(width: 12.w),
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 12.h,
            ),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18.r),
              border: Border.all(
                color: AppColors.powderBlue.withValues(alpha: 0.4),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _TypingDot(delay: 0),
                SizedBox(width: 4.w),
                _TypingDot(delay: 150),
                SizedBox(width: 4.w),
                _TypingDot(delay: 300),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AssistantAvatar extends StatelessWidget {
  const _AssistantAvatar();

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 18.r,
      backgroundColor: Colors.white,
      child: ClipOval(
        child: Image.asset(
          _assistantAvatarPath,
          width: 48.w,
          height: 48.h,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class _TypingDot extends StatefulWidget {
  const _TypingDot({required this.delay});

  final int delay;

  @override
  State<_TypingDot> createState() => _TypingDotState();
}

class _TypingDotState extends State<_TypingDot>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat();

    _animation = Tween<double>(begin: 0.3, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          widget.delay / 900,
          1,
          curve: Curves.easeInOut,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _animation,
      child: Container(
        width: 6.w,
        height: 6.w,
        decoration: BoxDecoration(
          color: AppColors.blueGray,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

