//
//  Created by Maciej Oczko on 20/11/13.
//


#import <Foundation/Foundation.h>

@class PLQuestionsDownloader;
@protocol PLScoringProtocol;
@class PLCoreDataStackManager;
@protocol PLTaskRunnerProtocol;


@interface PLTestManager : NSObject
@property(nonatomic, readonly) id <PLScoringProtocol> scoring;
@property(nonatomic, readonly) id <PLTaskRunnerProtocol> taskRunner;
@property(nonatomic, readonly) PLQuestionsDownloader *downloader;
@property(nonatomic, readonly) PLCoreDataStackManager *coreDataStackManager;

- (instancetype)initWithScoring:(id <PLScoringProtocol>)scoring taskRunner:(id <PLTaskRunnerProtocol>)taskRunner downloader:(PLQuestionsDownloader *)downloader coreDataStackManager:(PLCoreDataStackManager *)coreDataStackManager;

- (void)updateQuestions:(void (^)())completion;
@end
