//
//  Created by Maciej Oczko on 20/11/13.
//


#import "PLQuestionView.h"


@implementation PLQuestionView {

    UITableView *_tableView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        tableView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:tableView];
        _tableView = tableView;

        [self setupConstraints];
    }

    return self;
}

- (void)setupConstraints {
    NSDictionary *views = @{
            @"table" : _tableView,
    };

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[table]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[table]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:views]];
}

@end
