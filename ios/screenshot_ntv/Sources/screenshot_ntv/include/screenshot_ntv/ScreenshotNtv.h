#import "Pigeon.h"
#import <Flutter/Flutter.h>

@interface ScreenshotNtv : NSObject<ScreenshotNtvApi>
- (void)takeScreenshot:(FlutterError *_Nullable *_Nonnull)error;
@end
