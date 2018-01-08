//
//  YInputCodeView.h
//  YInputCodeView
//
//  Created by shusy on 2018/1/8.
//  Copyright © 2018年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>
/**
 用户输入完成后的回调
 @param result 用户输入的数据
 */
typedef void(^InputCodeViewCompletion)(NSString* result);

@interface YInputCodeView : UIView

/** 用户输入完成后的回调*/
@property(nonatomic,strong)InputCodeViewCompletion completion;

/**
 设置文本框之间的间距
 
 @param margin 间距
 */
- (void)setTextFMargin:(CGFloat)margin;

/**
 设置文本框的个数
 
 @param num 文本框个数
 */
- (void)setTextFNum:(NSInteger)num;

/**
 设置文本框的宽度
 
 @param width 文本框宽度
 */
- (void)setTextFWidth:(CGFloat)width;

/**
 设置文本框的字体 和 字体颜色
 @param font 字体
 @param textColor 文字颜色
 */
- (void)setTextFieldFont:(NSInteger)font textColor:(UIColor*)textColor;

/**
 设置文本框的边框宽度 和 颜色
 @param width 边框宽度
 @param borderColor 边框颜色
 */
- (void)setTextFieldBorderW:(CGFloat)width borderColor:(UIColor*)borderColor;

/**
 设置光标的颜色
 
 @param color 光标的颜色
 */
- (void)setFocusColor:(UIColor*)color;

@end
