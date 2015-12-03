//
//  UIView+InCameraFPS.xm
//  
//
//  Created by Mohamed Marbouh on 2015-11-30.
//
//

#import "UIView+InCameraFPS.h"

%hook UIView

%new
- (NSArray*)allSubviews
{
	NSMutableArray *arr = [NSMutableArray array];
	[arr addObject:self];
	
	for(UIView *subview in self.subviews) {
		[arr addObjectsFromArray:[subview allSubviews]];
	}
	
	return arr;
}

%new
+ (NSArray*)allSubviews
{
	return [[%c(UIApplication) sharedApplication].keyWindow allSubviews];
}

%end