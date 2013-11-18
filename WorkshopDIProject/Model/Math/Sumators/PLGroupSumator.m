//
//  Created by Maciej Oczko on 18/11/13.
//


#import "PLGroupSumator.h"


@implementation PLGroupSumator {
    NSNumber *_groupGen;
}

- (instancetype)initWithGroupGen:(NSNumber *)groupGen {
    self = [super init];
    if (self) {
        _groupGen = groupGen;
    }

    return self;
}

- (double)sum:(double)x with:(double)y {
    return (int)(x + y) % [_groupGen intValue];
}

@end
