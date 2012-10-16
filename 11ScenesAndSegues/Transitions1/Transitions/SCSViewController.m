#import "SCSViewController.h"
#import "SCSDetailViewController.h"

@interface SCSViewController ()<SCSDetailViewControllerDelegate>
@end

@implementation SCSViewController
- (IBAction)sampleAButtonPressed:(UIButton *)sender {
    SCSDetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailVC"];
    detailVC.displayedLetter = @"A";
    detailVC.delegate = self;
    [self presentViewController:detailVC
                       animated:YES
                     completion:nil];
}
- (IBAction)sampleBButtonPressed:(UIButton *)sender {
    [self performSegueWithIdentifier:@"segueB"
                              sender:self];
}
- (void)userDidDismissDetailViewController:(SCSDetailViewController *)detailVC {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    SCSDetailViewController *detailVC = segue.destinationViewController;
    detailVC.delegate = self;
    if ([segue.identifier isEqualToString:@"segueB"]) {
        detailVC.displayedLetter = @"B";
    } else if ([segue.identifier isEqualToString:@"segueC"]) {
        detailVC.displayedLetter = @"C";
    }
}


@end
