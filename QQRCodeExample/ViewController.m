//
//  ViewController.m
//  QQRCodeExample
//
//  Created by JHQ0228 on 2017/1/5.
//  Copyright © 2017年 QianQian-Studio. All rights reserved.
//

#import "ViewController.h"

// 包含头文件
#import "QQRCode.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

#pragma mark - 扫描二维码

- (IBAction)scanButtonClick:(UIButton *)sender {
    
    // 创建并开始扫描二维码
    QQRCode *qrCode = [QQRCode q_scanQRCode:^(BOOL isSucceed, NSString *result) {
        
        if (isSucceed) {
            
            [[[UIAlertView alloc] initWithTitle:@"Succeed"
                                        message:result
                                       delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil] show];
            
        } else {
            
            [[[UIAlertView alloc] initWithTitle:@"Failed"
                                        message:result
                                       delegate:nil
                              cancelButtonTitle:@"确定"
                              otherButtonTitles:nil] show];
        }
    }];
    
    // 设置我的二维码信息
    qrCode.myQRCodeInfo = @"qianchia";
    qrCode.headIcon = [UIImage imageNamed:@"demo1"];
    
    // 打开扫描视图控制器
    [self presentViewController:qrCode animated:YES completion:nil];
}

#pragma mark - 识别二维码

- (IBAction)recognizeButtonClick:(UIButton *)sender {
    
    // 创建图片，添加长按手势
    self.imageView.image = [UIImage imageNamed:@"demo"];
    
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(dealLongPress:)];
    [self.imageView addGestureRecognizer:longPress];
}

// 处理长按手势，识别图片中的二维码
- (void)dealLongPress:(UIGestureRecognizer *)gesture {
    
    if (gesture.state == UIGestureRecognizerStateBegan) {
        
        UIImageView *pressedImageView = (UIImageView *)gesture.view;
        UIImage *image = pressedImageView.image;
        
        // 识别图片中的二维码
        NSString *result = [image q_recognizeQRCode];
        
        [[[UIAlertView alloc] initWithTitle:@"Succeed"
                                    message:result
                                   delegate:nil
                          cancelButtonTitle:@"确定"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - 生成二维码

- (IBAction)createButtonClick:(UIButton *)sender {
    
    // 生成二维码
//    UIImage *qrImage = [UIImage q_createQRCodeFromString:@"qianchia"
//                                                headIcon:nil
//                                                   color:nil
//                                               backColor:nil];

    
    UIImage *qrImage = [UIImage q_createQRCodeFromString:@"qianchia"
                                                headIcon:[UIImage imageNamed:@"demo1"]
                                                   color:[UIColor redColor]
                                               backColor:[UIColor blueColor]];
    
    self.imageView.image = qrImage;
}














@end
