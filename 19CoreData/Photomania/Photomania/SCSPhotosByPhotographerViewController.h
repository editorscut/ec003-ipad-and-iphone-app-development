#import "CoreDataTableViewController.h"
#import "SCSPhotographer.h"

@interface SCSPhotosByPhotographerViewController : CoreDataTableViewController
- (void)findPhotosForPhotographer:(SCSPhotographer *)photographer;
@end
