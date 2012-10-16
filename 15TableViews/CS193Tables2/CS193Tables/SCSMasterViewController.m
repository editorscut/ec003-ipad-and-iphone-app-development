#import "SCSMasterViewController.h"
#import "SCSLectures.h"
#import "SCSLecture.h"
#import "SCSLectureInfoCell.h"

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
