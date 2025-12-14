import 'package:flutter_tts/flutter_tts.dart';
import '../utils/logging.dart';

class TtsService {
  TtsService._();

  static final TtsService _instance = TtsService._();
  static TtsService get instance => _instance;

  final _logger = AppLogger.getLogger('TtsService');
  final FlutterTts _flutterTts = FlutterTts();

  bool _isInitialized = false;
  bool _isEnabled = false;
  bool _isSpeaking = false;

  bool get isEnabled => _isEnabled;
  bool get isSpeaking => _isSpeaking;

  /// Initialize TTS service
  Future<void> initialize() async {
    if (_isInitialized) return;

    try {
      await _flutterTts.setLanguage('en-US');
      await _flutterTts.setSpeechRate(0.5);
      await _flutterTts.setVolume(1.0);
      await _flutterTts.setPitch(1.0);

      _flutterTts.setCompletionHandler(() {
        _isSpeaking = false;
      });

      _flutterTts.setErrorHandler((msg) {
        _logger.warning('TTS Error: $msg');
        _isSpeaking = false;
      });

      _isInitialized = true;
      _logger.info('TTS service initialized');
    } catch (e) {
      _logger.severe('Failed to initialize TTS: $e');
    }
  }

  /// Enable or disable TTS
  Future<void> setEnabled(bool enabled) async {
    if (!_isInitialized) {
      await initialize();
    }
    _isEnabled = enabled;
    if (!enabled && _isSpeaking) {
      await stop();
    }
  }

  /// Strip markdown syntax from text
  String _stripMarkdown(String text) {
    // Remove markdown headers
    text = text.replaceAll(RegExp(r'^#{1,6}\s+', multiLine: true), '');
    // Remove bold/italic markers
    text = text.replaceAll(RegExp(r'\*\*([^*]+)\*\*'), r'$1');
    text = text.replaceAll(RegExp(r'__([^_]+)__'), r'$1');
    text = text.replaceAll(RegExp(r'\*([^*]+)\*'), r'$1');
    text = text.replaceAll(RegExp(r'_([^_]+)_'), r'$1');
    // Remove code blocks
    text = text.replaceAll(RegExp(r'```[\s\S]*?```'), '');
    text = text.replaceAll(RegExp(r'`([^`]+)`'), r'$1');
    // Remove links but keep text
    text = text.replaceAll(RegExp(r'\[([^\]]+)\]\([^\)]+\)'), r'$1');
    // Remove images
    text = text.replaceAll(RegExp(r'!\[([^\]]*)\]\([^\)]+\)'), '');
    // Remove list markers
    text = text.replaceAll(RegExp(r'^[\*\-\+]\s+', multiLine: true), '');
    text = text.replaceAll(RegExp(r'^\d+\.\s+', multiLine: true), '');
    // Remove blockquotes
    text = text.replaceAll(RegExp(r'^>\s+', multiLine: true), '');
    // Remove horizontal rules
    text = text.replaceAll(RegExp(r'^---+$', multiLine: true), '');
    // Clean up extra whitespace
    text = text.replaceAll(RegExp(r'\n\s*\n'), '\n');
    return text.trim();
  }

  /// Speak text (strips markdown if present)
  Future<void> speak(String text) async {
    if (!_isEnabled || text.isEmpty) return;

    try {
      if (!_isInitialized) {
        await initialize();
      }

      if (_isSpeaking) {
        await stop();
      }

      // Strip markdown before speaking
      final cleanText = _stripMarkdown(text);

      _isSpeaking = true;
      await _flutterTts.speak(cleanText);
      _logger.info('TTS speaking: ${cleanText.substring(0, cleanText.length > 50 ? 50 : cleanText.length)}...');
    } catch (e) {
      _logger.severe('Failed to speak: $e');
      _isSpeaking = false;
    }
  }

  /// Stop speaking
  Future<void> stop() async {
    if (!_isSpeaking) return;

    try {
      await _flutterTts.stop();
      _isSpeaking = false;
      _logger.info('TTS stopped');
    } catch (e) {
      _logger.severe('Failed to stop TTS: $e');
    }
  }

  /// Dispose resources
  void dispose() {
    stop();
    _isInitialized = false;
  }
}


