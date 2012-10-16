#import "SCSPhoto.h"

@interface SCSPhoto (Flickr)
+ (SCSPhoto *)photoWithFlickrInfo:(NSDictionary *)flickrInfo
           inManagedObjectContext:(NSManagedObjectContext *)context;
@end
