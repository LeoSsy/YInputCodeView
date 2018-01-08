//
//  YInputCodeView.m
//  YInputCodeView
//
//  Created by shusy on 2018/1/8.
//  Copyright © 2018年 杭州爱卿科技. All rights reserved.
//

#import "YInputCodeView.h"
#import "YInputTextField.h"
static const CGFloat textFMargin = 10; //默认间距
static const NSInteger textFNum = 4; //默认个数
static const NSInteger textFW = 40; //默认宽度

@interface YInputCodeView()<UITextFieldDelegate>
/**存放所有的输入框*/
@property(nonatomic,strong)NSMutableArray *textFields;
/**文本框之间的间距*/
@property(nonatomic,assign)CGFloat textFieldMargin;
/**文本框的个数*/
@property(nonatomic,assign)NSInteger textFieldNum;
/**文本框的宽度*/
@property(nonatomic,assign)CGFloat textFieldW;
/**记录上一个文本框*/
@property(nonatomic,strong)YInputTextField * preTextField;
@end

@implementation YInputCodeView

- (NSMutableArray *)textFields  {
    if (!_textFields) {
        _textFields = [NSMutableArray array];
    }
    return _textFields;
}

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.textFieldMargin = textFMargin;
        self.textFieldNum = textFNum;
        self.textFieldW = textFW;
        [self createTextFilds];
    }
    return self;
}

/**
 设置文本框之间的间距

 @param margin 间距
 */
- (void)setTextFMargin:(CGFloat)margin {
    self.textFieldMargin = margin;
    [self setNeedsLayout];
}

/**
 设置文本框的个数
 
 @param num 文本框个数
 */
- (void)setTextFNum:(NSInteger)num {
    self.textFieldNum = num;
    [self.textFields makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.textFields removeAllObjects];
    [self createTextFilds];
}

/**
 设置文本框的宽度
 
 @param width 文本框宽度
 */
- (void)setTextFWidth:(CGFloat)width {
    self.textFieldW = width;
    [self setNeedsLayout];
}

/**
 设置文本框的字体 和 字体颜色
 @param font 字体
 @param textColor 文字颜色
 */
- (void)setTextFieldFont:(NSInteger)font textColor:(UIColor*)textColor {
    for (UITextField *textField in self.textFields) {
        textField.font = [UIFont boldSystemFontOfSize:font];
        textField.textColor = textColor;
    }
}

/**
 设置文本框的边框宽度 和 颜色
 @param width 边框宽度
 @param borderColor 边框颜色
 */
- (void)setTextFieldBorderW:(CGFloat)width borderColor:(UIColor*)borderColor {
    for (UITextField *textField in self.textFields) {
        textField.layer.borderColor = borderColor.CGColor;
        textField.layer.borderWidth = width;
    }
}

/**
 设置光标的颜色
 
 @param color 光标的颜色
 */
- (void)setFocusColor:(UIColor*)color {
    for (UITextField *textField in self.textFields) {
        textField.tintColor = color;
    }
}

/**
 创建所有文本框
 */
- (void)createTextFilds{
    for (int i = 0 ; i< self.textFieldNum ; i++) {
        YInputTextField *textField = [[YInputTextField alloc] init];
        textField.delegate = self;
        textField.tag = i;
        textField.font = [UIFont boldSystemFontOfSize:20];
        textField.textColor = [UIColor blackColor];
        textField.borderStyle = UITextBorderStyleNone;
        textField.layer.borderColor = [UIColor grayColor].CGColor;
        textField.layer.borderWidth = 1;
        textField.textAlignment = NSTextAlignmentCenter;
        __weak typeof(self) weakSelf = self;
        textField.didClickBackWard = ^(UITextField *textField) {
            __strong typeof(self) strongSelf = weakSelf;
            for (UITextField *textField in strongSelf.textFields) {
                if (!textField.isFirstResponder) {continue;}
                textField.text = @"";
                if (textField.tag - 1 >= 0) {
                    UITextField *preTextField = self.textFields[textField.tag-1] ;
                    [preTextField becomeFirstResponder];
                }
            }
        };
        [self.textFields addObject:textField];
        [self addSubview:textField];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    // 计算左间距
    CGFloat width = self.frame.size.width;
    CGFloat leftmargin = (width - self.textFieldW * self.textFieldNum - self.textFieldNum* self.textFieldMargin)/2;
    for (int i = 0 ; i< self.textFields.count ; i++) {
        YInputTextField *textField = self.textFields[i];
        textField.frame = CGRectMake(leftmargin+i*self.textFieldMargin+i*self.textFieldW, 0, self.textFieldW, self.textFieldW);
    }
}

#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    if (textField.text.length > 1) {
        return false;
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    if (!textField.hasText) {
        //获取当前文本框
        NSInteger index = textField.tag;
        //让当前文本框失去焦点
        [textField resignFirstResponder];
        if (index < self.textFieldNum - 1) { //如果不是最后一个文本框
            UITextField *textField = self.textFields[index];
            textField.text = string;
            UITextField *nextTextField = self.textFields[index+1];
            [nextTextField becomeFirstResponder];
        }else{
            UITextField *textField = self.textFields[index];
            textField.text = string;
            if (self.completion) {
                //获取用户最终输入的数据
                NSMutableString *result = [NSMutableString string];
                for (UITextField *textField in self.textFields) {
                    [result appendString:textField.text];
                }
                self.completion(result);
            }
        }
    }else {
        return true;
    }
    return false;
}

@end
