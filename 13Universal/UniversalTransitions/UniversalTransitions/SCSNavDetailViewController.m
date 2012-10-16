#import "SCSNavDetailViewController.h"

@interface SCSNavDetailViewController ()<UISplitViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *displayedLetterLabel;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@end

@implementation SCSNavDetailViewController
- (void)displayTheLetter:(NSString *)letterToDisplay {
    self.displayedLetterLabel.text = letterToDisplay;
}
-(void)splitViewController:(UISplitViewController *)svc
    willHideViewController:(UIViewController *)aViewController
         withBarButtonItem:(UIBarButtonItem *)barButtonItem
      forPopoverController:(UIPopoverController *)popoverController {
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem
                                     animated:YES];
    self.masterPopoverController = popoverController;
}
-(void)splitViewController:(UISplitViewController *)svc
    willShowViewController:(UIViewController *)aViewController
 invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem {
    [self.navigationItem setLeftBarButtonItem:nil
                                     animated:YES];
    self.masterPopoverController = nil;
}
@end
