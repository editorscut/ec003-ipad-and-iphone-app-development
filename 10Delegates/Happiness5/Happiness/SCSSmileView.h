#import <UIKit/UIKit.h>
@protocol SCSSmileViewDataSource;

@interface SCSSmileView : UIView
@property (weak, nonatomic)IBOutlet id<SCSSmileViewDataSource>dataSource;
@end

@protocol SCSSmileViewDataSource <NSObject>
- (CGFloat)happinessLevelForSmileView:(SCSSmileView *)smileView;
@optional
- (void)setHappinessLevel:(CGFloat)happinessLevel
             forSmileView:(SCSSmileView *)smileView;
@end