#import <Foundation/Foundation.h>

@interface PLCoreDataStackManager : NSObject {
@protected
    NSManagedObjectContext *_mainContext;
    NSManagedObjectContext *_backgroundContext;

    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property(nonatomic, readonly) NSManagedObjectContext *mainContext;
@property(nonatomic, readonly) NSManagedObjectContext *backgroundContext;

@end
