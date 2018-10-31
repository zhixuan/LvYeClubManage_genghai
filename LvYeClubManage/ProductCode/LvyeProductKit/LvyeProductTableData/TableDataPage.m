//
//  TableDataPage.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/2.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "TableDataPage.h"


#define kDataPageDefaultPageSize        15
#define kDataPageDefaultMinPageCount    0

@interface TableDataPage ()
/*!
 * @property
 * @brief 页面大小
 */
@property (nonatomic ,  assign)      NSUInteger             pageSize;
/*!
 * @property
 * @brief 数组容器
 */
@property (nonatomic , strong)      NSMutableArray          *dataContainer;
/*!
 * @property
 * @brief 当前位置
 */
@property (nonatomic ,  assign)      NSUInteger             currentPageIndex;



@end


@implementation TableDataPage

- (instancetype)init{
    self = [super init];
    if (self) {
    }
    return self;
}
- (instancetype)initWithPageSize:(NSUInteger) pageSize{
    self = [super init];
    if (self) {
        
    }
    self.pageSize = pageSize;
    self.pageCount = 0;
    self.currentPageIndex = 0;
    [self clearAllData];
    return self;
}

+(instancetype)page{
  return [[super alloc]initWithPageSize:kDataPageDefaultPageSize];
}
+(instancetype)pageWithPageSize:(NSUInteger)pageSize{
    return [[super alloc]initWithPageSize:pageSize];
}

- (NSArray *)data
{
    return self.dataContainer;
}

- (NSUInteger)count{
    return [self.dataContainer count];
}


- (BOOL)canLoadMore{
   return self.pageCount < 0.001|| self.currentPageIndex < self.pageCount;
}

- (void)fristLoad{
    self.currentPageIndex = 0;
    self.pageCount = -1;
}

- (NSUInteger)nextPageIndex{
    return self.currentPageIndex + 1;
}

- (void)appendPage:(NSArray *)pageData{
    
    [self.dataContainer addObjectsFromArray:pageData];
    self.currentPageIndex++;
}
- (void)appendData:(id)objectData{
    [self.dataContainer addObject:objectData];
}
- (void)insertData:(id)objectData atIndex:(NSUInteger)index{
    
    [self.dataContainer insertObject:objectData atIndex:index];
}
- (void)appendDataHead:(NSArray *)pageData{
    if (pageData.count < 1) {
        return;
    }
    [self.dataContainer insertObjects:pageData
                            atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,[pageData count])]];
    
    self.currentPageIndex++;
}

- (void)clearAllData{
    
    [self setDataContainer:[NSMutableArray array]];
    [self setPageSize:0];
    [self setCurrentPageIndex:0];
}

@end
