//
//  Created by Maciej Oczko on 20/11/13.
//


#import <CoreData/CoreData.h>
#import "PLQuestionViewController.h"
#import "PLQuestionView.h"
#import "PLTestEntity.h"
#import "NSManagedObject+Utilities.h"
#import "PLQuestionEntity.h"
#import "PLAPIProxy.h"


@implementation PLQuestionViewController {

    NSFetchedResultsController *_fetchedResultsController;
}

- (instancetype)initWithTest:(PLTestEntity *)test {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        NSManagedObjectContext *context = test.managedObjectContext;
        NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:[PLQuestionEntity classString]];
        fetchRequest.predicate = [NSPredicate predicateWithFormat:@"test == %@", test];
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
    PLQuestionView *view = [[PLQuestionView alloc] initWithFrame:CGRectZero];
    view.tableView.delegate = self;
    view.tableView.dataSource = self;
    self.view = view;
}

#pragma mark - Table View's delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        PLAPIProxy *proxy = [[PLAPIProxy alloc] init];
        NSMutableURLRequest *request = [proxy defaultRequestWithMethod:@"POST" endpoint:@"/enlarge"];
        [proxy performRequest:request error:nil];
    });
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    PLQuestionEntity *question = _fetchedResultsController.fetchedObjects[(NSUInteger) indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"Question id %@, level %@, correct %@", question.id, question.level, question.answeredCorrectly];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return (NSInteger) [_fetchedResultsController.fetchedObjects count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"YYY";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:identifier];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

@end
