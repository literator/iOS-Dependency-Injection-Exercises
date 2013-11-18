//
//  Created by Maciej Oczko on 10/17/13.
//


#import "PLJSONSerialization.h"


@implementation PLJSONSerialization {

}

+ (id)JSONObjectWithData:(NSData *)data {
    if (!data) {
        NSLog(@"UTJSONSerialization error: data cannot be nil");
        return nil;
    }

    NSError *error = nil;
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"UTJSONSerialization error = %@", [error localizedDescription]);
    }
    return object;
}

@end
