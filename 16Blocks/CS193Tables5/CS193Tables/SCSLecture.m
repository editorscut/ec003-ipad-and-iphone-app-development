#import "SCSLecture.h"

NSString * const SCSLectureNewLecturePostedNotification = @"SCSLectureNewLecturePostedNotification";

@implementation SCSLecture
- (id)initWithNumber:(NSInteger)lectureNumber
               title:(NSString *)lectureTitle
                 URL:(NSURL *)lectureURL {
    self = [super init];
    if (self) {
        _lectureNumber = lectureNumber;
        _lectureTitle = lectureTitle;
        _lectureURL = lectureURL;
    }
    return self;
}
- (id)init {
    return [self initWithNumber:0 title:nil URL:nil];
}


@end
