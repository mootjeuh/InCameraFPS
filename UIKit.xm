#import <UIKit/UIKit.h>

id globalStatusBar = nil;

%hook UIStatusBarWindow

- (BOOL)_canActAsKeyWindowForScreen:(id)arg1 { globalStatusBar = self; return %orig; }
- (CGRect)_defaultStatusBarSceneBoundsForOrientation:(int)arg1 { globalStatusBar = self; return %orig; }
- (BOOL)_disableGroupOpacity { globalStatusBar = self; return %orig; }
- (BOOL)_isConstrainedByScreenJail { globalStatusBar = self; return %orig; }
- (BOOL)_isStatusBarWindow { globalStatusBar = self; return %orig; }
- (void)_rotate { %orig; globalStatusBar = self; }
- (BOOL)_shouldAdjustSizeClassesAndResizeWindow { globalStatusBar = self; return %orig; }
- (BOOL)_shouldZoom { globalStatusBar = self; return %orig; globalStatusBar = self; }
- (void)_updateTransformLayerForClassicPresentation { %orig; globalStatusBar = self; }
- (id)hitTest:(CGPoint)point { globalStatusBar = self; return %orig; }
- (id)initWithFrame:(CGRect)frame { id r = %orig; globalStatusBar = r; return r; }
- (int)orientation { globalStatusBar = self; return %orig; }
- (void)setCornersHidden:(BOOL)arg1 animationParameters:(id)arg2 { %orig; globalStatusBar = self; }
- (void)setOrientation:(int)arg1 animationParameters:(id)arg2 { %orig; globalStatusBar = self; }
- (void)setStatusBar:(id)arg1 { %orig; globalStatusBar = self; }
- (void)setTopCornerStyle:(int)arg1 topCornersOffset:(float)arg2 bottomCornerStyle:(int)arg3 animationParameters:(id)arg4 { %orig; globalStatusBar = self; }
- (CGRect)statusBarWindowFrame { globalStatusBar = self; return %orig; globalStatusBar = self; }
    
%end