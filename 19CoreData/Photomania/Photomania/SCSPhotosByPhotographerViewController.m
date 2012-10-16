#import "SCSPhotosByPhotographerViewController.h"
#import "SCSPhoto.h"

@interface SCSPhotosByPhotographerViewController ()
@property (strong, nonatomic) SCSPhotographer *photographer;
@end

@implementation SCSPhotosByPhotographerViewController
- (void)findPhotosForPhotographer:(SCSPhotographer *)photographer {
    _photographer = photographer;
    self.title = photographer.name;
    [self setupFetchedResultsController];
}
- (void)setupFetchedResultsController {
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"SCSPhoto"];
    request.predicate = [NSPredicate predicateWithFormat:@"whoTook = %@", self.photographer];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"title"
                                                              ascending:YES
                                                               selector:@selector(localizedCaseInsensitiveCompare:)]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request
                                                                        managedObjectContext:self.photographer.managedObjectContext
                                                                          sectionNameKeyPath:nil cacheName:nil];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    SCSPhoto *photo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = photo.title;
    cell.detailTextLabel.text = photo.subtitle;
    return cell;
}

@end
