#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
@class SCSPlace;

@interface SCSPlacesOfInterest : NSObject
@property (strong, nonatomic, readonly) NSMutableArray *annotations;
- (CLLocationCoordinate2D)centerOfMap;
- (MKPolyline *)happyTrail;
- (SCSPlace *)annotationForLocation:(CLLocationCoordinate2D)coordinate
                              title:(NSString *)title;
@end
