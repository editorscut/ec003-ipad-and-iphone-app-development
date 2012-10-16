#import "SCSLectures.h"
#import "SCSLecture.h"

@interface SCSLectures ()
//@property (copy, nonatomic) NSArray *privateListOfLectures;
@end

@implementation SCSLectures
- (NSUInteger)count {
    return [self.privateListOfLectures count];
}
- (SCSLecture *)objectAtIndexedSubscript:(NSUInteger)lectureNumber {
    return self.privateListOfLectures[lectureNumber];
}

- (NSArray *)privateListOfLectures {
    if (! _privateListOfLectures) {
        _privateListOfLectures = @[
        [[SCSLecture alloc] initWithNumber:1
                                     title:@"MVC and Intro to Objective-C"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%201_1.pdf"]],
        [[SCSLecture alloc] initWithNumber:2
                                     title:@"My First iOS Application"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/assignments/Walkthrough%20iOS%205_0.pdf"]],
        [[SCSLecture alloc] initWithNumber:3
                                     title:@"Objective C"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%203_2.pdf"]],
        [[SCSLecture alloc] initWithNumber:4
                                     title:@"Views"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%204_1.pdf"]],
        [[SCSLecture alloc] initWithNumber:5
                                     title:@"Protocols and Gestures"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%205_1.pdf"]],
        [[SCSLecture alloc] initWithNumber:6
                                     title:@"Multiple MVCs and Segues"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%206_1.pdf"]],
        [[SCSLecture alloc] initWithNumber:7
                                     title:@"iPad"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%207_1.pdf"]],
        [[SCSLecture alloc] initWithNumber:8
                                     title:@"Controller Lifecycle & Image/Scroll/WebViews"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%208_1.pdf"]],
        [[SCSLecture alloc] initWithNumber:9
                                     title:@"Table Views"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%209_1.pdf"]],
        [[SCSLecture alloc] initWithNumber:10
                                     title:@"Blocks and Multithreading"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%2010_3.pdf"]],
        [[SCSLecture alloc] initWithNumber:11
                                     title:@"Core Location/Map Kit"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%2011_3.pdf"]],
        [[SCSLecture alloc] initWithNumber:12
                                     title:@"Persistence"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%2012_3.pdf"]],
        [[SCSLecture alloc] initWithNumber:13
                                     title:@"Core Data"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%2013_2.pdf"]],
        [[SCSLecture alloc] initWithNumber:14
                                     title:@"Core Data Demo"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%2014_3.pdf"]],
        [[SCSLecture alloc] initWithNumber:15
                                     title:@"Modal View Controllers/Text/Animation/Timer"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%2015_0.pdf"]],
        [[SCSLecture alloc] initWithNumber:16
                                     title:@"Action Sheets, Image Picker, Core Motion"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%2016_3.pdf"]],
        [[SCSLecture alloc] initWithNumber:17
                                     title:@"iCloud"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%2017_1.pdf"]],
        [[SCSLecture alloc] initWithNumber:18
                                     title:@"More iCloud"
                                       URL:[NSURL URLWithString:@"http://www.stanford.edu/class/cs193p/cgi-bin/drupal/system/files/lectures/Lecture%2018_1.pdf"]]
        ];
    }
    return _privateListOfLectures;
}

@end
