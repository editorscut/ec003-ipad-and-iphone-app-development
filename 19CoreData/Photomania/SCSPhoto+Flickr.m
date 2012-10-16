#import "SCSPhoto+Flickr.h"
#import "FlickrFetcher.h"
#import "SCSPhotographer+Create.h"

@implementation SCSPhoto (Flickr)

+ (SCSPhoto *)photoWithFlickrInfo:(NSDictionary *)flickrInfo
           inManagedObjectContext:(NSManagedObjectContext *)context {
    SCSPhoto *photo = nil;
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SCSPhoto"];
    request.predicate = [NSPredicate predicateWithFormat:@"unique = %@",[flickrInfo objectForKey:FLICKR_PHOTO_ID]];
    NSError *error = nil;
    NSArray *matches = [context executeFetchRequest:request
                                              error:&error];
    if (! matches) {
        // handle error
    } else if ([matches count] == 0) {
        photo = [NSEntityDescription insertNewObjectForEntityForName:@"SCSPhoto"
                                              inManagedObjectContext:context];
        [self configurePhoto:photo
              withFlickrInfo:flickrInfo
      inManagedObjectContext:context];
    } else {
        photo = [matches lastObject];
    }
    return photo;
}

+ (void)configurePhoto:(SCSPhoto*)photo
        withFlickrInfo:(NSDictionary *)flickrInfo
inManagedObjectContext:(NSManagedObjectContext *)context {
    photo.unique = [flickrInfo objectForKey:FLICKR_PHOTO_ID];
    photo.title = [flickrInfo objectForKey:FLICKR_PHOTO_TITLE];
    photo.subtitle = [flickrInfo objectForKey:FLICKR_PHOTO_DESCRIPTION];
    photo.imageURL = [[FlickrFetcher urlForPhoto:flickrInfo
                                          format:FlickrPhotoFormatLarge]absoluteString];
    photo.whoTook = [SCSPhotographer photographerWithName:[flickrInfo objectForKey:FLICKR_PHOTO_OWNER]
                                   inManagedObjectContext:context];
}

@end
