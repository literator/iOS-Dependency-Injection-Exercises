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


#import "TyphoonInitializer.h"
#import "TyphoonDefinition.h"
#import "TyphoonPropertyInjectedByType.h"
#import "TyphoonPropertyInjectedWithStringRepresentation.h"
#import "TyphoonInitializer+InstanceBuilder.h"
#import "TyphoonDefinition+InstanceBuilder.h"
#import "TyphoonPropertyInjectedAsCollection.h"
#import "TyphoonPropertyInjectedAsObjectInstance.h"
#import "TyphoonDefinition+Infrastructure.h"


@implementation TyphoonDefinition

/* ====================================================================================================================================== */
#pragma mark - Class Methods

+ (TyphoonDefinition*)withClass:(Class)clazz
{
    return [[TyphoonDefinition alloc] initWithClass:clazz key:nil];
}


+ (TyphoonDefinition*)withClass:(Class)clazz initialization:(TyphoonInitializerBlock)initialization
{
    return [TyphoonDefinition withClass:clazz key:nil initialization:initialization properties:nil];
}

+ (TyphoonDefinition*)withClass:(Class)clazz properties:(TyphoonDefinitionBlock)properties
{
    return [TyphoonDefinition withClass:clazz key:nil initialization:nil properties:properties];
}

+ (TyphoonDefinition*)withClass:(Class)clazz initialization:(TyphoonInitializerBlock)initialization
        properties:(TyphoonDefinitionBlock)properties
{
    return [TyphoonDefinition withClass:clazz key:nil initialization:initialization properties:properties];
}

+ (TyphoonDefinition*)withClass:(Class)clazz key:(NSString*)key initialization:(TyphoonInitializerBlock)initialization
        properties:(TyphoonDefinitionBlock)properties
{

    TyphoonDefinition* definition = [[TyphoonDefinition alloc] initWithClass:clazz key:key];
    if (initialization)
    {
        TyphoonInitializer* componentInitializer = [[TyphoonInitializer alloc] init];
        definition.initializer = componentInitializer;
        __unsafe_unretained TyphoonInitializer* weakInitializer = componentInitializer;
        initialization(weakInitializer);
    }
    if (properties)
    {
        __unsafe_unretained TyphoonDefinition* weakDefinition = definition;
        properties(weakDefinition);
    }
    return definition;
}

+ (TyphoonDefinition*)withClass:(Class)clazz key:(NSString*)key initialization:(TyphoonInitializerBlock)initialization
{
    return [TyphoonDefinition withClass:clazz key:key initialization:initialization properties:nil];
}

+ (TyphoonDefinition*)withClass:(Class)clazz key:(NSString*)key properties:(TyphoonDefinitionBlock)properties
{
    return [TyphoonDefinition withClass:clazz key:key initialization:nil properties:properties];
}


/* ====================================================================================================================================== */
#pragma mark - Interface Methods

- (void)injectProperty:(SEL)selector
{
    [_injectedProperties addObject:[[TyphoonPropertyInjectedByType alloc] initWithName:NSStringFromSelector(selector)]];
}

- (void)injectProperty:(SEL)selector withValueAsText:(NSString*)textValue
{
    [_injectedProperties addObject:[[TyphoonPropertyInjectedWithStringRepresentation alloc]
            initWithName:NSStringFromSelector(selector) value:textValue]];
}

- (void)injectProperty:(SEL)selector withDefinition:(TyphoonDefinition*)definition
{
    [self injectProperty:selector withReference:definition.key];
}

- (void)injectProperty:(SEL)selector withObjectInstance:(id)instance
{
    [_injectedProperties addObject:[[TyphoonPropertyInjectedAsObjectInstance alloc]
            initWithName:NSStringFromSelector(selector) objectInstance:instance]];
}

- (void)injectProperty:(SEL)withSelector asCollection:(void (^)(TyphoonPropertyInjectedAsCollection*))collectionValues;
{
    TyphoonPropertyInjectedAsCollection
            * propertyInjectedAsCollection = [[TyphoonPropertyInjectedAsCollection alloc] initWithName:NSStringFromSelector(withSelector)];

    if (collectionValues)
    {
        __unsafe_unretained TyphoonPropertyInjectedAsCollection* weakPropertyInjectedAsCollection = propertyInjectedAsCollection;
        collectionValues(weakPropertyInjectedAsCollection);
    }
    [_injectedProperties addObject:propertyInjectedAsCollection];
}

- (void)setInitializer:(TyphoonInitializer*)initializer
{
    _initializer = initializer;
    [_initializer setComponentDefinition:self];
}

- (void)setFactory:(TyphoonDefinition*)factory
{
    _factory = factory;
    [self setFactoryReference:_factory.key];
}


/* ====================================================================================================================================== */
#pragma mark - Utility Methods

- (NSString*)description
{
    return [NSString stringWithFormat:@"Definition: class='%@'", NSStringFromClass(_type)];
}


@end
