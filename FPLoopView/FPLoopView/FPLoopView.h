//
//  FPLoopView.h
//  FPLoopView
//
//  Created by tusm on 16/5/23.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^FPLoopBlcok)(id object);
@interface FPLoopView : UIView<UICollectionViewDelegate,UICollectionViewDataSource>

@property (strong, nonatomic)  UIPageControl *pageVC;
+(instancetype)fpLoopView:(CGRect)frame withImages:(NSArray*)images withOperation:(FPLoopBlcok)operation;
@end
