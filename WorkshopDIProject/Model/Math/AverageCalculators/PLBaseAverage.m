//
//  Created by Maciej Oczko on 18/11/13.
//


#import "PLBaseAverage.h"
#import "PLSumatorProtocol.h"


@implementation PLBaseAverage {
    id <PLSumatorProtocol> _sumator;
}

- (instancetype)initWithSumator:(id <PLSumatorProtocol>)sumator {
    self = [super init];
    if (self) {
        _sumator = sumator;
    }

    return self;
}

- (double)sum:(NSArray *)numbers {
    double sum = 0;
    for (NSNumber *number in numbers) {
        sum = [_sumator sum:sum with:[number floatValue]];
    }
    return sum;
}

@end
