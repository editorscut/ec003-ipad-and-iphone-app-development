#import <Foundation/Foundation.h>

@interface SCSCalculatorBrain : NSObject
- (void)enterNumber:(double)number;

- (double)add;
- (double)subtract;
+ (id)sharedBrain;
@end