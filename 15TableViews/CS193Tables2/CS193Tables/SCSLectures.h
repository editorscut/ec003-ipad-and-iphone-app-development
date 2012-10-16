#import <Foundation/Foundation.h>
@class SCSLecture;

@interface SCSLectures : NSObject
- (NSUInteger)count;
- (SCSLecture *)objectAtIndexedSubscript:(NSUInteger)lectureNumber;
@end
