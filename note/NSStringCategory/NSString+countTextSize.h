//
//  NSString+countTextSize.h
//  QQ消息
//
//  Created by  李俊 on 15/6/4.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (countTextSize)

/**
 *  计算文字所占大小
 *
 *  @param maxSize 最大的宽、高
 *  @param font    字体
 *
 *  @return 返回CGSize
 */

- (CGSize)countTextSize:(CGSize)maxSize andFont:(UIFont *)font;

@end
