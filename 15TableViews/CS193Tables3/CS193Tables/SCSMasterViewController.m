#import "SCSMasterViewController.h"
#import "SCSLectures.h"
#import "SCSLecture.h"
#import "SCSLectureInfoCell.h"
#import "SCSLectureViewController.h"

@interface SCSMasterViewController ()
@property (strong, nonatomic) SCSLectures *lectures;
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
@end
