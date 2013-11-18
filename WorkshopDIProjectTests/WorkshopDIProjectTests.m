//
//  WorkshopDIProjectTests.m
//  WorkshopDIProjectTests
//
//  Created by Maciej Oczko on 18/11/13.
//  Copyright (c) 2013 Polidea. All rights reserved.
//

#import <Kiwi/Kiwi.h>
#import "PLSumatorProtocol.h"
#import "PLSimpleSumator.h"
#import "PLGroupSumator.h"
#import "PLAverageCalculatorProtocol.h"
#import "PLArithmeticAverage.h"
#import "PLHarmonicAverage.h"
#import "PLFactorSumator.h"
#import "PLScoringProtocol.h"
#import "PLBasicScoring.h"
#import "PLQuestion.h"
#import "PLScoreModifierProtocol.h"
#import "PLScoreModifier.h"
#import "PLSpecialScoring.h"

SPEC_BEGIN(Spec)

describe(@"Sample Tests", ^{
    describe(@"Sumator", ^{
        it(@"should pass with simple sumator", ^{
            id <PLSumatorProtocol> sumator = [[PLSimpleSumator alloc] init];

            [[theValue([sumator sum:2 with:3]) should] equal:theValue(5)];
        });

        it(@"should pass with group sumator", ^{
            id <PLSumatorProtocol> sumator = [[PLGroupSumator alloc] initWithGroupGen:@4];

            [[theValue([sumator sum:2 with:3]) should] equal:theValue(1)];
        });
    });

    describe(@"Average", ^{
        it(@"should pass with arithmetic average", ^{
            id <PLSumatorProtocol> sumator = [[PLSimpleSumator alloc] init];
            id <PLAverageCalculatorProtocol> averageCalculus = [[PLArithmeticAverage alloc] initWithSumator:sumator];

            double average = [averageCalculus averageOf:@[@1, @2, @3, @4]];

            [[theValue(average) should] equal:@(2.5)];
        });

        it(@"should pass with arithmetic average", ^{
            id <PLSumatorProtocol> sumator = [[PLFactorSumator alloc] init];
            id <PLAverageCalculatorProtocol> averageCalculus = [[PLHarmonicAverage alloc] initWithSumator:sumator];

            double average = [averageCalculus averageOf:@[@1, @2, @3, @4]];

            [[theValue(average) should] equal:1.92 withDelta:0.0001];
        });
    });

    describe(@"Scoring", ^{
        __block NSArray *questions;

        beforeEach(^{
            questions = @[];
            for (NSUInteger j = 0; j < 10; j++) {
                PLQuestion *question = [[PLQuestion alloc] initWithId:@(j + 1) level:@(j % 4) answeredCorrectly:@(j % 2 == 1)];
                questions = [questions arrayByAddingObject:question];
            }
        });

        it(@"should pass with simple scoring", ^{
            id <PLSumatorProtocol> sumator = [[PLSimpleSumator alloc] init];
            id <PLAverageCalculatorProtocol> averageCalculus = [[PLArithmeticAverage alloc] initWithSumator:sumator];

            id <PLScoringProtocol> scoring = [[PLBasicScoring alloc] initWithSumator:sumator
                                                                   averageCalculator:averageCalculus];

            double score = [scoring scoreWithQuestions:questions];

            [[theValue(score) should] equal:26 withDelta:0.0001];
        });

        it(@"should pass with special scoring", ^{
            id <PLSumatorProtocol> sumator = [[PLSimpleSumator alloc] init];
            id <PLAverageCalculatorProtocol> averageCalculus = [[PLArithmeticAverage alloc] initWithSumator:sumator];

            id <PLSumatorProtocol> modifierSumator = [[PLFactorSumator alloc] init];
            PLScoreModifier* scoreModifier = [[PLScoreModifier alloc] init];
            scoreModifier.sumator = modifierSumator;

            PLSpecialScoring *scoring = [[PLSpecialScoring alloc] initWithSumator:sumator
                                                                   averageCalculator:averageCalculus];

            scoring.modifier = scoreModifier;

            double score = [scoring scoreWithQuestions:questions];

            [[theValue(score) should] equal:104 withDelta:0.0001];
        });
    });
});

SPEC_END
