import 'package:logger/logger.dart';

abstract class SimpleLogger {
  static var _logger = Logger(
    printer: PrettyPrinter(
        methodCount: 2,
        // number of method calls to be displayed
        errorMethodCount: 8,
        // number of method calls if stacktrace is provided
        lineLength: 120,
        // width of the output
        colors: true,
        // Colorful log messages
        printEmojis: false,
        // Print an emoji for each log message
        printTime: false // Should each log print contain a timestamp
        ),
  );

  static debug(Type classs, dynamic log) {
    print("\n\n\n$log\n\n\n");
    // _logger.d("\n\n\nClass Name: $classs\n $log \n\n\n");
  }


}
