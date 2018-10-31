//
//  DataPage.m
//  FM_CZFW
//
//  Created by liyuhui on 13-1-26.
//  Copyright (c) 2013年 ETelecom. All rights reserved.
//

#import "DataPage.h"

#define kDataPageDefaultPageSize        15
#define kDataPageDefaultMinPageCount    0

@interface DataPage ()
@property (nonatomic, assign) NSUInteger        pageSize;
@property (strong) NSMutableArray               *dataContainer;      //数据容器
@property (assign) NSUInteger                   currentPageIndex;
@end


@implementation DataPage
@synthesize pageCount = _pageCount;
@synthesize pageSize = _pageSize;
@synthesize dataContainer = _dataContainer;

+ (id)pageWithPageSize:(NSUInteger)pageSize
{
    return [[self alloc] initWithPageSize:pageSize];
}

+ (id)page
{
    return [self pageWithPageSize:kDataPageDefaultPageSize];
}

- (id)initWithPageSize:(NSUInteger)pageSize
{
    self = [super init];
    if (self == nil) 
        return nil;
    
    _pageSize = pageSize;
    _pageCount = 0;
    _currentPageIndex = 0; //0 是无效页
    [self cleanAllData];
    
    return self;
}

- (id)init
{
    return [self initWithPageSize:kDataPageDefaultPageSize];
}

#pragma mark - Data Managment
- (NSArray *)data
{
    return self.dataContainer;
}

- (NSUInteger)count
{
    return [self.dataContainer count];
}
- (BOOL)canLoadMore
{
    
    return self.pageCount < 0 || self.currentPageIndex < self.pageCount;
}
- (void)firstLoad
{
    _currentPageIndex = 0;
    _pageCount = -1;
}
- (NSUInteger)nextPageIndex
{
    return self.currentPageIndex + 1;
}

- (void)appendPage:(NSArray *)pageData
{   
    //数据个数大于分页尺寸，非法数据，不加入
    //if ([pageData count] > self.pageSize)
    //   return;
        
    [self.dataContainer addObjectsFromArray:pageData];
    
    self.currentPageIndex++;
}
- (void)appendData:(id)objectData
{
    [self.dataContainer addObject:objectData];
}
- (void)insertData:(id)objectData insertPos:(NSInteger)pos
{
    [self.dataContainer insertObject:objectData atIndex:pos];
}
- (void)appendDataHead:(NSArray *)pageData
{
    if (pageData.count < 1) {
        return;
    }
    [self.dataContainer insertObjects:pageData
                            atIndexes:[NSIndexSet indexSetWithIndexesInRange:NSMakeRange(0,[pageData count])]];
    
    self.currentPageIndex++;
}
- (void)deleteData:(id)data
{
    if (!data)
        return;
    
    [self.dataContainer removeObject:data];
}
- (void)deleteDataAtIndex:(NSUInteger)index
{
    [self.dataContainer removeObjectAtIndex:index];
}
- (void)deleteDataInArray:(NSArray* )datas
{
    if (!datas)
        return;
    
    [self.dataContainer removeObjectsInArray:datas];
}
- (void)cleanAllData
{
    [self setDataContainer:[NSMutableArray array]];
    [self setPageCount:0];
    [self setCurrentPageIndex:0];
}

- (void)replaceData:(id)objectData WithPos:(NSInteger)pos
{
    [self.dataContainer replaceObjectAtIndex:pos withObject:objectData];
}

@end
