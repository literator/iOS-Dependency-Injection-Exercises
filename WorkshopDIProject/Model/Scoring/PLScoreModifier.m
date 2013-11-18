//
//  Created by Maciej Oczko on 19/11/13.
//


#import "PLScoreModifier.h"

@implementation PLScoreModifier {

    double _multiplier;
}

- (void)setup {
    _multiplier = 2;
    if (self.sumator) {
        _multiplier = [self.sumator sum:2 with:0.5];
    }
}

- (double)modifyScore:(double)score {
    [self setup];
    return score * _multiplier;
}

@end
