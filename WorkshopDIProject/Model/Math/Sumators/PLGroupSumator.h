//
//  Created by Maciej Oczko on 18/11/13.
//


#import <Foundation/Foundation.h>
#import "PLSumatorProtocol.h"


@interface PLGroupSumator : NSObject <PLSumatorProtocol>
- (instancetype)initWithGroupGen:(NSNumber *)groupGen;

@end
