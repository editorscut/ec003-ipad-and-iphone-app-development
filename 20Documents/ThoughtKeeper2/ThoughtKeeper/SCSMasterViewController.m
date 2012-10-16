#import "SCSMasterViewController.h"
#import "SCSAskerViewController.h"
#import "SCSDetailViewController.h"
#import "SCSGreatThought.h"

@interface SCSMasterViewController ()<SCSAskerViewControllerDelegate>
@property (strong, nonatomic) NSMutableArray *thoughts;
@property (strong, nonatomic) NSURL *documentsURL;
@end

@implementation SCSMasterViewController
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
        [self.thoughts removeObjectAtIndex:indexPath.row];
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtURL:self.thoughts[indexPath.row]
                                                  error:&error];
        [tableView deleteRowsAtIndexPaths:@[indexPath]
                         withRowAnimation:UITableViewRowAnimationFade];
    }
}
- (SCSGreatThought *)createThoughtWithTitle:(NSString *)title {
    SCSGreatThought *thought = [[SCSGreatThought alloc] initWithFileURL:[self urlForTitle:title]];
    [thought saveToURL:[self urlForTitle:title]
      forSaveOperation:UIDocumentSaveForCreating
     completionHandler:nil];
    return thought;
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
        [self insertThoughtWithTitle:answer];
    }
}
- (void)insertThoughtWithTitle:(NSString *)title {
    SCSGreatThought *thought = [self createThoughtWithTitle:title];
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
