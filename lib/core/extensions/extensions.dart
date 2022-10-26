import 'dart:developer' as developer;

extension Logger on Object? {
  void log() {
    developer.log(toString());
  }
}
