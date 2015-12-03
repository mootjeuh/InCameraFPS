#import <UIKit/UIKit.h>
#import "CameraUI.h"

static CAMFramerateIndicatorView *fpsView = nil;

%hook CAMBottomBar

- (void)setBackgroundStyle:(int)arg1 animated:(BOOL)arg2
{
    %orig;
    
    if(fpsView) {
        [fpsView removeFromSuperview];
        fpsView = nil;
    }
    
    if(self.modeDial.selectedMode == 1) {
        if(self.framerateIndicatorView.hidden) {
            CAMUserPreferences *prefs = [%c(CAMUserPreferences) preferences];
            fpsView = [[%c(CAMFramerateIndicatorView) alloc] init];
            
            if(prefs.videoConfiguration == 0) {
                fpsView.style = 1;
            } else if(prefs.videoConfiguration == 1) {
                fpsView.style = 1;
            } else if(prefs.videoConfiguration == 6) {
                fpsView.style = 5;
            }
            
            CGRect frame;
            frame.size.width = 36;
            frame.size.height = 34;
            
            fpsView.frame = frame;
            
            if(self.imageWell.center.y == self.framerateIndicatorView.center.y) {
				fpsView.center = self.framerateIndicatorView.center;
            } else {
                fpsView.center = CGPointMake(CGRectGetWidth(self.frame)-frame.size.width, self.imageWell.center.y);
            }
            
            if(prefs.videoConfiguration == 0) {
                fpsView._topLabel.text = @"30";
            }
            
            [self addSubview:fpsView];
        }
        
        [self addFPSGestureRecognizer];
	} else if(self.modeDial.selectedMode == 2) {
        if(self.framerateIndicatorView.hidden) {
            CAMUserPreferences *prefs = [%c(CAMUserPreferences) preferences];
            fpsView = [[%c(CAMFramerateIndicatorView) alloc] init];
            
            if(prefs.slomoConfiguration == 0) {
                fpsView.style = 3;
            } else if(prefs.slomoConfiguration == 2) {
                fpsView.style = 2;
            }
            
            CGRect frame;
            frame.size.width = 36;
            frame.size.height = 34;
            
            fpsView.frame = frame;
            fpsView.center = self.framerateIndicatorView.center;
            
            [self addSubview:fpsView];
        }
        
        [self addFPSGestureRecognizer];
    }
}

%new
- (void)addFPSGestureRecognizerIfNecessary:(CAMFramerateIndicatorView*)view
{
    if(view.gestureRecognizers.count == 0) {
        UITapGestureRecognizer *tap = [%c(UITapGestureRecognizer) new];
        [tap addTarget:self action:@selector(tappedFPSView)];
        [view addGestureRecognizer:tap];
    }
}

%new
- (void)addFPSGestureRecognizer
{
    [self addFPSGestureRecognizerIfNecessary:self.framerateIndicatorView];
    
    if(fpsView) {
		[self addFPSGestureRecognizerIfNecessary:fpsView];
    }
}

%new
- (void)tappedFPSView
{
    NSString *string = [NSString stringWithFormat:@"prefs:root=Photos&InCameraFPS=%@", self.modeDial.selectedMode == 1 ? @"CAM_RECORD_VIDEO_TITLE" : @"CAM_RECORD_SLOMO_TITLE"];
    NSURL *url = [NSURL URLWithString:string];
    [[%c(UIApplication) sharedApplication] openURL:url];
}

%end