//
//  NoteCellFrame.m
//  note
//
//  Created by  李俊 on 15/6/9.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import "NoteCellFrame.h"
#import "Note.h"
#import "NSString+countTextSize.h"

@implementation NoteCellFrame

- (void)setNote:(Note *)note{
    
    _note = note;
    
   UIScreen *screen = [UIScreen mainScreen];
    
    CGFloat margin = 10;
    
    CGFloat textX = margin;
    CGFloat textY = margin;
    CGSize maxSize = CGSizeMake(screen.bounds.size.width -margin * 3, 150);
    CGSize textSize = [note.text countTextSize:maxSize andFont:[UIFont systemFontOfSize:15]];
    
    
   self.textF = CGRectMake(textX, textY, textSize.width,textSize.height);
    
    
    
    self.rowH = textSize.height + margin;
    
}


@end
