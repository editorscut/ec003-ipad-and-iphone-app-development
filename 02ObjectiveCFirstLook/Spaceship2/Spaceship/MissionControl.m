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
- (Planet *)planetForSpaceship {
    return [spaceship planetToOrbit];
}
- (double)topSpeedForSpaceship {
    return [spaceship topSpeed];
}
- (void)takeSpaceShipToMaximumSpeed {
    [spaceship setTopSpeed:1];
}
- (void)sendSpaceshipOnMission {
    [spaceship orbitPlanet:mars
                atAltitude:12000];
}
@end





