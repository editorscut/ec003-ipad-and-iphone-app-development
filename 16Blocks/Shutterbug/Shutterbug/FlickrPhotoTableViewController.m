//
//  FlickrPhotoTableViewController.m
//  Shutterbug
//
//  Created by CS193p Instructor.
//  Copyright (c) 2011 Stanford University. All rights reserved.
//

#import "FlickrPhotoTableViewController.h"
#import "FlickrFetcher.h"

@implementation FlickrPhotoTableViewController

@synthesize photos = _photos;

//- (IBAction)refresh:(id)sender {
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [spinner startAnimating];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
//    NSArray *photos = [FlickrFetcher recentGeoreferencedPhotos];
//    self.navigationItem.rightBarButtonItem = sender;
//    self.photos = photos;
//}

//- (IBAction)refresh:(id)sender {
//    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
//    [spinner startAnimating];
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
//    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL);
//    dispatch_async(downloadQueue, ^{
//        NSArray *photos = [FlickrFetcher recentGeoreferencedPhotos];
//        self.navigationItem.rightBarButtonItem = sender;
//        self.photos = photos;
//    });
//}

- (IBAction)refresh:(id)sender {
    UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [spinner startAnimating];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
    dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL);
    dispatch_async(downloadQueue, ^{
        NSArray *photos = [FlickrFetcher recentGeoreferencedPhotos];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.navigationItem.rightBarButtonItem = sender;
            self.photos = photos;
        });
    });
    dispatch_release(downloadQueue);
}

/*- (IBAction)refresh:(id)sender
 {
 // might want to use introspection to be sure sender is UIBarButtonItem
 // (if not, it can skip the spinner)
 // that way this method can be a little more generic
 UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
 [spinner startAnimating];
 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:spinner];
 
 dispatch_queue_t downloadQueue = dispatch_queue_create("flickr downloader", NULL);
 dispatch_async(downloadQueue, ^{
 NSArray *photos = [FlickrFetcher recentGeoreferencedPhotos];
 dispatch_async(dispatch_get_main_queue(), ^{
 self.navigationItem.rightBarButtonItem = sender;
 self.photos = photos;
 });
 });
 dispatch_release(downloadQueue);
 }
*/

- (void)nothing {
    NSURLRequest *request;
    
[NSURLConnection
    sendAsynchronousRequest:request
                      queue:[NSOperationQueue mainQueue]
          completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               //code to execute on the main queue when request completes
}];

}

- (void)setPhotos:(NSArray *)photos
{
    if (_photos != photos) {
        _photos = photos;
        // Model changed, so update our View (the table)
        if (self.tableView.window) [self.tableView reloadData];
    }
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.photos count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Flickr Photo";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    NSDictionary *photo = [self.photos objectAtIndex:indexPath.row];
    cell.textLabel.text = [photo objectForKey:FLICKR_PHOTO_TITLE];
    cell.detailTextLabel.text = [photo objectForKey:FLICKR_PHOTO_OWNER];
    
    return cell;
}

@end
