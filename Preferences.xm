#import <UIKit/UIKit.h>

#import "UIKit.h"
#import "UIView+InCameraFPS.h"
#import "Preferences.h"

extern UIStatusBarWindow *globalStatusBar;

static BOOL isDeepLinked = NO;
static NSArray *configurations = @[@"CAM_RECORD_VIDEO_720p_30",
                                   @"CAM_RECORD_VIDEO_1080p_60",
                                   @"CAM_RECORD_VIDEO_1080p_30",
                                   @"CAM_RECORD_SLOMO_720p_120",
                                   @"CAM_RECORD_SLOMO_720p_240"];

static NSString *localizedIdentifierForMode(NSString *mode)
{
    NSBundle *bundle = [NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/MobileSlideShowSettings.bundle"];
    
    return [bundle localizedStringForKey:mode value:mode table:@"Photos"];
}

static BOOL checkConfiguration(const char *configuration)
{
    NSBundle *bundle = [NSBundle bundleWithPath:@"/System/Library/PreferenceBundles/MobileSlideShowSettings.bundle"];
    BOOL result = NO;
    
    for(NSString *config in configurations) {
        NSString *string = [bundle localizedStringForKey:config value:nil table:@"Photos"];
        
        if(string) {
            if(strcmp(string.UTF8String, configuration) == 0) {
                result = YES;
                break;
            }
        }
    }
    
    return result;
}

%hook PreferencesAppController

- (void)handleAuthKitURLIfNeededFromResourceDictionary:(NSDictionary*)arg1 overViewController:(PSListController*)arg2
{
    %orig;
    
    if([arg1.allKeys containsObject:@"InCameraFPS"]) {
        isDeepLinked = YES;
        PSSpecifier *specifier = [arg2 specifierForID:localizedIdentifierForMode(arg1[@"InCameraFPS"])];
		
		[arg2 showController:[arg2 controllerForSpecifier:specifier] animate:YES];
    }
}

- (void)applicationSuspend
{
    isDeepLinked = NO;
    %orig;
}

%end

%hook PSListItemsController

- (void)tableView:(id)arg1 didSelectRowAtIndexPath:(NSIndexPath*)arg2
{
    %orig;
    
    PSTableCell *cell = [self tableView:arg1 cellForRowAtIndexPath:arg2];
    
    if([cell isKindOfClass:%c(PSTableCell)]) {
        if(checkConfiguration(cell.specifier.identifier.UTF8String)) {
            UIStatusBarBreadcrumbItemView *itemView = nil;
            _UIStatusBarSystemNavigationItemButton *button = nil;
            
            for(id subview in [globalStatusBar allSubviews]) {
                if([subview isKindOfClass:%c(UIStatusBarBreadcrumbItemView)]) {
                    itemView = subview;
                } else if([subview isKindOfClass:%c(_UIStatusBarSystemNavigationItemButton)]) {
                    button = subview;
                }
                
                if(itemView && button) {
                    break;
                }
            }
            
            if(itemView && button) {
                NSBundle *bundle = [NSBundle bundleWithPath:@"/Applications/Camera.app"];
                if([itemView.destinationText isEqualToString:[bundle localizedStringForKey:@"CFBundleDisplayName" value:@"Camera" table:@"InfoPlist"]]) {
                    [itemView userDidActivateButton:button];
                }
            } else if(isDeepLinked) {
                [[%c(UIApplication) sharedApplication] launchApplicationWithIdentifier:@"com.apple.camera" suspended:NO];
            }
            
        }
    }
}

%end