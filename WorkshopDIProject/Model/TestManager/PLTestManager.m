//
//  Created by Maciej Oczko on 20/11/13.
//


#import "PLTestManager.h"
#import "PLQuestionsDownloader.h"
#import "PLScoringProtocol.h"
#import "PLCoreDataStackManager.h"
#import "PLTaskRunnerProtocol.h"
#import "NSManagedObjectContext+PLCoreDataUtils.h"
#import "PLTestEntity.h"
#import "NSManagedObject+Utilities.h"
#import "PLQuestion.h"
#import "PLQuestionEntity.h"
#import "KWExample.h"


@implementation PLTestManager {

}

- (instancetype)initWithScoring:(id <PLScoringProtocol>)scoring taskRunner:(id <PLTaskRunnerProtocol>)taskRunner downloader:(PLQuestionsDownloader *)downloader coreDataStackManager:(PLCoreDataStackManager *)coreDataStackManager {
    self = [super init];
    if (self) {
        _scoring = scoring;
        _taskRunner = taskRunner;
        _downloader = downloader;
        _coreDataStackManager = coreDataStackManager;
    }

    return self;
}

- (void)updateQuestions:(void (^)())completion {

//    id <PLTaskRunnerProtocol> __weak weakTaskRunner = _taskRunner;
//    id <PLScoringProtocol> __weak weakScoring = _scoring;
//    PLCoreDataStackManager __weak *weakCoreDataStackManager = _coreDataStackManager;

    [_downloader downloadQuestions:^(NSArray *questions) {
        [_taskRunner runTask:^{

            double score = [_scoring scoreWithQuestions:questions];

            NSManagedObjectContext *context = _coreDataStackManager.backgroundContext;

            NSUInteger count = [context countForFetchRequest:[NSFetchRequest fetchRequestWithEntityName:[PLTestEntity classString]] error:nil];
            PLTestEntity *test = (PLTestEntity *) [context insertNewEntityWithName:[PLTestEntity classString]];
            test.id = @(count + 1);
            test.score = @(score);

            for (PLQuestion *question in questions) {
                PLQuestionEntity *questionEntity = (PLQuestionEntity *) [context insertNewEntityWithName:[PLQuestionEntity classString]];
                questionEntity.test = test;
                [question fill:questionEntity];
            }

            NSError *error = nil;
            if (![context save:&error] || error) {
                NSLog(@"[error localizedDescription] = %@", [error localizedDescription]);
            }

            if (completion) {
                completion();
            }

        }        withCompletion:nil];
    }];
}

@end
