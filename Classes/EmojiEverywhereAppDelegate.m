
#import "EmojiEverywhereAppDelegate.h"

#define EMOJI_KEY @"KeyboardEmojiEverywhere"


@implementation EmojiEverywhereAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{    
#if TARGET_IPHONE_SIMULATOR
	prefsFile = [[NSString stringWithFormat:@"/Users/%@/Library/Application Support/iPhone Simulator/%@/Library/Preferences/com.apple.Preferences.plist", NSUserName(), [[UIDevice currentDevice] systemVersion]] retain];
#else
	prefsFile = @"/private/var/mobile/Library/Preferences/com.apple.Preferences.plist";
#endif
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:prefsFile];
	[objSetting setOn:[[dict objectForKey:EMOJI_KEY] boolValue]];    
    
    [window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


-(void)writePrefs
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithContentsOfFile:prefsFile];
	[dict setObject:[NSNumber numberWithBool:[objSetting isOn]] forKey:EMOJI_KEY];
	[dict writeToFile:prefsFile atomically:NO];
}

- (IBAction)btnPush:(id)sender
{
	NSString *msg[] = {
		@"Do you really save this settings?",
		@"Settings had been saved."
	};
	NSString *cancelBtn[] = {
		@"Yes",
		@"Agree"
	};
	NSString *otherBtn[] = {
		@"No",
		nil
	};

	if([objSetting isOn])
	{
		alertMode = 0;
	}
	else
	{
		alertMode = 1;
		[self writePrefs];
	}
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg[alertMode] delegate:self cancelButtonTitle:cancelBtn[alertMode] otherButtonTitles:otherBtn[alertMode], nil];
	[alert show];
	[alert release];
}


- (void)alertView:(UIAlertView*)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(alertMode == 0 && buttonIndex == 0)
	{
		[self writePrefs];
	}
}

-(void)alertViewCancel:(UIAlertView*)alertView
{
	alertMode = -1;
}


@end
