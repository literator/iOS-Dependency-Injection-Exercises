//
//  Created by Maciej Oczko on 7/30/13.
//


#import <CoreData/CoreData.h>
#import "PLManagedObjectContext.h"

@implementation PLManagedObjectContext {

}

- (BOOL)save:(NSError **)error {
    __block BOOL saved = [super save:error];
    if (saved && self.parentContext) {
        [self.parentContext performBlockAndWait:^{
            saved = [self.parentContext save:error];
        }];
    }
    return saved;
}

@end
