import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import '../../../../core/constants/app_colors.dart';
import '../../data/models/trade_offers_model.dart';

class TradeSessionChatWidget extends StatefulWidget {
  const TradeSessionChatWidget({
    super.key,
    required this.messages,
    required this.onSendMessage,
    required this.currentUserId,
    this.isSending = false,
  });

  final List<TradeSessionMessage> messages;
  final Future<void> Function(String message) onSendMessage;
  final String? currentUserId;
  final bool isSending;

  @override
  State<TradeSessionChatWidget> createState() => _TradeSessionChatWidgetState();
}

class _TradeSessionChatWidgetState extends State<TradeSessionChatWidget> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  bool _isSending = false;

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  String _formatMessageTime(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 0) {
      return DateFormat('MMM d, h:mm a').format(date);
    }
    return DateFormat('h:mm a').format(date);
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isSending) return;

    setState(() => _isSending = true);
    _messageController.clear();
    
    try {
      await widget.onSendMessage(text);
      // Scroll to bottom after sending
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (_scrollController.hasClients) {
          _scrollController.animateTo(
            0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeOut,
          );
        }
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send message: $e'),
            backgroundColor: AppColors.dangerRed,
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isSending = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final messages = widget.messages.toList()
      ..sort((a, b) => b.sentOn.compareTo(a.sentOn));

    return Column(
      children: [
        // Messages list
        Expanded(
          child: messages.isEmpty
              ? _buildEmptyMessages()
              : ListView.builder(
                  controller: _scrollController,
                  reverse: true,
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];
                    final isLastFromUser = index == messages.length - 1 ||
                        messages[index + 1].user.userId != message.user.userId;
                    return _buildMessageBubble(message, isLastFromUser);
                  },
                ),
        ),
        // Message input
        _buildMessageInput(),
      ],
    );
  }

  Widget _buildEmptyMessages() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              color: AppColors.babyBlue.withValues(alpha: 0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.chat_bubble_outline_rounded,
              size: 48.w,
              color: AppColors.blueGray.withValues(alpha: 0.5),
            ),
          ),
          SizedBox(height: 16.h),
          Text(
            'No messages yet',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w600,
              color: AppColors.blueGray,
            ),
          ),
          SizedBox(height: 8.h),
          Text(
            'Start the conversation!',
            style: TextStyle(
              fontSize: 14.sp,
              color: AppColors.blueGray.withValues(alpha: 0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageBubble(TradeSessionMessage message, bool showAvatar) {
    // Compare with current user ID to determine if message is from current user
    final isMe = widget.currentUserId != null && 
                 message.user.userId == widget.currentUserId;

    return Padding(
      padding: EdgeInsets.only(bottom: showAvatar ? 12.h : 4.h),
      child: Row(
        mainAxisAlignment:
            isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isMe && showAvatar) ...[
            _buildMessageAvatar(message.user),
            SizedBox(width: 8.w),
          ] else if (!isMe) ...[
            SizedBox(width: 40.w),
          ],
          Flexible(
            child: Column(
              crossAxisAlignment:
                  isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
              children: [
                if (showAvatar && !isMe)
                  Padding(
                    padding: EdgeInsets.only(left: 4.w, bottom: 4.h),
                    child: Text(
                      '${message.user.firstName} ${message.user.lastName}',
                      style: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                        color: AppColors.blueGray,
                      ),
                    ),
                  ),
                Container(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.of(context).size.width * 0.7,
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: 14.w,
                    vertical: 10.h,
                  ),
                  decoration: BoxDecoration(
                    color: isMe ? AppColors.blueGray : Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(18.r),
                      topRight: Radius.circular(18.r),
                      bottomLeft: Radius.circular(isMe ? 18.r : 4.r),
                      bottomRight: Radius.circular(isMe ? 4.r : 18.r),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.messageText,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: isMe ? Colors.white : Colors.black87,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        _formatMessageTime(message.sentOn),
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: isMe
                              ? Colors.white.withValues(alpha: 0.7)
                              : AppColors.blueGray.withValues(alpha: 0.7),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          if (isMe && showAvatar) ...[
            SizedBox(width: 8.w),
            _buildMessageAvatar(message.user),
          ] else if (isMe) ...[
            SizedBox(width: 40.w),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageAvatar(TradeSessionUser user) {
    return Container(
      width: 32.w,
      height: 32.w,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.babyBlue,
            AppColors.powderBlue,
          ],
        ),
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: user.avatarUrl != null
            ? Image.network(
                user.avatarUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Center(
                  child: Text(
                    user.firstName.isNotEmpty 
                        ? user.firstName[0].toUpperCase() 
                        : '?',
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ),
              )
            : Center(
                child: Text(
                  user.firstName.isNotEmpty 
                      ? user.firstName[0].toUpperCase() 
                      : '?',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.iceberg,
                  borderRadius: BorderRadius.circular(24.r),
                ),
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    hintText: 'Type a message...',
                    hintStyle: TextStyle(
                      color: AppColors.blueGray.withValues(alpha: 0.5),
                      fontSize: 14.sp,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 12.h,
                    ),
                  ),
                  textCapitalization: TextCapitalization.sentences,
                  maxLines: 4,
                  minLines: 1,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Material(
              color: AppColors.blueGray,
              borderRadius: BorderRadius.circular(24.r),
              child: InkWell(
                borderRadius: BorderRadius.circular(24.r),
                onTap: _isSending ? null : _sendMessage,
                child: Container(
                  width: 48.w,
                  height: 48.w,
                  child: _isSending
                      ? Padding(
                          padding: EdgeInsets.all(12.w),
                          child: const CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : Icon(
                          Icons.send_rounded,
                          color: Colors.white,
                          size: 22.sp,
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
