#import "SCSPhotographersTableViewController.h"
#import "FlickrFetcher.h"
#import "SCSPhoto.h"
#import "SCSPhoto+Flickr.h"
#import "SCSPhotographer.h"
#import "SCSPhotosByPhotographerViewController.h"

@interface SCSPhotographersTableViewController ()

@end

@implementation SCSPhotographersTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if (! self.photoDatabase) {
        NSURL *documentDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                              inDomains:NSUserDomainMask] lastObject];
        NSURL *databaseURL = [documentDirectoryURL URLByAppendingPathComponent:@"PhotoDatabase"];
        self.photoDatabase = [[UIManagedDocument alloc] initWithFileURL:databaseURL];
        [self useDocument];
    }
}
- (void)useDocument {
    [self.photoDatabase openWithCompletionHandler:^(BOOL success) {
        if (success) {
            [self setUpFetchedResultsController];
        } else {
            [self createAndSetUpFile];
        }
    }];
}
- (void)createAndSetUpFile {
    [self.photoDatabase saveToURL:self.photoDatabase.fileURL
                 forSaveOperation:UIDocumentSaveForCreating
                completionHandler:^(BOOL success) {
                    [self setUpFetchedResultsController];
                    [self fetchFlickrDataIntoDocument];
                }];
}
- (void)fetchFlickrDataIntoDocument  {
    dispatch_queue_t fetchQ = dispatch_queue_create("Flickr fetcher", NULL);
    dispatch_async(fetchQ, ^{
        NSArray *photos = [FlickrFetcher recentGeoreferencedPhotos];
        [self.photoDatabase.managedObjectContext performBlock:^{
            for (NSDictionary *flickrInfo in photos) {
                [SCSPhoto photoWithFlickrInfo:flickrInfo
                    inManagedObjectContext:self.photoDatabase.managedObjectContext];
            }
            [self.photoDatabase saveToURL:self.photoDatabase.fileURL
                         forSaveOperation:UIDocumentSaveForOverwriting
                        completionHandler:NULL];
        }];
    });
}

- (void)setUpFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SCSPhotographer"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name"
                                                              ascending:YES
                                                               selector:@selector(localizedCaseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.photoDatabase.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Photographer Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                            forIndexPath:indexPath];
    SCSPhotographer *photographer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photographer.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d photos",[photographer.photos count]];
    return cell;
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
    SCSPhotographer *photographer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    SCSPhotosByPhotographerViewController *photosVC = segue.destinationViewController;
    [photosVC findPhotosForPhotographer:photographer];
}
@end
