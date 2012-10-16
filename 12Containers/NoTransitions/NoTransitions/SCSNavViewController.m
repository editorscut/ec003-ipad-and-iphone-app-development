#import "SCSNavViewController.h"
#import "SCSNavDetailViewController.h"

@interface SCSNavViewController ()
@property (strong, nonatomic) SCSNavDetailViewController *detailVC;
@end

@implementation SCSNavViewController
- (SCSNavDetailViewController *)detailVC {
    if (! _detailVC) {
        _detailVC
         = (SCSNavDetailViewController *)[[self.splitViewController.viewControllers
                                                      lastObject] topViewController];
    }
    return _detailVC;
}
- (IBAction)sampleDPressed:(UIButton *)sender {
    [self.detailVC displayTheLetter:@"D"];
}
- (IBAction)sampleEPressed:(UIButton *)sender {
    [self.detailVC displayTheLetter:@"E"];
}
- (IBAction)sampleFPressed:(UIButton *)sender {
    [self.detailVC displayTheLetter:@"F"];
}

@end
