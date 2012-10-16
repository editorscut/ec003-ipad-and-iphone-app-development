#import "SCSViewController.h"

@interface SCSViewController ()
@property (weak, nonatomic) IBOutlet UILabel *calculatorDisplay;
@end

@implementation SCSViewController {
    BOOL userIsInTheMiddleOfEnteringANumber;
}

- (IBAction)digitButtonPressed:(UIButton *)sender {
    if (userIsInTheMiddleOfEnteringANumber) {
        [self appendDigit:sender.currentTitle];
    } else {
        [self displayDigit:sender.currentTitle];
    }
}
- (void)appendDigit:(NSString *)digit {
    self.calculatorDisplay.text = [self.calculatorDisplay.text stringByAppendingString:digit];
}
- (void)displayDigit:(NSString *)digit {
    self.calculatorDisplay.text = digit;
    userIsInTheMiddleOfEnteringANumber = YES;
}
@end
