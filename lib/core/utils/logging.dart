import 'package:logging/logging.dart';

class AppLogger {
  AppLogger._();

  static void initialize({Level level = Level.ALL}) {
    Logger.root.level = level;
    Logger.root.onRecord.listen((record) {
      _printLog(record);
    });
  }

  static void _printLog(LogRecord record) {
    final level = record.level.name.padRight(7);
    final time = _formatTime(record.time);
    final logger = record.loggerName.padRight(15);
    final message = record.message;

    final levelColor = _getLevelColor(record.level);
    final resetColor = '\x1B[0m';

    print('$levelColor$level$resetColor | $time | $logger | $message');

    if (record.error != null) {
      print('  └─ Error: ${record.error}');
    }

    if (record.stackTrace != null) {
      print('  └─ Stack: ${record.stackTrace}');
    }
  }

  static String _formatTime(DateTime time) {
    return '${time.hour.toString().padLeft(2, '0')}:'
        '${time.minute.toString().padLeft(2, '0')}:'
        '${time.second.toString().padLeft(2, '0')}.'
        '${time.millisecond.toString().padLeft(3, '0')}';
  }

  static String _getLevelColor(Level level) {
    if (level == Level.SEVERE || level == Level.SHOUT) {
      return '\x1B[31m'; // Red
    } else if (level == Level.WARNING) {
      return '\x1B[33m'; // Yellow
    } else if (level == Level.INFO) {
      return '\x1B[32m'; // Green
    } else if (level == Level.CONFIG) {
      return '\x1B[36m'; // Cyan
    } else {
      return '\x1B[37m'; // White
    }
  }

  static void setProductionLevel() {
    Logger.root.level = Level.WARNING;
  }

  static void setDevelopmentLevel() {
    Logger.root.level = Level.ALL;
  }

  static void disableLogging() {
    Logger.root.level = Level.OFF;
  }

  static Logger getLogger(String name) {
    return Logger(name);
  }

  static Logger get network => Logger('Network');
  static Logger get auth => Logger('Auth');
  static Logger get storage => Logger('Storage');
  static Logger get ui => Logger('UI');
  static Logger get data => Logger('Data');
}

