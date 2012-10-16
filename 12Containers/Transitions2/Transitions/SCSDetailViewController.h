#import <UIKit/UIKit.h>
@protocol SCSDetailViewControllerDelegate;

@interface SCSDetailViewController : UIViewController
@property (strong, nonatomic) NSString *displayedLetter;
@property (weak, nonatomic) IBOutlet id<SCSDetailViewControllerDelegate>delegate;
@end

@protocol SCSDetailViewControllerDelegate <NSObject>
- (void)userDidDismissDetailViewController:(SCSDetailViewController *)detailVC;
@end