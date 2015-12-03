@interface CAMModeDial : UIControl

/**
 * Modes
 * 0: Photo
 * 1: Normal video recording
 * 2: Slo-mo video recording
*/
@property (nonatomic) int selectedMode;

@end

@interface CAMFramerateIndicatorView : UIView

@property (nonatomic, readonly) UILabel *_topLabel;

/**
 * Styles
 * 0: ---
 * 1: 60 FPS
 * 2: 120 FPS
 * 3: 240 FPS
 * 4: 4K
 * 5: 720P
*/
@property (nonatomic) int style;

@end

@interface CAMUserPreferences : NSObject

/**
 * Configurations for Slo-mo video
 * 0: 240 FPS
 * 1: ---
 * 2: 120 FPS
*/
@property (nonatomic, readonly) int slomoConfiguration;

/**
 * Configurations for normal video
 * 0: 1080p@30FPS
 * 1: 1080p@60FPS
 * 6: 720p@30FPS
*/
@property (nonatomic, readonly) int videoConfiguration;

+ (instancetype)preferences;

@end

@interface CAMImageWell : UIButton

@end

@interface CAMBottomBar : UIView

@property(nonatomic, retain) CAMImageWell *imageWell;
@property(nonatomic, retain) CAMFramerateIndicatorView *framerateIndicatorView;
@property(nonatomic, retain) CAMModeDial *modeDial;

- (void)addFPSGestureRecognizer;
- (void)addFPSGestureRecognizerIfNecessary:(CAMFramerateIndicatorView*)view;

@end