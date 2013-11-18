//
//  Created by Maciej Oczko on 19/11/13.
//


#import <Foundation/Foundation.h>


@interface PLObjectMapper : NSObject
- (void)mapDictionary:(NSDictionary *)data toObjectProperties:(NSObject *)object;
@end
