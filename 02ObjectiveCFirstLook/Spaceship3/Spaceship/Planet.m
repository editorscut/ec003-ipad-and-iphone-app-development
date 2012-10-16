#import "Planet.h"

@interface Planet ()
@property (strong,nonatomic)NSString *name;
@end

@implementation Planet

- (id)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
    }
    return self;
}
@end
