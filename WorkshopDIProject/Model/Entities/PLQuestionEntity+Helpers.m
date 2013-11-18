//
//  Created by Maciej Oczko on 20/11/13.
//


#import "PLQuestionEntity+Helpers.h"


@implementation PLQuestionEntity (Helpers)

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"id = %@, level = %@, answeredCorrectly = %@", self.id, self.level, self.answeredCorrectly];
    [description appendString:@">"];
    return description;
}

@end
