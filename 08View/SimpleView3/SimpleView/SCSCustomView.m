#import "SCSCustomView.h"

@implementation SCSCustomView

- (void)drawRect:(CGRect)rect {
    [self drawImage];
    [self drawLabel];
}
- (void)drawImage {
    CGRect imageRect = CGRectMake(20, 120, 280, 220);
    UIImage *image = [UIImage imageNamed:@"titleslide.png"];
    [image drawInRect:imageRect];
}
- (void)drawLabel {
    CGRect labelRect = CGRectMake(110, 360, 100, 21);
    [@"CS 193p" drawInRect:labelRect
                  withFont:[UIFont systemFontOfSize:18]];
}
@end
