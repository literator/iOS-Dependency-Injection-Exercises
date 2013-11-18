//
//  Created by Maciej Oczko on 19/11/13.
//


#import "PLTaskRunner.h"


@implementation PLTaskRunner {

}

- (void)runTask:(void (^)())task withCompletion:(void (^)())completion {
    if (task) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            if (task) {
                task();
            }
            if (completion) {
                completion();
            }
        });
    }
}

@end
