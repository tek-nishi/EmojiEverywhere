
#import <UIKit/UIKit.h>

@interface EmojiEverywhereAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	NSString *prefsFile;
	id objSetting;
	int alertMode;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)btnPush:(id)sender;

@end

