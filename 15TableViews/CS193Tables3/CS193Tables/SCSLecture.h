#import <Foundation/Foundation.h>

@interface SCSLecture : NSObject
@property (nonatomic) NSInteger lectureNumber;
@property (copy, nonatomic) NSString *lectureTitle;
@property (strong, nonatomic) NSURL *lectureURL;
- (id)initWithNumber:(NSInteger)lectureNumber
               title:(NSString *)lectureTitle
                 URL:(NSURL *)lectureURL;
@end
