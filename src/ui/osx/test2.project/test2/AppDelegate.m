//
//  AppDelegate.m
//  test2
//
//  Created by Alari on 9/15/13.
//  Copyright (c) 2013 kopsik developers. All rights reserved.
//

#import "AppDelegate.h"
#import "kopsik_api.h"
#import "Context.h"
#import "MainWindowController.h"
#import "Bugsnag.h"

@interface  AppDelegate()
@property (nonatomic,strong) IBOutlet MainWindowController *mainWindowController;
@end

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
  NSLog(@"applicationDidFinishLaunching");

  [Bugsnag startBugsnagWithApiKey:@"2a46aa1157256f759053289f2d687c2f"];
  [Bugsnag configuration].releaseStage = @"development";
  
  self.mainWindowController = [[MainWindowController alloc] initWithWindowNibName:@"MainWindowController"];
  [self.mainWindowController.window setReleasedWhenClosed:NO];
  [self.mainWindowController showWindow:self];
}

- (BOOL)applicationShouldHandleReopen:(NSApplication *)sender hasVisibleWindows:(BOOL)flag{
  [self.mainWindowController.window setIsVisible:YES];
  return YES;
}

- (NSString *)applicationSupportDirectory
{
  NSString *path;
  NSError *error;
  NSArray* paths = NSSearchPathForDirectoriesInDomains(NSApplicationSupportDirectory, NSUserDomainMask, YES);
  if ([paths count] == 0) {
    NSLog(@"Unable to access application support directory!");
  }
  path = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"Kopsik"];
  
	if (![[NSFileManager defaultManager] fileExistsAtPath:path]){
		if (![[NSFileManager defaultManager] createDirectoryAtPath:path
                                   withIntermediateDirectories:NO
                                                    attributes:nil
                                                         error:&error]){
			NSLog(@"Create directory error: %@", error);
		}
	}
  return path;
}

- (id) init
{
  self = [super init];
  
  // Disallow duplicate instances
  if ([[NSRunningApplication runningApplicationsWithBundleIdentifier:[[NSBundle mainBundle] bundleIdentifier]] count] > 1) {
    [[NSAlert alertWithMessageText:[NSString stringWithFormat:@"Another copy of %@ is already running.", [[NSBundle mainBundle] objectForInfoDictionaryKey:(NSString *)kCFBundleNameKey]]
                     defaultButton:nil alternateButton:nil otherButton:nil informativeTextWithFormat:@"This copy will now quit."] runModal];
    
    [NSApp terminate:nil];
  }
  
  ctx = kopsik_context_init();

  NSArray *arguments = [[NSProcessInfo processInfo] arguments];
  NSLog(@"Command line arguments: %@", arguments);
  
  NSString *app_path = self.applicationSupportDirectory;
  NSString *db_path = [app_path stringByAppendingPathComponent:@"kopsik.db"];
  NSString *log_path = [app_path stringByAppendingPathComponent:@"kopsik.log"];
  
  for (int i = 1; i < arguments.count; i++) {
    NSString *argument = [arguments objectAtIndex:i];
    if ([argument rangeOfString:@"logpath"].location != NSNotFound) {
      log_path = [arguments objectAtIndex:i+1];
      NSLog(@"log path overriden with '%@'", log_path);
      continue;
    }
    if ([argument rangeOfString:@"dbpath"].location != NSNotFound) {
      db_path = [arguments objectAtIndex:i+1];
      NSLog(@"db path overriden with '%@'", db_path);
      continue;
    }
  }

  kopsik_set_db_path(ctx, [db_path UTF8String]);
  kopsik_set_log_path(ctx, [log_path UTF8String]);

  return self;
}

- (void) dealloc
{
  NSLog(@"AppDelegate dealloc stopping websocket");
  char err[KOPSIK_ERR_LEN];
  if (KOPSIK_API_SUCCESS != kopsik_websocket_stop(ctx, err, KOPSIK_ERR_LEN)) {
    NSLog(@"Error while shutting down websocket: %s", err);
  }
  NSLog(@"AppDelegate dealloc websocket stopped");
  kopsik_context_clear(ctx);
  ctx = 0;
}

@end