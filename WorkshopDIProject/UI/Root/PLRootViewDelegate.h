//
//  Created by Maciej Oczko on 20/11/13.
//


#import <Foundation/Foundation.h>

@class PLRootView;

@protocol PLRootViewDelegate <NSObject>
- (void)viewDidRequestQuestion:(PLRootView *)view;
@end
