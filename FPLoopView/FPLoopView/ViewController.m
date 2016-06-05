//
//  ViewController.m
//  FPLoopView
//
//  Created by tusm on 16/5/23.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import "ViewController.h"
#import "FPLoopView.h"
@interface ViewController ()
{

    FPLoopView *view;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //test1
    
    
    NSArray *arr= @[@"scene1.jpg",@"scene2.jpg",@"scene3.jpg",@"scene4.jpg",@"scene5.jpg"];
    CGRect frame = CGRectMake(50, 100, 300, 200);
    FPLoopView *loopView = [FPLoopView fpLoopView:frame withImages:arr withOperation:^(id object) {
        NSLog(@"%@",object);
    }];
    [self.view addSubview:loopView];
    
    
    
    
}

@end
