import 'dart:typed_data';

import 'src/screenshot_ntv_api.dart';

class ScreenshotNtv {
  ScreenshotNtv._();

  static final _api = ScreenshotNtvApi();
  static final _listener = _ScreenshotNtvWorker();
  static bool _isListening = false;

  static Future<Uint8List?> takeScreenshot() async {
    if (!_isListening) {
      ScreenshotNtvFlutterListener.setup(_listener);
      _isListening = true;
    }
    _listener.result = null;
    _api.takeScreenshot();
    await _waiting();
    return _listener.result;
  }

  static Future<void> _waiting() async {
    while (_listener.result == null) {
      await Future.delayed(const Duration(milliseconds: 100));
    }
  }
}

class _ScreenshotNtvWorker extends ScreenshotNtvFlutterListener {
  Uint8List? result;

  @override
  void takeResultScreenshot(Uint8List? frame) {
    result = frame;
  }
}
