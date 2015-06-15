//
//  Note.h
//  note
//
//  Created by  李俊 on 15/6/9.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Note : NSObject <NSCoding>

@property (copy, nonatomic) NSString *text;

- (instancetype)initWithDictionary:(NSDictionary *)dic;
+ (instancetype)noteWithDictionary:(NSDictionary *)dic;
+ (NSMutableArray *)modelToArray:(NSArray *)fileArray;



@end
