//
//  Created by Maciej Oczko on 20/11/13.
//


#import "NSManagedObject+Utilities.h"


@implementation NSManagedObject (Utilities)

+ (NSString *)classString {
    return NSStringFromClass([self class]);
}

- (NSString *)classString {
    return NSStringFromClass([self class]);
}

@end
