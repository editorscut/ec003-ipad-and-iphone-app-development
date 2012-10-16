#import "SCSViewController.h"
#import "SCSCalculatorBrain.h"

@interface SCSViewController ()
@property (weak, nonatomic) IBOutlet UILabel *calculatorDisplay;
@property (strong, nonatomic) SCSCalculatorBrain *brain;
@property (copy, nonatomic) NSString *advisoryWarning;
@property UIButton *myButton;
@end

@implementation SCSViewController {
    BOOL userIsInTheMiddleOfEnteringANumber;
}
- (void)autoEnter {
    if (userIsInTheMiddleOfEnteringANumber) { 
        [self enterButtonTapped];
    }
}
- (void)displayResult:(double)result {
    NSString *resultString = [NSString stringWithFormat:@"%g",result];
    self.calculatorDisplay.text = resultString;
}
- (SCSCalculatorBrain *)brain { 
    if (_brain == nil) {
        _brain = [[SCSCalculatorBrain alloc] init];
    }
    return _brain;
}
- (void)appendDigit:(NSString *)digit {
    self.calculatorDisplay.text = [self.calculatorDisplay.text stringByAppendingString:digit];
}
- (void)displayDigit:(NSString *)digit {
    self.calculatorDisplay.text = digit;
    userIsInTheMiddleOfEnteringANumber = YES;
}

- (IBAction)enterButtonTapped {
    [self.brain enterNumber:[self.calculatorDisplay.text doubleValue]];
    userIsInTheMiddleOfEnteringANumber = NO;
}
- (IBAction)addButtonTapped {
    [self autoEnter];
    [self displayResult:[self.brain add]];
}
- (IBAction)subtractButtonTapped {
    [self autoEnter];
    [self displayResult:[self.brain subtract]];
}
- (IBAction)digitButtonTapped:(UIButton *)sender {
    if (userIsInTheMiddleOfEnteringANumber) {
        [self appendDigit:sender.currentTitle];
    } else {
        [self displayDigit:sender.currentTitle];
    }
}
@end









