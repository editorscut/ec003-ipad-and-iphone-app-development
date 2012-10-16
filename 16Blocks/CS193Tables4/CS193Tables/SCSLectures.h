#import <Foundation/Foundation.h>
@class SCSLecture;

@interface SCSLectures : NSObject
- (NSUInteger)count;
- (SCSLecture *)objectAtIndexedSubscript:(NSUInteger)lectureNumber;
@property (copy, nonatomic) NSArray *privateListOfLectures;

@end
