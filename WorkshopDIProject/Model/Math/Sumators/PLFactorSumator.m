//
//  Created by Maciej Oczko on 18/11/13.
//


#import "PLFactorSumator.h"

@implementation PLFactorSumator {

}

- (double)sum:(double)x with:(double)y {
    if (y == 0) @throw [NSException exceptionWithName:@"ButWhyZeroException" reason:@"Zero? Come on!" userInfo:nil];
    return x + (1.0f / y);
}

@end
