#import "SCSGreatThought.h"

@implementation SCSGreatThought
-(id)contentsForType:(NSString *)typeName
               error:(NSError *__autoreleasing *)outError {
    if (! self.thought) {
        self.thought = @"";
    }
    return [self.thought dataUsingEncoding:NSUTF8StringEncoding];
}
-(BOOL)loadFromContents:(id)contents
                 ofType:(NSString *)typeName
                  error:(NSError *__autoreleasing *)outError {
    if ([contents length] > 0) {
        self.thought = [[NSString alloc] initWithData:contents
                                             encoding:NSUTF8StringEncoding];
    } else {
        self.thought = @"";
    }
    return YES;
}
@end
