#import "Spaceship.h"

@implementation Spaceship {
    Planet *_planetToOrbit;
    double _topSpeed;
    double _altitude;
}
- (Planet *)planetToOrbit {
    return _planetToOrbit;
}
- (double)topSpeed {
    return _topSpeed;
}
- (void)setTopSpeed:(double)percentSpeedOfLight {
    _topSpeed = percentSpeedOfLight;
}
- (void)orbitPlanet:(Planet *)aPlanet
        atAltitude:(double)km {
    _planetToOrbit = aPlanet;
    _altitude = km;
}
@end