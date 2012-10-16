#import "SCSNavDetailViewController.h"

@interface SCSNavDetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *displayedLetterLabel;
@end

@implementation SCSNavDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.displayedLetterLabel.text = self.displayedLetter;
}
@end
