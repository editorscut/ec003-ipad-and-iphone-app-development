#import "SCSViewController.h"

@implementation SCSViewController

- (IBAction)showOff:(UITapGestureRecognizer *)sender {
    [UIView animateWithDuration:2
                     animations:^{
                         self.view.backgroundColor = [UIColor greenColor];
                         self.view.transform = CGAffineTransformMakeScale(.2, .1);
                     }
                     completion:^(BOOL finished) {
                         [UIView animateWithDuration:2
                                          animations:^{
                                              self.view.backgroundColor = [UIColor redColor];
                                              self.view.transform = CGAffineTransformIdentity;
                                          }];
                     }];
}
@end
