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
    view = [[FPLoopView alloc]initWithFrame:CGRectMake(50, 200, self.view.bounds.size.width-100, 300)];
     NSArray *arr= @[@"scene1.jpg",@"scene2.jpg",@"scene3.jpg",@"scene4.jpg",@"scene5.jpg"];
    view.images = arr;
    [self.view addSubview:view];
    
    
    
    
}

@end
