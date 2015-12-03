@interface _UIStatusBarSystemNavigationItemButton : UIButton

@end

@interface UIStatusBarBreadcrumbItemView : UIView

@property (nonatomic, retain) NSString *destinationText;

- (void)userDidActivateButton:(_UIStatusBarSystemNavigationItemButton*)arg1;

@end

@interface UIStatusBarWindow : UIWindow

@end

@interface UIApplication (InCameraFPS)

- (BOOL)launchApplicationWithIdentifier:(id)arg1 suspended:(BOOL)arg2;

@end