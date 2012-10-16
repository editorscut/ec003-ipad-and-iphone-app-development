#import "SCSCircleView.h"

@implementation SCSCircleView

- (void)drawRect:(CGRect)rect {
    [[UIColor blueColor] setStroke];
    UIBezierPath *circle = [UIBezierPath bezierPathWithOvalInRect:rect];
    circle.lineWidth = 8;
    [circle addClip];
    [circle stroke];
}
@end
