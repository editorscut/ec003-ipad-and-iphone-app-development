#import "SCSCalculatorBrain.h"

@interface SCSCalculatorBrain ()
@property (strong, nonatomic)NSMutableArray *operandStack;
@end

@implementation SCSCalculatorBrain
- (double)performBinaryOperation:(NSString *)operation {
    double result = 0;
    double rightOperand = [self popOperand];
    double leftOperand = [self popOperand];
    if ([operation isEqualToString:@"add"]) {
        result = leftOperand + rightOperand;
    } else if ([operation isEqualToString:@"subtract"]) {
        result = leftOperand - rightOperand;
    } // check for more operations ...
    [self pushOperand:result];
    return result;
    if (! self.operandStack) {/* */}
}
- (double)add {
    return [self performBinaryOperation:@"add"];
}
- (double)subtract {
    return [self performBinaryOperation:@"subtract"];
}
- (void)enterNumber:(double)number {
    [self pushOperand:number];
}
- (NSMutableArray *)operandStack {
    if (_operandStack == nil) {
       _operandStack = [[NSMutableArray alloc]init]; 
    }
    return _operandStack;
}
- (void)pushOperand:(double)operand {
    [self.operandStack addObject:@(operand)];
}
- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject)[self.operandStack removeLastObject];
    return [operandObject doubleValue];
}
+ (id)sharedBrain {
    static SCSCalculatorBrain *_sharedBrain = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedBrain = [[self alloc]init];
    });
    return _sharedBrain;
}
@end
