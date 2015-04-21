//
//  UIViewController+BaseCollectionView.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSObject+GinSetterAndGetter.h"

#import "UIViewController+GinBaseCollectionView.h"

@implementation UIViewController (GinBaseCollectionView)

- (void)deallocSwizzle
{
    self.cellDataList = nil;
    self.collectionView.delegate = nil;
    [self deallocSwizzle];
}

- (void)awakeFromNibSwizzle
{
    [self awakeFromNibSwizzle];
    [self setup];
}


- (instancetype)initSwizzle
{
    self = [self initSwizzle];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.currentPageIndex = self.startIndex = 1;
}


- (void (^)(NSArray *dataList))GinSetupCellDataSuccessBlock
{
    return ^(NSArray *dataList) {
        if (dataList && dataList.count > 0) {
            self.cellDataList = dataList;
        } else {
            self.cellDataList = @[];
        }
        [self.collectionView reloadData];
        [self endRefreshing];
        
        self.currentPageIndex = self.startIndex;
        
        if (self.finishLoadData) {
            self.finishLoadData(self.collectionView);
        }
    };
}

- (void (^)(NSError *error))GinSetupCellDataFailureBlock
{
    return ^(NSError *error) {
        [self endRefreshing];
        if (self.finishLoadData) {
            self.finishLoadData(self.collectionView);
        }
    };
}

- (void (^)(NSArray *dataList))GinAddNewCellDataSuccessBlock
{
    return ^(NSArray *dataList) {
        
        if (dataList && dataList.count > 0) {
            NSMutableArray *mArray = [NSMutableArray arrayWithArray:self.cellDataList];
            [mArray addObjectsFromArray:dataList];
            self.cellDataList = mArray;
            
            [self.collectionView reloadData];
            [self endRefreshing];
            
        } else {
            [self endRefreshing];
        }
        
        self.currentPageIndex++;
        if (self.finishLoadData) {
            self.finishLoadData(self.collectionView);
        }
        
    };
}

- (void (^)(NSError *error))GinAddNewCellDataFailureBlock
{
    return [self GinSetupCellDataFailureBlock];
}


- (void)endRefreshing
{
    if (self.collectionView.header.isRefreshing) {
        [self.collectionView.header endRefreshing];
    }
    if (self.collectionView.footer.isRefreshing) {
        [self.collectionView.footer endRefreshing];
    }
}



#pragma mark- setter&getter

- (void)setFinishLoadData:(void (^)(UICollectionView *collectionView))finishLoadData
{
    [self setValue:finishLoadData key:@"finishLoadData" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}

- (void (^)(UICollectionView *))finishLoadData
{
    return [self getValueForKey:@"finishLoadData"];
}

- (void)setCurrentPageIndex:(NSUInteger)currentPageIndex
{
    [self setValue:@(currentPageIndex) key:@"currentPageIndex" policy:OBJC_ASSOCIATION_ASSIGN owner:self];
}
- (NSUInteger)currentPageIndex
{
    NSNumber *number = [self getValueForKey:@"currentPageIndex"];
    return number.unsignedIntegerValue;
}


- (void)setStartIndex:(NSUInteger)startIndex
{
    [self setValue:@(startIndex) key:@"startIndex" policy:OBJC_ASSOCIATION_ASSIGN owner:self];

}
- (NSUInteger)startIndex
{
    NSNumber *number = [self getValueForKey:@"startIndex"];
    return number.unsignedIntegerValue;
}


- (void)setCollectionView:(UICollectionView *)collectionView
{
    [self setValue:collectionView key:@"collectionView" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC owner:self];
}

- (UICollectionView *)collectionView
{
    UICollectionView *collectionView = [self getValueForKey:@"collectionView"];
    if (!collectionView) {
        
        collectionView = [UICollectionView defaultWithItemSize:CGSizeMake(78, 100)];
        
        [self setValue:collectionView key:@"collectionView" policy:OBJC_ASSOCIATION_RETAIN_NONATOMIC owner:self];

    }
    return collectionView;
}

- (void)setCellDataList:(NSArray *)cellDataList
{
    [self setValue:cellDataList key:@"cellDataList" policy:OBJC_ASSOCIATION_COPY_NONATOMIC owner:self];
}
- (NSArray *)cellDataList
{
    return [self getValueForKey:@"cellDataList"];
}

#pragma mark- 交换方法实现

+ (void)load
{
    //    交换deallac方法
    Method dealloc = class_getInstanceMethod([self class], NSSelectorFromString(@"dealloc"));
    Method deallocSwizzle = class_getInstanceMethod([self class], @selector(deallocSwizzle));
    method_exchangeImplementations(dealloc, deallocSwizzle);
    
    //    交换awakeFromNib方法
    Method awakeFromNib = class_getInstanceMethod([self class], NSSelectorFromString(@"awakeFromNib"));
    Method awakeFromNibSwizzle = class_getInstanceMethod([self class], @selector(awakeFromNibSwizzle));
    method_exchangeImplementations(awakeFromNib, awakeFromNibSwizzle);
    
    //    交换deallac方法
    Method init = class_getInstanceMethod([self class], NSSelectorFromString(@"init"));
    Method initSwizzle = class_getInstanceMethod([self class], @selector(initSwizzle));
    method_exchangeImplementations(init, initSwizzle);
    
}


@end
