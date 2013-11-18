//
//  Created by Maciej Oczko on 19/11/13.
//


#import <Foundation/Foundation.h>

@class PLAPIProxy;
@protocol PLTaskRunnerProtocol;

@interface PLQuestionsDownloader : NSObject

- (instancetype)initWithTaskRunner:(id <PLTaskRunnerProtocol>)taskRunner proxy:(PLAPIProxy *)proxy;

- (void)downloadQuestions:(void (^)(NSArray *questions))completion;
@end
