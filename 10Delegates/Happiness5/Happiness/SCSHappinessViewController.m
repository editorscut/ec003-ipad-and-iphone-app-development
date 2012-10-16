#import "SCSHappinessViewController.h"
#import "SCSCircleView.h"
#import "SCSHappiness.h"

@interface SCSHappinessViewController ()
@property (weak, nonatomic) IBOutlet SCSCircleView *faceView;
@property (strong, nonatomic) SCSHappiness *model;
@end

@implementation SCSHappinessViewController
- (SCSHappiness *)model {
    if (! _model) {
        _model = [[SCSHappiness alloc]init];
    }
    return _model;
}
//...
- (IBAction)adjustScale:(UIPinchGestureRecognizer *)sender {
    CGFloat scale = MIN(sender.scale, 1);
    scale = MAX(scale, .01);
    self.faceView.transform = CGAffineTransformMakeScale(scale, scale);
}
-(BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)orientation {
    return (orientation != UIInterfaceOrientationPortraitUpsideDown);
}
@end
