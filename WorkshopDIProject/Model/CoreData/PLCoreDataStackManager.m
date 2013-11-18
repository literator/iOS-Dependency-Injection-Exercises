#import <CoreData/CoreData.h>
#import "PLCoreDataStackManager.h"
#import "PLManagedObjectContext.h"


@implementation PLCoreDataStackManager

- (id)init {
    self = [super init];
    if (self) {
        [self createManagerObjectModel];
        [self createPersistentStore];
        [self createMainContext];
        [self createBackgroundContext];
    }

    return self;
}

#pragma mark -
#pragma mark Contexts

- (void)createBackgroundContext {
    _backgroundContext = [[PLManagedObjectContext alloc] initWithConcurrencyType:NSPrivateQueueConcurrencyType];
    if (_persistentStoreCoordinator && _backgroundContext) {
        _backgroundContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
        _backgroundContext.parentContext = self.mainContext;
    }
}

- (void)createMainContext {
    _mainContext = [[PLManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];

    if (_persistentStoreCoordinator && _mainContext) {
        _mainContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy;
        _mainContext.persistentStoreCoordinator = _persistentStoreCoordinator;
    }
}

#pragma mark - Model & Persistent store

- (void)createManagerObjectModel {
    _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
}

- (void)createPersistentStore {
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"SuperWorkshopModel .sqlite"];

    NSError *error = nil;
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    NSDictionary *sourceMetadata = [NSPersistentStoreCoordinator metadataForPersistentStoreOfType:NSSQLiteStoreType
                                                                                              URL:storeURL
                                                                                            error:&error];
    if (sourceMetadata == nil) {
        NSLog(@"Core data source metadata is nil");
    }

    BOOL pscCompatibile;
    if (sourceMetadata == nil) { // No model so it is compatible
        pscCompatibile = YES;
    } else {
        pscCompatibile = [_managedObjectModel isConfiguration:nil
                                  compatibleWithStoreMetadata:sourceMetadata];
    }

    if (!pscCompatibile) {
        NSLog(@"Persistent store is incompatible");
        [self removePersistentStoreAndCreateNewAtStoreUrl:storeURL];

    } else {
        NSLog(@"Persistent store is compatible");
        if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
                                                                 URL:storeURL options:nil error:&error]) {

            [self removePersistentStoreAndCreateNewAtStoreUrl:storeURL];
        }
    }
}

- (void)removePersistentStoreAndCreateNewAtStoreUrl:(NSURL *)storeUrl {
    NSError *error;
    [[NSFileManager defaultManager] removeItemAtURL:storeUrl error:nil];

    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil
                                                             URL:storeUrl options:nil
                                                           error:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Applications Documents directory

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory
                                                   inDomains:NSUserDomainMask] lastObject];
}

@end
