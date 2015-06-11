//
//  Note.m
//  note
//
//  Created by  李俊 on 15/6/9.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import "Note.h"

@implementation Note


- (instancetype)initWithDictionary:(NSDictionary *)dic{
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dic];
    }
    
    return self;
}

+ (instancetype)noteWithDictionary:(NSDictionary *)dic{
    return [[self alloc] initWithDictionary:dic];
}

+ (NSMutableArray *)modelToArray:(NSArray *)fileArray{
    

    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in fileArray) {
        Note *note = [Note noteWithDictionary:dic];
        [tempArray addObject:note];
    }
    return tempArray;
    
}




@end
