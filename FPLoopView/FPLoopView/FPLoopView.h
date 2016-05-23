//
//  FPLoopView.h
//  FPLoopView
//
//  Created by tusm on 16/5/23.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FPLoopView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)  UIPageControl *pageVC;
@property (nonatomic,strong)NSArray *images;
@end
