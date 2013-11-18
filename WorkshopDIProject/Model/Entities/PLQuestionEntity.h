//
//  PLQuestionEntity.h
//  WorkshopDIProject
//
//  Created by Maciej Oczko on 20/11/13.
//  Copyright (c) 2013 Polidea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class PLTestEntity;

@interface PLQuestionEntity : NSManagedObject

@property (nonatomic, retain) NSNumber * id;
@property (nonatomic, retain) NSNumber * level;
@property (nonatomic, retain) NSNumber * answeredCorrectly;
@property (nonatomic, retain) PLTestEntity *test;

@end
