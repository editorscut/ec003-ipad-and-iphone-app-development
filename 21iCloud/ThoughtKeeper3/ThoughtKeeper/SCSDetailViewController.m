#import "SCSDetailViewController.h"
#import "SCSGreatThought.h"

@interface SCSDetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *thoughtView;
@end

@implementation SCSDetailViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.currentThought openWithCompletionHandler:^(BOOL success) {
        if (success) {
            self.thoughtView.text = self.currentThought.thought;
            self.thoughtView.editable = YES;
            [self.thoughtView becomeFirstResponder];
        }
    }];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.currentThought.thought = self.thoughtView.text;
    [self.currentThought saveToURL:self.currentThought.fileURL
                  forSaveOperation:UIDocumentSaveForOverwriting
                 completionHandler:nil];
    [self.currentThought closeWithCompletionHandler:nil];
}

@end
