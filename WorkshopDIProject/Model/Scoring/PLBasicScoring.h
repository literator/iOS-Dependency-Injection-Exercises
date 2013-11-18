//
//  Created by Maciej Oczko on 19/11/13.
//


#import <Foundation/Foundation.h>
#import "PLScoringProtocol.h"

@protocol PLSumatorProtocol;
@protocol PLAverageCalculatorProtocol;


@interface PLBasicScoring : NSObject <PLScoringProtocol>

- (instancetype)initWithSumator:(id <PLSumatorProtocol>)sumator averageCalculator:(id <PLAverageCalculatorProtocol>)averageCalculator;

@end
