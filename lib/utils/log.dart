import 'package:logger/logger.dart';

class Log {
  static final Logger _logger = Logger(
    printer: PrefixPrinter(PrettyPrinter()),
  );

  static void v(dynamic message) {
    // ignore: deprecated_member_use
    _logger.v(message);
  }

  static void d(dynamic message) {
    _logger.d(message);
  }

  static void i(dynamic message) {
    _logger.i(message);
  }

  static void w(dynamic message) {
    _logger.w(message);
  }

  static void e(dynamic message) {
    _logger.e(message);
  }

  static void wtf(dynamic message) {
    // ignore: deprecated_member_use
    _logger.wtf(message);
  }
}
