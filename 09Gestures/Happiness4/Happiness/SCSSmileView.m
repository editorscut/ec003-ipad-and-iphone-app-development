#import "SCSSmileView.h"

@implementation SCSSmileView {
    BOOL geometryIsSet;
    CGPoint leftCornerOfSmile, rightCornerOfSmile, controlPoint;
}
- (IBAction)adjustSmile:(UIPanGestureRecognizer *)sender {
    CGFloat yValue = [sender locationInView:self].y;
    CGFloat bottomYValue = self.bounds.size.height;
    yValue = MIN(yValue, bottomYValue);
    yValue = MAX(yValue, 0);
    controlPoint = CGPointMake(controlPoint.x, yValue);
    [self setNeedsDisplay];
}
- (void)setGeometry {
    CGRect rect = self.bounds;
    CGFloat leftXValue = 10;
    CGFloat rightXValue = rect.size.width - leftXValue;
    CGFloat bottomYValue = rect.size.height;
    CGFloat verticalCenter = rect.size.height/2;
    CGFloat horizontalCenter = rect.size.width/2;     
    leftCornerOfSmile = CGPointMake(leftXValue, verticalCenter);
    rightCornerOfSmile = CGPointMake(rightXValue, verticalCenter);
    controlPoint = CGPointMake(horizontalCenter, bottomYValue);
    geometryIsSet = YES;
}

- (void)drawRect:(CGRect)rect {
    if (!geometryIsSet) {
        [self setGeometry];
    }
    [[UIColor blueColor] setStroke];
    UIBezierPath *smile = [UIBezierPath bezierPath];
    [smile moveToPoint:leftCornerOfSmile];
    [smile addQuadCurveToPoint:rightCornerOfSmile
                  controlPoint:controlPoint];
    smile.lineWidth = 4;
    smile.lineCapStyle = kCGLineCapRound;
    [smile stroke];
}
@end
