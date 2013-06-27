#import "App.h"

#import "NSURL+L0URLParsing.h"

@implementation App

NSString *defaultPath = @"/Applications/Sublime Text.app/Contents/SharedSupport/bin/subl";

-(void)awakeFromNib {
    NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
    path = [d objectForKey:@"path"];

    NSAppleEventManager *appleEventManager = [NSAppleEventManager sharedAppleEventManager];
    [appleEventManager setEventHandler:self andSelector:@selector(handleGetURLEvent:withReplyEvent:) forEventClass:kInternetEventClass andEventID:kAEGetURL];
}

-(void)handleGetURLEvent:(NSAppleEventDescriptor *)event withReplyEvent:(NSAppleEventDescriptor *)replyEvent {
    if (nil == path) path = defaultPath;

    NSURL *url = [NSURL URLWithString:[[event paramDescriptorForKeyword:keyDirectObject] stringValue]];
    NSLog(@"URL! %@", url);
    
    if (url && [[url host] isEqualToString:@"open"]) {
        NSDictionary *params = [url dictionaryByDecodingQueryString];
        NSString* fileURI = [params objectForKey:@"url"];
        NSString* line = [params objectForKey:@"line"];
        
        if (fileURI) {
            NSString *fileName = [fileURI componentsSeparatedByString:@"://"][1];

            NSTask *task = [[NSTask alloc] init];
            [task setLaunchPath:path];
            NSString *fileWithLine = [@[fileName, line] componentsJoinedByString:@":"];
            [task setArguments:@[fileWithLine]];
            [task launch];
            [task release];

            NSWorkspace *sharedWorkspace = [NSWorkspace sharedWorkspace];
            NSString *appPath = [sharedWorkspace fullPathForApplication:@"Sublime Text"];
            NSString *identifier = [[NSBundle bundleWithPath:appPath] bundleIdentifier];
            NSArray *selectedApps =
            [NSRunningApplication runningApplicationsWithBundleIdentifier:identifier];
            NSRunningApplication *runningApplcation = (NSRunningApplication*)[selectedApps objectAtIndex:0];
            [runningApplcation activateWithOptions: NSApplicationActivateAllWindows];
        }
    }
}

-(IBAction)showPrefPanel:(id)sender {
    if (path) {
        [textField setStringValue:path];
    } else {
        [textField setStringValue:defaultPath];
    }
    [prefPanel makeKeyAndOrderFront:nil];
}

-(IBAction)applyChange:(id)sender {
    path = [textField stringValue];

    if (path) {
        NSUserDefaults *d = [NSUserDefaults standardUserDefaults];
        [d setObject:path forKey:@"path"];
    }

    [prefPanel orderOut:nil];
}

@end
