//
//  Created by Maciej Oczko on 20/11/13.
//


#import <Foundation/Foundation.h>

@class PLCoreDataStackManager;


@interface PLTestsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

- (instancetype)initWithCoreDataStackManager:(PLCoreDataStackManager *)coreDataStackManager;

@end
