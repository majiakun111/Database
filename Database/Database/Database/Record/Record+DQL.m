//
//  Record+DQL.m
//  Database
//
//  Created by Ansel on 16/3/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "Record+DQL.h"
#import "DatabaseDAO.h"
#import "Record+Additions.h"

@interface Converter : NSObject

+ (NSArray <Record *> *)modelsOfClass:(Class )classs fromArray:(NSArray <NSDictionary *> *)array;

@end

@implementation Converter

+ (NSArray <Record *> *)modelsOfClass:(Class )classs fromArray:(NSArray <NSDictionary *> *)array
{
    if (!array) {
        return nil;
    }
    
    NSMutableArray <Record *> *records = [[NSMutableArray alloc] init];
    for (NSDictionary *dictionary in array) {
        Record *record = [[classs alloc] init];
        for (NSString *key in dictionary) {
            [record setValue:dictionary[key] forKeyPath:key];
        }
        
        [records addObject:record];
    }
    
    return records;
}

@end

@implementation Record (DQL)

- (NSArray <Record *> *)query
{
    return nil;
}

- (NSArray <Record *> *)queryAll
{
    NSArray *columns = [self getColumns];
    NSString *sql = [NSString stringWithFormat:@"select %@ from %@", [columns componentsJoinedByString:@", "], [self tableName]];

    NSArray <NSDictionary *> *results = [DATABASE executeQuery:sql];
    
    NSArray <Record *> *records = [Converter modelsOfClass:[self class] fromArray:results];
    
    return records;
}

@end
