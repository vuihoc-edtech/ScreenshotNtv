import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/screenshot_ntv_api.dart',
    javaOut:
        'android/src/main/kotlin/com/n1k5tas/screenshot_ntv/pigeon/Pigeon.java',
    objcHeaderOut: 'ios/Classes/Pigeon.h',
    objcSourceOut: 'ios/Classes/Pigeon.m',
    // dartPackageName: 'com.n1k5tas.screenshot_ntv',
  ),
)
@HostApi()
abstract class ScreenshotNtvApi {
  @ObjCSelector('takeScreenshot')
  void takeScreenshot();
}

@FlutterApi()
abstract class ScreenshotNtvFlutterListener {
  @ObjCSelector('takeResultScreenshot:')
  void takeResultScreenshot(Uint8List? frame);
}
