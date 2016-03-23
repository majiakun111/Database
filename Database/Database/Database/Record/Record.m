//
//  Record.m
//  Database
//
//  Created by Ansel on 16/3/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "Record.h"
#import "Record+DDL.h"

@implementation Record

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createTable];
    }
    
    return self;
}

+ (NSString *)tableName
{
    return NSStringFromClass([self class]);
}

- (NSString *)tableName
{
    return [[self class] tableName];
}

@end
