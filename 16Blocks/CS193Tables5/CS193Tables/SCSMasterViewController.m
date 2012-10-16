#import "SCSMasterViewController.h"
#import "SCSLectures.h"
#import "SCSLecture.h"
#import "SCSLectureInfoCell.h"
#import "SCSLectureViewController.h"

@interface SCSMasterViewController ()
@property (strong, nonatomic) SCSLectures *lectures;
@property (copy, nonatomic) NSArray *privateListOfLectures;
@end

@implementation SCSMasterViewController
- (SCSLectures *)lectures {
    if (! _lectures) {
        _lectures = [[SCSLectures alloc] init];
    }
    return _lectures;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    SCSLectureViewController *lectureVC = segue.destinationViewController;
    NSInteger rowNumber = [self.tableView indexPathForSelectedRow].row;
    lectureVC.lecture = self.lectures[rowNumber];
}
#pragma mark - data source methods
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
-(NSInteger)  tableView:(UITableView *)tableView
  numberOfRowsInSection:(NSInteger)section {
    return [self.lectures count];
}
-(UITableViewCell *)tableView:(UITableView *)tableView
        cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SCSLectureInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LectureCell"];
    NSUInteger lectureNumber = self.lectures[indexPath.row].lectureNumber;
    cell.lectureNumberLabel.text = [NSString stringWithFormat:@"%d",lectureNumber];
    cell.lectureTitleLabel.text = self.lectures[indexPath.row].lectureTitle;
    return cell;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self logLecturesToConsole];
    [self registerForNotification];
}
//- (void)logLecturesToConsole {
//    NSArray *lectures = self.lectures.privateListOfLectures;
//    int count = [lectures count];
//    for (int i = 0; i < count; i++) {
//        SCSLecture *lecture = lectures[i];
//        NSLog(@"Lecture %d:%@",lecture.lectureNumber,lecture.lectureTitle);
//    }
//}
//- (void)logLecturesToConsole {
//    NSArray *lectures = self.lectures.privateListOfLectures;
//    for (SCSLecture *lecture in lectures) {
//        NSLog(@"Lecture %d:%@",lecture.lectureNumber,lecture.lectureTitle);
//    }
//}
- (void)logLecturesToConsole {
    NSArray *lectures = self.lectures.privateListOfLectures;
    [lectures enumerateObjectsUsingBlock:^(SCSLecture *lecture, NSUInteger idx, BOOL *stop) {
        NSLog(@"Lecture %d:%@",lecture.lectureNumber,lecture.lectureTitle);
    }];
}
//- (void)registerForNotification {
//    [[NSNotificationCenter defaultCenter] addObserver:self
//                                             selector:@selector(newLecturePosted:)
//                                                 name:SCSLectureNewLecturePostedNotification
//                                               object:nil];
//}
//
//- (void)newLecturePosted:(NSNotification *)notification {
//    NSLog(@"Posted lecture about %@",[notification userInfo][@"lecture"]);
//}

- (void)registerForNotification {
    [[NSNotificationCenter defaultCenter] addObserverForName:SCSLectureNewLecturePostedNotification
                                                      object:nil
                                                       queue:[NSOperationQueue mainQueue]
                                                  usingBlock:^(NSNotification *notification) {
                                                      NSLog(@"Posted lecture about %@",[notification userInfo][@"lecture"]);
                                                  }];
}




@end
