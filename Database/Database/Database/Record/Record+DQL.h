//
//  Record+DQL.h
//  Database
//
//  Created by Ansel on 16/3/22.
//  Copyright © 2016年 PingAn. All rights reserved.
//

#import "Record.h"

@interface Record (DQL)

- (NSArray <Record *> *)query;

- (NSArray <Record *> *)queryAll;

@end
