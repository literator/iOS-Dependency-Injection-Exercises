//
//  Created by Maciej Oczko on 19/11/13.
//


#import <Foundation/Foundation.h>
#import "PLBasicScoring.h"

@protocol PLScoreModifierProtocol;


@interface PLSpecialScoring : PLBasicScoring
@property(nonatomic, strong) id <PLScoreModifierProtocol> modifier;
@end
