#import <UIKit/UIKit.h>
@protocol SCSAskerViewControllerDelegate;

@interface SCSAskerViewController : UIViewController
@property (strong, nonatomic) NSString *prompt;
@property (weak, nonatomic) id<SCSAskerViewControllerDelegate>delegate;
@end

@protocol SCSAskerViewControllerDelegate <NSObject>
- (void)askerViewController:(SCSAskerViewController *)askerVC
didProvideAnswer:(NSString *)answer
                  forPrompt:(NSString *)prompt;
- (void)askerViewControllerDidCancel:(SCSAskerViewController *)askerVC;
@end