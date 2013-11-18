//
//  Created by Maciej Oczko on 18/11/13.
//


#import "PLHarmonicAverage.h"

@implementation PLHarmonicAverage

- (double)averageOf:(NSArray *)numbers {
    return [numbers count] / [self sum:numbers];
}

@end
