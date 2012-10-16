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
    // ask the data source to set its happiness value to the yValue
    if ([self.dataSource respondsToSelector:@selector(setHappinessLevel:forSmileView:)]) {
        [self.dataSource setHappinessLevel:yValue
                              forSmileView:self];
    }
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
    // ask data source for happiness value and use it for control point
    CGFloat controlYValue = [self.dataSource happinessLevelForSmileView:self];
    controlPoint = CGPointMake(controlPoint.x, controlYValue);
    // continue as before
    [smile addQuadCurveToPoint:rightCornerOfSmile
                  controlPoint:controlPoint];
    smile.lineWidth = 4;
    smile.lineCapStyle = kCGLineCapRound;
    [smile stroke];
}
@end
