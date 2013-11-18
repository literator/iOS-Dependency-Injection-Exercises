//
//  Created by Maciej Oczko on 19/11/13.
//


#import "PLBasicScoring.h"
#import "PLSumatorProtocol.h"
#import "PLAverageCalculatorProtocol.h"
#import "PLQuestion.h"


@implementation PLBasicScoring {
    id <PLSumatorProtocol> _sumator;
    id <PLAverageCalculatorProtocol> _averageCalculator;
}

- (instancetype)initWithSumator:(id <PLSumatorProtocol>)sumator averageCalculator:(id <PLAverageCalculatorProtocol>)averageCalculator {
    self = [super init];
    if (self) {
        _sumator = sumator;
        _averageCalculator = averageCalculator;
    }

    return self;
}

#pragma mark - Scoring Protocol

- (double)scoreWithQuestions:(NSArray *)questions {
    NSArray *levels = @[];
    double levelsSum = 0;
    for (PLQuestion *question in questions) {
        levelsSum = [_sumator sum:levelsSum with:[question.level doubleValue]];

        NSNumber *level = @([question.level doubleValue] * ([question.isAnsweredCorrectly boolValue] ? 1 : -1));
        levels = [levels arrayByAddingObject:level];
    }
    double average = [_averageCalculator averageOf:levels];
    return levelsSum / average;
}

@end
