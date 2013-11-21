////////////////////////////////////////////////////////////////////////////////
//
//  TYPHOON FRAMEWORK
//  Copyright 2013, Jasper Blues & Contributors
//  All Rights Reserved.
//
//  NOTICE: The authors permit you to use, modify, and distribute this file
//  in accordance with the terms of the license agreement accompanying it.
//
////////////////////////////////////////////////////////////////////////////////

#import "TyphoonDefinition.h"

@class TyphoonPropertyPlaceholderConfigurer;
@protocol TyphoonResource;

/**
 Declares short-hand definition factory methods for infrastructure components.
 */
@interface TyphoonDefinition (Infrastructure)


/**
* Returns a definition with the given class and key. In the block-style assembly, keys are auto-generated, however infrastructure components
* may specify their own key.
*/
+ (TyphoonDefinition*)withClass:(Class)clazz key:(NSString*)key;


/**
 Factory method for a TyphoonPropertyPlaceholderConfigurer.
 @param resource The resource to load.
 @return a definition.
 */
+ (TyphoonDefinition*)propertyPlaceholderWithResource:(id <TyphoonResource>)resource;


- (id)initWithClass:(Class)clazz key:(NSString*)key;

- (id)initWithClass:(Class)clazz key:(NSString*)key factoryComponent:(NSString*)factoryComponent;


@end
