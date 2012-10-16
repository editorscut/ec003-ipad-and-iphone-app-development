#import "SCSPhotographer+Create.h"

@implementation SCSPhotographer (Create)

+ (SCSPhotographer *)photographerWithName:(NSString *)name
                   inManagedObjectContext:(NSManagedObjectContext *)context {
    NSFetchRequest *request
        = [NSFetchRequest fetchRequestWithEntityName:@"SCSPhotographer"];
    request.predicate = [NSPredicate predicateWithFormat:@"name = %@", name];
    NSError *error = nil;
    NSArray *photographers = [context executeFetchRequest:request
                                                    error:&error];
    SCSPhotographer *photographer = nil;
    if (! photographers) {
        // handle error
    } else if ([photographers count] == 0) {
        photographer
           = [NSEntityDescription insertNewObjectForEntityForName:@"SCSPhotographer"
                                           inManagedObjectContext:context];
        photographer.name = name;
    } else {
        photographer = [photographers lastObject];
    }
    return photographer;
}

@end
