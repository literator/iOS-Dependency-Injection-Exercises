//
//  Created by Maciej Oczko on 20/11/13.
//


#import "PLTestsView.h"
#import "TEABarChart.h"


@implementation PLTestsView {

    TEABarChart *_chart;
    UITableView *_tableView;
}

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {

        TEABarChart *chart = [[TEABarChart alloc] initWithFrame:CGRectZero];
        chart.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:chart];
        _chart = chart;

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
            @"chart" : _chart,
            @"table" : _tableView,
    };

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[chart]-|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[table]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:views]];

    [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(64)-[chart(200)]-[table]|"
                                                                 options:NSLayoutFormatDirectionLeadingToTrailing
                                                                 metrics:nil
                                                                   views:views]];
}

@end
