//
//  Created by Maciej Oczko on 10/17/13.
//


#import <Foundation/Foundation.h>


@interface PLJSONSerialization : NSObject

/*
    Returns NSArray or NSDictionary from JSON data.
 */
+ (id)JSONObjectWithData:(NSData *)data;

@end
