#import "SCSCalculatorBrain.h"
typedef double  (^BinaryOperationBlock)(double a, double b);

@interface SCSCalculatorBrain ()
@property (strong, nonatomic)NSMutableArray *operandStack;
@property (copy, nonatomic) BinaryOperationBlock addition;
@property (copy, nonatomic) BinaryOperationBlock subtraction;
@end

@implementation SCSCalculatorBrain
- (BinaryOperationBlock)addition {
    if (! _addition) {
        _addition = ^double(double a, double b) {return a + b;};
    }
    return _addition;
}
- (BinaryOperationBlock)subtraction {
    if (! _subtraction) {
        _subtraction = ^double(double a, double b) {return a - b;};
    }
    return _subtraction;
}

- (double)performBinaryOperation:(BinaryOperationBlock) operation {
    double rightOperand = [self popOperand];
    double leftOperand = [self popOperand];
    double result = operation(leftOperand, rightOperand);
    [self pushOperand:result];
    return result;
}
- (double)add {
    return [self performBinaryOperation:self.addition];
}
- (double)subtract {
    return [self performBinaryOperation:self.subtraction];
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
