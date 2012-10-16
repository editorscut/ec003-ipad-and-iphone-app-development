#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SCSPlacesOfInterest : NSObject
@property (strong, nonatomic, readonly) NSMutableArray *annotations;
- (CLLocationCoordinate2D)centerOfMap;
- (MKPolyline *)happyTrail;
@end
