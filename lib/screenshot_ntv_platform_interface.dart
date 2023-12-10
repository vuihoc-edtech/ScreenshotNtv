import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'screenshot_ntv_method_channel.dart';

abstract class ScreenshotNtvPlatform extends PlatformInterface {
  /// Constructs a ScreenshotNtvPlatform.
  ScreenshotNtvPlatform() : super(token: _token);

  static final Object _token = Object();

  static ScreenshotNtvPlatform _instance = MethodChannelScreenshotNtv();

  /// The default instance of [ScreenshotNtvPlatform] to use.
  ///
  /// Defaults to [MethodChannelScreenshotNtv].
  static ScreenshotNtvPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [ScreenshotNtvPlatform] when
  /// they register themselves.
  static set instance(ScreenshotNtvPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
