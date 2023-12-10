import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'screenshot_ntv_platform_interface.dart';

/// An implementation of [ScreenshotNtvPlatform] that uses method channels.
class MethodChannelScreenshotNtv extends ScreenshotNtvPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('screenshot_ntv');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
