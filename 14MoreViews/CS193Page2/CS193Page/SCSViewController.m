#import "SCSViewController.h"

@interface SCSViewController ()<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
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
- (void)webViewDidStartLoad:(UIWebView *)webView {
    [self.activityIndicator startAnimating];
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityIndicator stopAnimating];
    [self.doneButton setEnabled:YES];
}

@end
