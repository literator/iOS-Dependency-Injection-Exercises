//
//  Created by Maciej Oczko on 20/11/13.
//


#import <Foundation/Foundation.h>

@class PLCoreDataStackManager;
@class PLTestEntity;


@interface PLQuestionViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>
- (instancetype)initWithTest:(PLTestEntity *)test;

@end
