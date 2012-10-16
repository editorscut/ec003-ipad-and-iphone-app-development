#import "SCSCalculatorBrain.h"

@interface SCSCalculatorBrain ()
@property (strong, nonatomic)NSMutableArray *operandStack;
@end

@implementation SCSCalculatorBrain
- (double)performBinaryOperation:(double (^)(double a, double b))operation {
    double rightOperand = [self popOperand];
    double leftOperand = [self popOperand];
    double result = operation(leftOperand, rightOperand);
    [self pushOperand:result];
    return result;
}
- (double)add {
    return [self performBinaryOperation:^double(double a, double b) {
        return a + b;
    }];
}
- (double)subtract {
    return [self performBinaryOperation:^double(double a, double b) {
        return a - b;
    }];
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
