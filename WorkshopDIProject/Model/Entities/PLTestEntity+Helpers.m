//
//  Created by Maciej Oczko on 20/11/13.
//


#import "PLTestEntity+Helpers.h"


@implementation PLTestEntity (Helpers)

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"id = %@, score = %@", self.id, self.score];
    [description appendString:@">"];
    return description;
}

@end
