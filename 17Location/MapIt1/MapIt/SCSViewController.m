#import "SCSViewController.h"
#import <MapKit/MapKit.h>

@interface SCSViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@end

@implementation SCSViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.mapView.showsUserLocation = YES;
    self.mapView.mapType = MKMapTypeHybrid;
}

- (void)mapView:(MKMapView *)mapView
   didUpdateUserLocation:(MKUserLocation *)userLocation {
    self.mapView.region = MKCoordinateRegionMakeWithDistance(self.mapView.userLocation.coordinate, 500, 500);
}

@end
