//
//  NoteCellFrame.h
//  note
//
//  Created by  李俊 on 15/6/9.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class Note;

@interface NoteCellFrame : NSObject

@property (assign, nonatomic) CGRect textF;
@property (assign, nonatomic) CGFloat rowH;

@property (strong, nonatomic) Note *note;


@end
