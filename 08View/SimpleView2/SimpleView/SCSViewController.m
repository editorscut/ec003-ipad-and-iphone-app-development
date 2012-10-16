#import "SCSViewController.h"

@implementation SCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self displayTitleImage];
    [self displayTitleLabel];
}
- (void)displayTitleImage {
    CGRect imageRect = CGRectMake(20, 120, 280, 220);
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:imageRect];
    imageView.image = [UIImage imageNamed:@"titleslide.png"];
    [self.view addSubview:imageView];
}
- (void)displayTitleLabel {
    CGRect labelRect = CGRectMake(110, 360, 100, 21);
    UILabel *label = [[UILabel alloc] initWithFrame:labelRect];
    label.font = [UIFont systemFontOfSize:18];
    label.text = @"CS 193p";
    [self.view addSubview:label];
}
@end
