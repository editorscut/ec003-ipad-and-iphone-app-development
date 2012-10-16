#import "SCSHappinessViewController.h"
#import "SCSCircleView.h"

@interface SCSHappinessViewController ()
@property (weak, nonatomic) IBOutlet SCSCircleView *faceView;
@end

@implementation SCSHappinessViewController
- (IBAction)adjustScale:(UISlider *)sender {
    CGFloat scale = sender.value;
    self.faceView.transform = CGAffineTransformMakeScale(scale, scale);
}
@end
