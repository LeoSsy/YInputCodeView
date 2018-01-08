//
//  ViewController.m
//  YInputCodeView
//
//  Created by shusy on 2018/1/8.
//  Copyright © 2018年 杭州爱卿科技. All rights reserved.
//

#import "ViewController.h"
#import "YInputCodeView.h"

@interface ViewController ()
@property(nonatomic,strong)YInputCodeView *inputCodeView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    YInputCodeView *inputCodeView = [[YInputCodeView alloc] initWithFrame:CGRectMake(0, 100, self.view.bounds.size.width, 100)];
    inputCodeView.completion = ^(NSString *result) {
        NSLog(@"result ====%@",result);
    };
    [self.view addSubview:inputCodeView];
    self.inputCodeView = inputCodeView;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.inputCodeView setTextFNum:4];
    [self.inputCodeView setTextFWidth:60];
    [self.inputCodeView setTextFMargin:20];
    [self.inputCodeView setTextFieldBorderW:2 borderColor:[UIColor redColor]];
    [self.inputCodeView setTextFieldFont:30 textColor:[UIColor blackColor]];
    [self.inputCodeView setFocusColor:[UIColor purpleColor]];
}

@end
