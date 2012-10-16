#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SCSPhotographer;

@interface SCSPhoto : NSManagedObject

@property (nonatomic, retain) NSString * imageURL;
@property (nonatomic, retain) NSString * subtitle;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * unique;
@property (nonatomic, retain) SCSPhotographer *whoTook;

@end
