//
//  Created by Maciej Oczko on 19/11/13.
//


#import <Foundation/Foundation.h>

@protocol PLScoringProtocol <NSObject>
- (double)scoreWithQuestions:(NSArray *)questions;
@end
