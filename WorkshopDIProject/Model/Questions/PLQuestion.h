//
//  Created by Maciej Oczko on 19/11/13.
//


#import <Foundation/Foundation.h>

@class PLQuestionEntity;


@interface PLQuestion : NSObject
@property(nonatomic, strong) NSNumber *id;
@property(nonatomic, strong) NSNumber *level;
@property(nonatomic, getter=isAnsweredCorrectly) NSNumber *answeredCorrectly;

- (instancetype)initWithId:(NSNumber *)id level:(NSNumber *)level answeredCorrectly:(NSNumber *)answeredCorrectly;

- (void)fill:(PLQuestionEntity *)entity;
@end
