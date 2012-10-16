#import "Vehicle.h"
#import "Planet.h"

@interface Spaceship : Vehicle
@property (strong, nonatomic, readonly)Planet *planetToOrbit;
@property (nonatomic)double topSpeed;
- (void)orbitPlanet:(Planet *)aPlanet
         atAltitude:(double)km;
@end