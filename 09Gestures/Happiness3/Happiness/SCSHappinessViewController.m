#import "SCSHappinessViewController.h"
#import "SCSCircleView.h"

@interface SCSHappinessViewController ()
@property (weak, nonatomic) IBOutlet SCSCircleView *faceView;
@end

@implementation SCSHappinessViewController
- (IBAction)adjustScale:(UIPinchGestureRecognizer *)sender {
    CGFloat scale = MIN(sender.scale, 1);
    scale = MAX(scale, .01);
    self.faceView.transform = CGAffineTransformMakeScale(scale, scale);
}
@end
