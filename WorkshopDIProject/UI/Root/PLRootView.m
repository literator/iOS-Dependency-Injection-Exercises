//
//  Created by Maciej Oczko on 20/11/13.
//


#import "PLRootView.h"
#import "NSLayoutConstraint+PLVisualAttributeConstraints.h"
#import "PLRootViewDelegate.h"


@implementation PLRootView {

    UIButton *_button;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        [button setTitle:@"Get questions" forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonTapped) forControlEvents:UIControlEventTouchUpInside];
        button.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:button];
        _button = button;

        [self setupConstraints];
    }

    return self;
}

- (void)setupConstraints {
    [self addConstraints:[NSLayoutConstraint attributeConstraintsWithVisualFormatsArray:@[
            @"button.centerX == self.centerX",
            @"button.centerY == self.centerY",
    ]
                                                                                  views:@{
                                                                                          @"self" : self,
                                                                                          @"button" : _button,
                                                                                  }]];
}

- (void)buttonTapped {
    [self.delegate viewDidRequestQuestion:self];
}

@end
