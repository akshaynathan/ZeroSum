//
//  ZSUtility.m
//  ZeroSum
//
//  Created by Akshay Nathan on 4/18/14.
//  Copyright (c) 2014 AkshayNathan. All rights reserved.
//

#import "ZSUtility.h"

@implementation ZSUtility

+(int)randomValue {
    int value = arc4random_uniform(8) + 1;
    return (rand() % 2) == 1 ? 0 - value : value;
}

@end
