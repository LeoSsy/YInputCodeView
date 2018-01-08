//
//  YInputTextField.h
//  YInputCodeView
//
//  Created by shusy on 2018/1/8.
//  Copyright © 2018年 杭州爱卿科技. All rights reserved.
//

#import <UIKit/UIKit.h>

@class YInputTextField;
typedef void(^didClickBackWard)(YInputTextField *textField);
@interface YInputTextField : UITextField
/**对应键盘删除按钮的点击*/
@property(nonatomic,copy)didClickBackWard didClickBackWard;
@end
