//
//  Created by Maciej Oczko on 18/11/13.
//


#import "PLRootViewController.h"
#import "PLRootView.h"
#import "PLCoreDataStackManager.h"
#import "PLTestsViewController.h"
#import "PLTestManager.h"
#import "PLScoringProtocol.h"
#import "PLBasicScoring.h"
#import "PLSumatorProtocol.h"
#import "PLSimpleSumator.h"
#import "PLAverageCalculatorProtocol.h"
#import "PLArithmeticAverage.h"
#import "PLTaskRunnerProtocol.h"
#import "PLTaskRunner.h"
#import "PLQuestionsDownloader.h"
#import "PLAPIProxy.h"
#import "PLTestEntity.h"
#import "PLHarmonicAverage.h"


@implementation PLRootViewController {

}

- (void)loadView {
    PLRootView *view = [[PLRootView alloc] initWithFrame:CGRectZero];
    view.delegate = self;
    self.view = view;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [[[PLAPIProxy alloc] init] doNotUseThisHelperMethod];
}

#pragma mark - View's delegate

- (void)viewDidRequestQuestion:(PLRootView *)view {
    PLCoreDataStackManager *coreDataStackManager = [[PLCoreDataStackManager alloc] init];
    id <PLSumatorProtocol> sumator = [[PLSimpleSumator alloc] init];
    id <PLAverageCalculatorProtocol> average = [[PLHarmonicAverage alloc] initWithSumator:sumator];
    id <PLScoringProtocol> scoring = [[PLBasicScoring alloc] initWithSumator:sumator averageCalculator:average];
    id <PLTaskRunnerProtocol> taskRunner = [[PLTaskRunner alloc] init];

    PLAPIProxy *proxy = [[PLAPIProxy alloc] init];
    PLQuestionsDownloader *questionsDownloader = [[PLQuestionsDownloader alloc] initWithTaskRunner:taskRunner
                                                                                             proxy:proxy];

    PLTestManager *testManager = [[PLTestManager alloc] initWithScoring:scoring
                                                             taskRunner:taskRunner
                                                             downloader:questionsDownloader
                                                   coreDataStackManager:coreDataStackManager];

    PLRootViewController *weakSelf = self;
    [testManager updateQuestions:^{
        PLTestsViewController *testsViewController = [[PLTestsViewController alloc] initWithCoreDataStackManager:coreDataStackManager];
        UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:testsViewController];
        [weakSelf presentViewController:navigationController animated:YES completion:nil];
    }];
}

@end
