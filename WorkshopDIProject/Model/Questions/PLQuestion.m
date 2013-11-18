//
//  Created by Maciej Oczko on 19/11/13.
//


#import "PLQuestion.h"
#import "PLQuestionEntity.h"


@implementation PLQuestion {

}

- (instancetype)initWithId:(NSNumber *)id level:(NSNumber *)level answeredCorrectly:(NSNumber *)answeredCorrectly {
    self = [super init];
    if (self) {
        self.id = id;
        self.level = level;
        self.answeredCorrectly = answeredCorrectly;
    }

    return self;
}

- (NSString *)description {
    NSMutableString *description = [NSMutableString stringWithFormat:@"<%@: ", NSStringFromClass([self class])];
    [description appendFormat:@"id = %@, level = %@, correct = %@", self.id, self.level, self.answeredCorrectly];
    [description appendString:@">"];
    return description;
}

- (void)fill:(PLQuestionEntity *)entity {
    entity.id = self.id;
    entity.level = self.level;
    entity.answeredCorrectly = self.isAnsweredCorrectly;
}

@end
