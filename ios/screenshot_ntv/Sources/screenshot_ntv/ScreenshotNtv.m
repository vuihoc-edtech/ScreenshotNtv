#import "ScreenshotNtv.h"
#import "ScreenshotNtvPlugin.h"

@implementation ScreenshotNtv

- (void)takeScreenshot:(FlutterError * _Nullable __autoreleasing * _Nonnull)error { 
    UIApplication *app = [UIApplication sharedApplication];
    UIViewController *rootController = app.delegate.window.rootViewController;
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGFloat scale = UIScreen.mainScreen.scale;
        UIView *view = rootController.view;
        UIGraphicsBeginImageContextWithOptions(view.bounds.size, view.opaque, scale);
        [view drawViewHierarchyInRect:view.bounds afterScreenUpdates:NO];
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        NSData *imageData = UIImagePNGRepresentation(screenshot);
        FlutterStandardTypedData *typedData = [FlutterStandardTypedData typedDataWithBytes:imageData];
                   [listener takeResultScreenshot:typedData completion:^(FlutterError * _Nullable null) {
                   }];
    });
}



@end
