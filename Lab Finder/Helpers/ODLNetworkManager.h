//
//  ODLNetworkManager.h
//  Lab Finder
//
//  Created by Daniel Tomlinson on 28/04/2014.
//  Copyright (c) 2014 We Are Base. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ODLNetworkManager : NSObject

- (RACSignal *)fetchAllDeviceLabs;

@end
