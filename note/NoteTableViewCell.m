//
//  NoteTableViewCell.m
//  note
//
//  Created by  李俊 on 15/6/9.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import "NoteTableViewCell.h"
#import "Note.h"
#import "NSString+countTextSize.h"
#import "Masonry.h"


@interface NoteTableViewCell ()

@property (weak, nonatomic) UILabel *text;

@end


@implementation NoteTableViewCell

+ (instancetype)noteCellWith:(UITableView *)tableView{
    
    NoteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"note"];
    if (cell == nil) {
        cell = [[NoteTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"note"];
        
    }
    
    return cell;
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if ([super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        UILabel *text = [[UILabel alloc] init];
        self.text = text;
        self.text.numberOfLines = 0;
        self.text.font = textFont;
        [self.contentView addSubview:text];
        
        [text mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.mas_equalTo(text.superview).offset(20);
            make.bottom.right.mas_equalTo(text.superview).offset(-20);
            make.height.mas_lessThanOrEqualTo(120);
        }];
        
        self.contentView.backgroundColor = [UIColor colorWithRed:247/255.0 green:255/255.0 blue:255/255.0 alpha:1];
    }
    
    return self;
}

- (void)setNote:(Note *)note{
    
    _note = note;
    
    self.text.text = note.text;

}

@end
