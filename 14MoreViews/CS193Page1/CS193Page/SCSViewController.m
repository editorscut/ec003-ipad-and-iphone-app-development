#import "SCSViewController.h"

@interface SCSViewController ()
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end

@implementation SCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *location = @"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/fall-2011";
    NSURL *courseURL = [NSURL URLWithString:location];
    NSURLRequest *request = [NSURLRequest requestWithURL:courseURL];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
