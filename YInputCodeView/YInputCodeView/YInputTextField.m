//
//  YInputTextField.m
//  YInputCodeView
//
//  Created by shusy on 2018/1/8.
//  Copyright © 2018年 杭州爱卿科技. All rights reserved.
//

#import "YInputTextField.h"

@implementation YInputTextField
/**
 监听键盘删除键盘的点击
 */
- (void)deleteBackward {
    [super deleteBackward];
    if (self.didClickBackWard) {
        self.didClickBackWard(self);
    }
}
@end
