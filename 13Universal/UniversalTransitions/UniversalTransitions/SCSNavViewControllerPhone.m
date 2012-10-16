#import "SCSNavViewControllerPhone.h"
#import "SCSNavDetailViewController.h"

@interface SCSNavViewControllerPhone ()
@property(strong, nonatomic) SCSNavDetailViewController *detailVC;
@end

@implementation SCSNavViewControllerPhone
-(void)prepareForSegue:(UIStoryboardSegue *)segue
                sender:(id)sender {
    self.detailVC = segue.destinationViewController;
}
- (void)performSegueWithLetter:(NSString *)letter {
    [self performSegueWithIdentifier:@"pushButtonChoice"
                              sender:self];
    [self.detailVC displayTheLetter:letter];
}
- (IBAction)sampleDPressed:(UIButton *)sender {
    [self performSegueWithLetter:@"D"];
}
- (IBAction)sampleEPressed:(UIButton *)sender {
    [self performSegueWithLetter:@"E"];
}
- (IBAction)sampleFPressed:(UIButton *)sender {
    [self performSegueWithLetter:@"F"];
}
@end
