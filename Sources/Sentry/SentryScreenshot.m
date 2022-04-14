#import "SentryScreenShot.h"
#import "SentryUIApplication.h"
#import "SentryDependencyContainer.h"

#if SENTRY_HAS_UIKIT
#    import <UIKit/UIKit.h>

@implementation SentryScreenshot

- (NSArray<NSData *> *)appScreenshots
{
    __block NSMutableArray *result;
    
    dispatch_sync(dispatch_get_main_queue(), ^{
        NSArray<UIWindow *> *windows = [SentryDependencyContainer.sharedInstance.application windows];
        
        result = [NSMutableArray arrayWithCapacity:windows.count];
        
        for (UIWindow *window in windows) {
            UIGraphicsBeginImageContext(window.frame.size);
            
            if ([window drawViewHierarchyInRect:window.bounds afterScreenUpdates:false]) {
                UIImage *img = UIGraphicsGetImageFromCurrentImageContext();
                [result addObject:UIImagePNGRepresentation(img)];
            }
            
            UIGraphicsEndImageContext();
        }
    });
    
    return result;
}

@end

#endif
