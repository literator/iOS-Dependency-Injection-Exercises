//
//  Created by Maciej Oczko on 19/11/13.
//


#import <Foundation/Foundation.h>

@protocol PLTaskRunnerProtocol <NSObject>
- (void)runTask:(void(^)())task withCompletion:(void (^)())completion;
@end
