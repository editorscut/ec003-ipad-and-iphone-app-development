#import "SCSHappinessViewController.h"
#import "SCSCircleView.h"
#import "SCSHappiness.h"
#import "SCSSmileView.h"

@interface SCSHappinessViewController ()<SCSSmileViewDataSource>
@property (weak, nonatomic) IBOutlet SCSCircleView *faceView;
@property (strong, nonatomic) SCSHappiness *model;
@end

@implementation SCSHappinessViewController
- (CGFloat)happinessLevelForSmileView:(SCSSmileView *)smileView {
    return self.model.happinessPercentage/100 * smileView.frame.size.height;
}
- (void)setHappinessLevel:(CGFloat)happinessLevel
             forSmileView:(SCSSmileView *)smileView {
    self.model.happinessPercentage = 100 * happinessLevel/smileView.frame.size.height;
}
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
