#import "MissionControl.h"
#import "Planet.h"
#import "Spaceship.h"

@implementation MissionControl {
    Planet *mars;
    Spaceship *spaceship;
}
- (void) createSpaceship {
    spaceship = [[Spaceship alloc] init];
}
- (void)sendSpaceshipOnMission {
    [spaceship orbitPlanet:mars
                atAltitude:12000];
}
- (void)planetForSpaceship {
    Planet *planet = [spaceship planetToOrbit];
    // ...
}
- (void) topSpeedForSpaceship {
    double topSpeed = [spaceship topSpeed];
    // ...
}
- (void) takeSpaceShipToMaximumSpeed {
    [spaceship setTopSpeed:1];
}
@end





