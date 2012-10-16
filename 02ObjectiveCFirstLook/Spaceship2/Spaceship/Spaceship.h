#import "Vehicle.h"
#import "Planet.h"

@interface Spaceship : Vehicle
- (Planet *)planetToOrbit;
- (double)topSpeed;
- (void)setTopSpeed:(double)percentSpeedOfLight;
- (void)orbitPlanet:(Planet *)aPlanet
         atAltitude:(double)km;
@end