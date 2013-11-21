////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////


#import "TyphoonTestUtils.h"


@implementation TyphoonTestUtils

+ (void)waitForCondition:(BOOL (^)())condition
{
    [self waitForCondition:condition andPerformTests:^
    {
        //No assertions - wait for condition only.
    }];
}

+ (void)waitForCondition:(BOOL (^)())condition andPerformTests:(void (^)())assertions
{
    [self wait:7 secondsForCondition:condition andPerformTests:assertions];
}

+ (void)wait:(NSTimeInterval)seconds secondsForCondition:(BOOL (^)())condition andPerformTests:(void (^)())assertions
{
    __block BOOL conditionMet = NO;
    for (int i = 0; i < seconds; i++)
    {
        conditionMet = condition();
        if (conditionMet)
        {
            break;
        }
        else
        {
            [[NSRunLoop currentRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:1]];
        }
    }
    if (conditionMet)
    {
        if (assertions)
        {
            assertions();
        }
    }
    else
    {
        [NSException raise:NSGenericException format:@"Condition didn't happen before timeout: %f", seconds];
    }
}


@end
