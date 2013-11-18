//
//  Created by Maciej Oczko on 20/11/13.
//


#import "PLTestsViewController.h"
#import "PLTestsView.h"
#import "PLCoreDataStackManager.h"
#import "NSManagedObjectContext+PLCoreDataUtils.h"
#import "PLTestEntity.h"
#import "NSManagedObject+Utilities.h"
#import "TEABarChart.h"
#import "PLQuestionViewController.h"


@implementation PLTestsViewController {
    NSFetchedResultsController *_fetchedResultsController;
}

- (instancetype)initWithCoreDataStackManager:(PLCoreDataStackManager *)coreDataStackManager {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {

        NSManagedObjectContext *context = coreDataStackManager.mainContext;
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[PLTestEntity classString]];
        fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"id" ascending:YES]];
        NSFetchedResultsController *fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                                                   managedObjectContext:context
                                                                                                     sectionNameKeyPath:nil
                                                                                                              cacheName:nil];
        [fetchedResultsController performFetch:nil];
        _fetchedResultsController = fetchedResultsController;

    }

    return self;
}

- (void)loadView {
    PLTestsView *view = [[PLTestsView alloc] initWithFrame:CGRectZero];
    view.tableView.delegate = self;
    view.tableView.dataSource = self;
    view.chart.data = [self scores];
    self.view = view;
}

- (NSArray *)scores {
    NSArray *scores = @[];
    for (PLTestEntity *test in _fetchedResultsController.fetchedObjects) {
        scores = [scores arrayByAddingObject:test.score];
    }
    return scores;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done"
                                                                              style:UIBarButtonItemStyleDone
                                                                             target:self
                                                                             action:@selector(doneTapped)];
}

- (void)doneTapped {
    [self dismissViewControllerAnimated:YES  completion:nil];
}

#pragma mark -

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    PLTestEntity *test = _fetchedResultsController.fetchedObjects[(NSUInteger) indexPath.row];
    PLQuestionViewController *questionViewController = [[PLQuestionViewController alloc] initWithTest:test];
    [self.navigationController pushViewController:questionViewController animated:YES];
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PLTestEntity *test = _fetchedResultsController.fetchedObjects[(NSUInteger) indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Test %@ with score %0.2f", test.id, [test.score doubleValue]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger) [_fetchedResultsController.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"XXX";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
    }
    return cell;
}

@end
