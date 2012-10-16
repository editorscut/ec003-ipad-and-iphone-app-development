#import "SCSPhotosByPhotographerViewController.h"

@interface SCSPhotosByPhotographerViewController ()

@end

@implementation SCSPhotosByPhotographerViewController


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Photo Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}

@end
