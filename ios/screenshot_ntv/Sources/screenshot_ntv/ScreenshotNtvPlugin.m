#import "ScreenshotNtvPlugin.h"
#import "ScreenshotNtv.h"

ScreenshotNtvFlutterListener *listener;

@implementation ScreenshotNtvPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
    listener = [[ScreenshotNtvFlutterListener alloc] initWithBinaryMessenger:registrar.messenger];
    SetUpScreenshotNtvApi(registrar.messenger, [[ScreenshotNtv alloc] init]);
}
@end
