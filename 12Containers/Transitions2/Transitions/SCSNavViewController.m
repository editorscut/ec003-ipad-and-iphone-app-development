#import "SCSNavViewController.h"
#import "SCSNavDetailViewController.h"

@implementation SCSNavViewController
-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender {
    SCSNavDetailViewController *detailVC = segue.destinationViewController;
    NSString *segueName = [segue identifier];
    detailVC.displayedLetter = [segueName substringFromIndex:[segueName length]-1];
}
@end
