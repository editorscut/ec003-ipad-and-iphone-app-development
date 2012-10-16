#import "SCSViewController.h"
#import "SCSPlace.h"
#import "SCSPlacesOfInterest.h"
#import <MapKit/MapKit.h>

@interface SCSViewController ()<MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic)SCSPlacesOfInterest *places;
@end

@implementation SCSViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.places = [[SCSPlacesOfInterest alloc] init];
    self.mapView.region = MKCoordinateRegionMakeWithDistance([self.places centerOfMap],500, 500);
    [self.mapView addAnnotations:self.places.annotations];
}
- (MKAnnotationView *)mapView:(MKMapView *)mapView
           viewForAnnotation:(id<MKAnnotation>)annotation {
    MKPinAnnotationView *annotationView = [[MKPinAnnotationView alloc]
                                           initWithAnnotation:annotation
                                           reuseIdentifier:@"pinView"];
    annotationView.pinColor = ((SCSPlace *)annotation).pinColor;
    annotationView.animatesDrop = YES;
    annotationView.canShowCallout = YES;
    return annotationView;
}
@end
