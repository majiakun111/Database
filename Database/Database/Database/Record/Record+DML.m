//
//  Record+DML.m
//  Database
//
//  Created by Ansel on 16/3/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "Record+DML.h"
#import "DatabaseDAO.h"
#import "Record+Additions.h"
#import "NSObject+Record.h"
#import "RecordHeader.h"

@implementation Record (DML)

- (BOOL)save
{
    BOOL result = YES;
    
    [self saveBefore];
    
    result = [self insert];
    
    [self saveAfter];
    
    return result;
}

- (BOOL)delete
{
    return YES;
}

+ (BOOL)deleteAll
{
    NSString *sql = [NSString stringWithFormat:@"delete from %@", [self tableName]];
    return [DATABASE executeUpdate:sql];
}

- (BOOL)update
{
    return YES;
}

#pragma mark - Hook Method

- (void)saveBefore{}

- (void)saveAfter{}

- (void)deleteBefore{}

- (void)deleteAfter{}

- (void)deleteAllBefore{}

- (void)deleteAllAfter{}

- (void)updateBefore{}

- (void)updateAfter{}

#pragma mark - PrivateMethod

- (BOOL)insert
{
    NSArray *columns = [self getColumns];
    NSArray *values = [self getValuesWithPropertyList:columns];
    
    NSMutableString *sql = [NSMutableString stringWithFormat:@"replace into %@ (%@) values (", [self tableName], [columns componentsJoinedByString:@", "]];
    
    NSInteger count = [columns count];
    for (NSInteger index = 0; index < count; index++) {
        [sql appendFormat:@"'%@'", values[index]];
        if (index == count - 1) {
            [sql appendString:@")"];
        } else {
            [sql appendString:@", "];
        }
    }
    
    return [DATABASE executeUpdate:sql];
}

@end
