#import "Spaceship.h"

@interface Spaceship ()
@property (nonatomic) double altitude;
@property (strong, nonatomic, readwrite) Planet *planetToOrbit;
@end

@implementation Spaceship

- (void)orbitPlanet:(Planet *)aPlanet
        atAltitude:(double)km {
    self.planetToOrbit = aPlanet;
    self.altitude = km;
}
@end