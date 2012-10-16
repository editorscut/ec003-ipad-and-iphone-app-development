#import "SCSAskerViewController.h"

@interface SCSAskerViewController () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *inputField;

@end

@implementation SCSAskerViewController

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if ([textField.text length] == 0) {
        return NO;
    } else {
        [textField resignFirstResponder];
        [self.delegate askerViewController:self
                          didProvideAnswer:textField.text
                                 forPrompt:self.prompt];
        return YES;
    }
}
- (IBAction)cancelButtonTapped:(UIBarButtonItem *)sender {
    [self.delegate askerViewControllerDidCancel:self];
}
-(void)viewDidLoad {
    [super viewDidLoad];
    self.inputField.placeholder = self.prompt;
}
@end
