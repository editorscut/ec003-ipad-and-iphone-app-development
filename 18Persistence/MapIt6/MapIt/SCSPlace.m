#import "SCSPlace.h"

@interface SCSPlace ()
@property (nonatomic, readwrite)MKPinAnnotationColor pinColor;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;
@end

@implementation SCSPlace
@synthesize title = _title;
@synthesize subtitle = _subtitle;
- (id) initWithLocation:(CLLocationCoordinate2D)coordinate
                  title:(NSString *)title
               subtitle:(NSString *)subtitle
               pinColor:(MKPinAnnotationColor)pinColor {
    self = [super init];
    if (self) {
        _coordinate = coordinate;
        _title = title;
        _subtitle = subtitle;
        _pinColor = pinColor;
    }
    return self;
}
- (id)init{
    return [self initWithLocation:CLLocationCoordinate2DMake(0,0)
                            title:nil subtitle:nil pinColor:0];
}
@end
