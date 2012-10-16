#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class SCSPhoto;

@interface SCSPhotographer : NSManagedObject

@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *photos;
@end

@interface SCSPhotographer (CoreDataGeneratedAccessors)

- (void)addPhotosObject:(SCSPhoto *)value;
- (void)removePhotosObject:(SCSPhoto *)value;
- (void)addPhotos:(NSSet *)values;
- (void)removePhotos:(NSSet *)values;

@end
