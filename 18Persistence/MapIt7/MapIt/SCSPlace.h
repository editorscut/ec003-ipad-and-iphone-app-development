#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@interface SCSPlace : NSObject <MKAnnotation, NSCoding>
@property (nonatomic, readonly) MKPinAnnotationColor pinColor;
- (id)initWithLocation:(CLLocationCoordinate2D)coordinate
                 title:(NSString *)title
              subtitle:(NSString *)subtitle
              pinColor:(MKPinAnnotationColor)pinColor;
@end