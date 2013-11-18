//
//  Created by Maciej Oczko on 18/11/13.
//


#import <Foundation/Foundation.h>

@protocol PLSumatorProtocol;

@interface PLBaseAverage : NSObject

- (instancetype)initWithSumator:(id <PLSumatorProtocol>)sumator;

- (double)sum:(NSArray *)numbers;
@end
