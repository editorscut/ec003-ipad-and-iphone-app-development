#import "SCSDetailViewController.h"

@interface SCSDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayedLetterLabel;
@end

@implementation SCSDetailViewController
-(void)viewDidLoad {
    [super viewDidLoad];
    self.displayedLetterLabel.text = self.displayedLetter;
}
- (IBAction)dismissButtonPressed:(UIButton *)sender {
    [self.delegate userDidDismissDetailViewController:self];
}
@end
