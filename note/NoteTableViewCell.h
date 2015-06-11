//
//  NoteTableViewCell.h
//  note
//
//  Created by  李俊 on 15/6/9.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FMMoveTableViewCell.h"
#define textFont [UIFont systemFontOfSize:16]


@class Note;


@interface NoteTableViewCell : FMMoveTableViewCell

@property (strong, nonatomic) Note *note;


+ (instancetype)noteCellWith:(UITableView *)tableView;


@end
