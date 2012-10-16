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
- (void)encodeWithCoder:(NSCoder *)aCoder {
    [aCoder encodeCGPoint:CGPointMake(self.coordinate.latitude,
                                      self.coordinate.longitude)
                   forKey:@"coordinate"];
    [aCoder encodeObject:self.title forKey:@"title"];
    [aCoder encodeObject:self.subtitle forKey:@"subtitle"];
    [aCoder encodeInteger:self.pinColor forKey:@"pincolor"];
}
- (id)initWithCoder:(NSCoder *)aDecoder {
    self = [super init];
    if (self) {
        CGPoint storedPoint = [aDecoder decodeCGPointForKey:@"coordinate"];
        _coordinate = CLLocationCoordinate2DMake(storedPoint.x,
                                                 storedPoint.y);
        _title = [aDecoder decodeObjectForKey:@"title"];
        _subtitle = [aDecoder decodeObjectForKey:@"subtitle"];
        _pinColor = [aDecoder decodeIntegerForKey:@"pincolor"];
    }
    return self;
}
@end
