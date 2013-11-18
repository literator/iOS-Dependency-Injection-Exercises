//
//  Created by Maciej Oczko on 19/11/13.
//


#import <Foundation/Foundation.h>
#import "PLScoreModifierProtocol.h"
#import "PLSumatorProtocol.h"

@interface PLScoreModifier : NSObject <PLScoreModifierProtocol>
@property(nonatomic, strong) id <PLSumatorProtocol> sumator;
@end
