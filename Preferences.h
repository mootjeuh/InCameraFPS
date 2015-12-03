@interface PSSpecifier : NSObject

@property(nonatomic, retain) NSString *identifier;

@end

@interface PSTableCell : UITableViewCell

@property(nonatomic, retain) PSSpecifier *specifier;

@end

@interface PSListController : UIViewController

- (NSArray*)specifiers;
- (PSSpecifier*)specifierForID:(NSString*)arg1;
- (id)controllerForSpecifier:(PSSpecifier*)arg1;
- (void)showController:(id)arg1 animate:(BOOL)arg2;

@end

@interface PSListItemsController : PSListController

- (PSTableCell*)tableView:(UITableView*)arg1 cellForRowAtIndexPath:(NSIndexPath*)arg2;

@end