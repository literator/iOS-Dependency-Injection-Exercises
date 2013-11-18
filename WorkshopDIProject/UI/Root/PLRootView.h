//
//  Created by Maciej Oczko on 20/11/13.
//


#import <Foundation/Foundation.h>

@protocol PLRootViewDelegate;


@interface PLRootView : UIView
@property(nonatomic, weak) id <PLRootViewDelegate> delegate;
@end
