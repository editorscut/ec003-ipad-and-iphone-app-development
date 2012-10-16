#import "SCSPhotographer.h"

@interface SCSPhotographer (Create)
+ (SCSPhotographer *)photographerWithName:(NSString *)name
                   inManagedObjectContext:(NSManagedObjectContext *)context;
@end
