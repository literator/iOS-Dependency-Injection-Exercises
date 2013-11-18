//
//  Created by Maciej Oczko on 19/11/13.
//


#import "PLObjectMapper.h"


@implementation PLObjectMapper {

}

- (void)mapDictionary:(NSDictionary *)data toObjectProperties:(NSObject *)object {
    [data enumerateKeysAndObjectsUsingBlock:^(NSString *key, id obj, BOOL *stop) {
        [object setValue:obj forKey:key];
    }];
}

@end
