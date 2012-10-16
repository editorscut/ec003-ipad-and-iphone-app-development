#import "SCSLectureViewController.h"
#import "SCSLecture.h"

@interface SCSLectureViewController ()
@property (weak, nonatomic) IBOutlet UILabel *lectureTitleLabel;
@property (weak, nonatomic) IBOutlet UIWebView *lectureSlideWebView;
@end

@implementation SCSLectureViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = [NSString stringWithFormat:@"Lecture %d", self.lecture.lectureNumber];
    self.lectureTitleLabel.text = self.lecture.lectureTitle;
    [self.lectureSlideWebView loadRequest:[NSURLRequest requestWithURL:self.lecture.lectureURL]];
}

@end
