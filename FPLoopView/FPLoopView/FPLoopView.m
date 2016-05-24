//
//  FPLoopView.m
//  FPLoopView
//
//  Created by tusm on 16/5/23.
//  Copyright © 2016年 tusm. All rights reserved.
//

#import "FPLoopView.h"
#define FPDelayTime 2
@interface FPLoopView()
{
    UICollectionView *_collectionView;
    NSIndexPath *_indexPath;
    NSInteger count;
}
@property (nonatomic,strong)NSArray *images;
@property (nonatomic,copy)FPLoopBlcok operation;

@end

@implementation FPLoopView
+(instancetype)fpLoopView:(CGRect)frame withImages:(NSArray*)images withOperation:(FPLoopBlcok)operation{
    FPLoopView *view = [[FPLoopView alloc]initWithFrame:frame];
                view.images = images;
                view.operation = operation;
    return view;
}
-(void)creatSubView{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc]init];
    flow.itemSize = CGSizeMake(self.bounds.size.width, self.bounds.size.height);
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.minimumLineSpacing = 0;
    flow.minimumInteritemSpacing = 0;
    _collectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flow];
    _collectionView.pagingEnabled = YES;
    [_collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"collectionViewCell"];
    _collectionView.delegate = self;
    _collectionView.dataSource = self;
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.showsVerticalScrollIndicator = NO;
    _indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    [_collectionView scrollToItemAtIndexPath:_indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
    [self addSubview:_collectionView];
    [self performSelector:@selector(scrollToNext) withObject:nil afterDelay:FPDelayTime];
    
    
    
    _pageVC = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.bounds.size.height-20, self.bounds.size.width, 20)];
    _pageVC.numberOfPages = count;
    _pageVC.currentPage = (_indexPath.item-1)%count;
    
    [self addSubview:_pageVC];

}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return _images.count;
}
-(UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"collectionViewCell" forIndexPath:indexPath];
    UIImageView *imgV = [[UIImageView alloc]init];
    imgV.frame = CGRectMake(0, 0, self.bounds.size.width, self.bounds.size.height);
    imgV.image = [UIImage imageNamed:_images[indexPath.item%5]];
    [cell.contentView addSubview:imgV];
    return cell;;
}
-(void)scrollToNext{
    [_collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_indexPath.item+1 inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self performSelector:@selector(scrollToNext) withObject:nil afterDelay:FPDelayTime];

}
-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(scrollToNext) object:nil];
    [self performSelector:@selector(scrollToNext) withObject:nil afterDelay:FPDelayTime];
}
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{

    int page = (int)(scrollView.contentOffset.x/self.bounds.size.width-1)%count;
    _indexPath = [NSIndexPath indexPathForRow:(int)(scrollView.contentOffset.x/self.bounds.size.width) inSection:0];
    _pageVC.currentPage = page;
    if (_indexPath.item == count+1) {
        _collectionView.contentOffset = CGPointMake(self.bounds.size.width, 0);
        _indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
    }
}
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{

    if (scrollView.contentOffset.x == 0) {
        _collectionView.contentOffset = CGPointMake(self.bounds.size.width*count, 0);
        _indexPath = [NSIndexPath indexPathForRow:count inSection:0];
        
    }
}
-(void)setImages:(NSArray *)images{
    if (![images isKindOfClass:[NSArray class]] || images.count == 0) {
        return;
    }
    count = images.count;
    NSMutableArray *arr = [NSMutableArray arrayWithArray:images];
    [arr insertObject:[images lastObject] atIndex:0];
    [arr addObject:[images firstObject]];
    _images = arr;
    if (!_pageVC) {
        [self creatSubView];
    }
}
-(UIPageControl*)pageVC{
    if (!_pageVC) {
        [self creatSubView];
    }
    return _pageVC;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    _operation(_images[indexPath.item]);

}



@end
