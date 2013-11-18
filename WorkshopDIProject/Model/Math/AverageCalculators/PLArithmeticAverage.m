//
//  Created by Maciej Oczko on 18/11/13.
//


#import "PLArithmeticAverage.h"

@implementation PLArithmeticAverage

- (double)averageOf:(NSArray *)numbers {
    return [self sum:numbers] / [numbers count];
}

@end
