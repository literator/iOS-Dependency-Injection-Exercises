//
//  Created by Maciej Oczko on 19/11/13.
//


#import "PLQuestionsDownloader.h"
#import "PLTaskRunnerProtocol.h"
#import "PLAPIProxy.h"
#import "PLObjectMapper.h"
#import "PLQuestion.h"
#import "PLJSONSerialization.h"


@implementation PLQuestionsDownloader {
    id <PLTaskRunnerProtocol> _taskRunner;
    PLAPIProxy *_proxy;
}

- (instancetype)initWithTaskRunner:(id <PLTaskRunnerProtocol>)taskRunner proxy:(PLAPIProxy *)proxy {
    self = [super init];
    if (self) {
        _taskRunner = taskRunner;
        _proxy = proxy;
    }

    return self;
}

- (void)downloadQuestions:(void (^)(NSArray *questions))completion {
    __block NSArray *questions = @[];

    [_taskRunner runTask:^{

        NSMutableURLRequest *urlRequest = [_proxy defaultRequestWithMethod:@"POST" endpoint:@"/questions"];

        NSError *error = nil;
        NSDictionary *response = [_proxy performRequest:urlRequest error:&error];
        NSString *questionMapsString = response[UTApiAccessorResponseStringDataIdentifier];
        id json = [PLJSONSerialization JSONObjectWithData:[questionMapsString dataUsingEncoding:NSUTF8StringEncoding]];
        NSArray *questionMaps = json[@"questions"];

        if (error) {
            NSLog(@"Error = %@", [error localizedDescription]);
        }

        PLObjectMapper *mapper = [[PLObjectMapper alloc] init];
        for (NSDictionary *questionMap in questionMaps) {
            PLQuestion *question = [[PLQuestion alloc] init];
            [mapper mapDictionary:questionMap toObjectProperties:question];
            questions = [questions arrayByAddingObject:question];
        }

    }     withCompletion:^{

        if (completion) {
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(questions);
            });
        }

    }];
}

@end
