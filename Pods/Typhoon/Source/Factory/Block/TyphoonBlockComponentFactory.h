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



#import <Foundation/Foundation.h>
#import "TyphoonComponentFactory.h"

@class TyphoonAssembly;


@interface TyphoonBlockComponentFactory : TyphoonComponentFactory

+ (instancetype)factoryWithAssembly:(TyphoonAssembly*)assembly;

+ (instancetype)factoryWithAssemblies:(NSArray*)assemblies;

- (instancetype)initWithAssembly:(TyphoonAssembly*)assembly;

- (instancetype)initWithAssemblies:(NSArray*)assemblies;

@end
