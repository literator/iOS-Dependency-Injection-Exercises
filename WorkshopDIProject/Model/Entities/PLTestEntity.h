//
//  PLTestEntity.h
//  WorkshopDIProject
//
//  Created by Maciej Oczko on 20/11/13.
//  Copyright (c) 2013 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface PLTestEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * score;
@property (nonatomic, retain) NSSet *questions;
@end

@interface PLTestEntity (CoreDataGeneratedAccessors)

- (void)addQuestionsObject:(NSManagedObject *)value;
- (void)removeQuestionsObject:(NSManagedObject *)value;
- (void)addQuestions:(NSSet *)values;
- (void)removeQuestions:(NSSet *)values;

@end
