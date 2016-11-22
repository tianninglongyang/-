//
//  ViewController.m
//  手势解锁
//
//  Created by 张磊 on 2016/11/18.
//  Copyright © 2016年 leilei. All rights reserved.
//

#import "ViewController.h"
#import "LLView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet LLView *passwordView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.passwordView.password = ^BOOL(NSString * str){
        if ([str isEqualToString:@"012"]) {
            return YES;
        }
        else{
            return NO;
            
        }
    };
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
