#import "SCSMasterViewController.h"
#import "SCSAskerViewController.h"
#import "SCSDetailViewController.h"
#import "SCSGreatThought.h"

@interface SCSMasterViewController ()<SCSAskerViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *thoughts;
@property (strong, nonatomic) NSURL *documentsURL;
@property (strong, nonatomic) NSURL *cloudDocumentsURL;
@end

@implementation SCSMasterViewController
- (NSURL *)cloudDocumentsURL {
    if (! _cloudDocumentsURL) {
        NSURL *cloudURL = [[NSFileManager defaultManager] URLForUbiquityContainerIdentifier:@"TEAM_ID_HERE.edu.stanford.cs193p.book.ThoughtKeeper"];
        _cloudDocumentsURL = [cloudURL URLByAppendingPathComponent:@"Documents"];
    }
    return _cloudDocumentsURL;
}
- (NSURL *)cloudURLForLocalURL:(NSURL *)localURL {
    return [self.cloudDocumentsURL URLByAppendingPathComponent:[localURL lastPathComponent]];
}
- (NSURL *)documentsURL {
    if (! _documentsURL) {
        NSURL *documentDirectoryURL = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                                              inDomains:NSUserDomainMask] lastObject];
        _documentsURL = [documentDirectoryURL URLByAppendingPathComponent:@"Thoughts"];
        NSError *error;
        [[NSFileManager defaultManager] createDirectoryAtURL:_documentsURL
                                 withIntermediateDirectories:YES
                                                  attributes:nil
                                                       error:&error];
    }
    return  _documentsURL;
}
- (NSMutableArray *)thoughts {
    if (! _thoughts) {
        NSError *error;
        NSArray *storedThoughts = [[NSFileManager defaultManager] contentsOfDirectoryAtURL:self.documentsURL
                                                                includingPropertiesForKeys:nil
                                                                                   options:NSDirectoryEnumerationSkipsHiddenFiles error:&error];
        if (storedThoughts) {
            _thoughts = [storedThoughts mutableCopy];
        } else {
            _thoughts = [[NSMutableArray alloc] init];
        }
    }
    return _thoughts;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return [self.thoughts count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ThoughtCell"
                                                            forIndexPath:indexPath];
    NSURL *thoughtURL = self.thoughts[indexPath.row];
    cell.textLabel.text = [thoughtURL lastPathComponent];
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)   tableView:(UITableView *)tableView
  commitEditingStyle:(UITableViewCellEditingStyle)editingStyle
   forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        NSURL *fileURL = self.thoughts[indexPath.row];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
            NSFileCoordinator *fileCoordinator = [[NSFileCoordinator alloc] initWithFilePresenter:nil];
            [fileCoordinator coordinateWritingItemAtURL:fileURL
                                                options:NSFileCoordinatorWritingForDeleting
                                                  error:nil
                                             byAccessor:^(NSURL *writingURL) {
                                                 NSFileManager *fileManager = [[NSFileManager alloc] init];
                                                 NSError *error;
                                                 BOOL isRemovedFromCloud = [fileManager removeItemAtURL:writingURL
                                                                                                  error:&error];
                                                 if (isRemovedFromCloud) {
                                                     dispatch_async(dispatch_get_main_queue(), ^(void){
                                                         [self.thoughts removeObjectAtIndex:indexPath.row];
                                                     [tableView deleteRowsAtIndexPaths:@[indexPath]
                                                                      withRowAnimation:UITableViewRowAnimationFade];
                                                     });
                                                 } else {
                                                     NSLog(@"File %@ failed to be removed from cloud with error %@.",writingURL, error);
                                                 }
                                             }];
            
        });
    }
}
- (void)createThoughtWithTitle:(NSString *)title {
    SCSGreatThought __block *thought = [[SCSGreatThought alloc] initWithFileURL:[self urlForTitle:title]];
    [thought saveToURL:[self urlForTitle:title]
      forSaveOperation:UIDocumentSaveForCreating
     completionHandler:^(BOOL success){
         if (! success) {
             NSLog(@"%@ File was not successfully saved locally.",title);
         } else {
             NSURL *destinationURL = [self cloudURLForLocalURL:thought.fileURL];
             dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^(void){
                 NSFileManager *fileManager = [[NSFileManager alloc] init];
                 NSError *error;
                 BOOL iCloudSuccess = [fileManager setUbiquitous:YES
                                                       itemAtURL:thought.fileURL
                                                  destinationURL:destinationURL
                                                           error:&error];
                 if (iCloudSuccess) {
                     dispatch_async(dispatch_get_main_queue(), ^(void){
                         [self insertThought:[[SCSGreatThought alloc] initWithFileURL:destinationURL] WithTitle:title];
             });
                 } else {
                     NSLog(@"Couldn't move file %@ to iCloud.",thought.localizedName);
                 }
         });
         }
     }];
} 
- (NSURL *)urlForTitle:(NSString *)title {
    return [self.documentsURL URLByAppendingPathComponent:title];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue
                 sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        NSURL *thoughtURL = self.thoughts[indexPath.row];
        SCSGreatThought *thought = [[SCSGreatThought alloc] initWithFileURL:thoughtURL];
        SCSDetailViewController *detailVC = segue.destinationViewController;
        detailVC.navigationItem.title = [thoughtURL lastPathComponent];
        detailVC.currentThought = thought;
    } //...
    else if ([[segue identifier] isEqualToString:@"enterDocumentTitle"]) {
        SCSAskerViewController *askerVC = segue.destinationViewController;
        askerVC.prompt = @"Enter document name";
        askerVC.delegate = self;
    }
}
- (void)askerViewControllerDidCancel:(SCSAskerViewController *)askerVC {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}
-(void)askerViewController:(SCSAskerViewController *)askerVC
          didProvideAnswer:(NSString *)answer
                 forPrompt:(NSString *)prompt {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
    if ([self.thoughts containsObject:[self urlForTitle:answer]]) {
        [self displayAlreadyEnteredAlert];
    } else {
        [self createThoughtWithTitle:answer];
    }
}
- (void)insertThought:(SCSGreatThought *)thought
            WithTitle:(NSString *)title {
    NSUInteger place = [self placeForTitle:title];
    [self.thoughts insertObject:thought.fileURL
                        atIndex:place];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:place
                                                inSection:0];
    [self.tableView insertRowsAtIndexPaths:@[indexPath]
                          withRowAnimation:UITableViewRowAnimationAutomatic];
    [self.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:YES];
}
- (NSUInteger)placeForTitle:(NSString *)title {
    NSUInteger __block place =0;
    if ([self.thoughts lastObject]) {
        [self.thoughts enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
            if ([[obj lastPathComponent] compare:title
                 options:NSCaseInsensitiveSearch] == NSOrderedDescending) {
                place = idx;
                *stop = YES;
            } else {
                place = idx + 1;
            }
        }];
    }
    return place;
}

- (void)displayAlreadyEnteredAlert {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Title not allowed"
                                                    message:@"Document titles must be distinct."
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
    
}

@end
