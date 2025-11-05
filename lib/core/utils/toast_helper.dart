import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

/// Helper class for showing toast notifications
class ToastHelper {
  const ToastHelper._();

  /// Show a success toast
  static void showSuccess(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.success,
      style: ToastificationStyle.simple,
      title: Text('✅ $message'),
      description: Text(message),
      alignment: Alignment.topCenter,
      autoCloseDuration: duration,
      borderRadius: BorderRadius.circular(100.0),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  /// Show an error toast
  static void showError(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 4),
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.error,
      style: ToastificationStyle.simple,
      title: Text('❌ $message'),
      description: Text(message),
      alignment: Alignment.topCenter,
      autoCloseDuration: duration,
      borderRadius: BorderRadius.circular(100.0),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  /// Show an info toast
  static void showInfo(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.info,
      style: ToastificationStyle.simple,
      title: Text('ℹ️ $message'),
      description: Text(message),
      alignment: Alignment.topCenter,
      autoCloseDuration: duration,
      borderRadius: BorderRadius.circular(100.0),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      dragToClose: true,
      applyBlurEffect: true,
    );
  }

  /// Show a warning toast
  static void showWarning(
    BuildContext context,
    String message, {
    Duration duration = const Duration(seconds: 3),
  }) {
    toastification.show(
      context: context,
      type: ToastificationType.warning,
      style: ToastificationStyle.simple,
      title: Text('⚠️ $message'),
      description: Text(message),
      alignment: Alignment.topCenter,
      autoCloseDuration: duration,
      borderRadius: BorderRadius.circular(100.0),
      closeButton: ToastCloseButton(showType: CloseButtonShowType.none),
      dragToClose: true,
      applyBlurEffect: true,
    );
  }
}

