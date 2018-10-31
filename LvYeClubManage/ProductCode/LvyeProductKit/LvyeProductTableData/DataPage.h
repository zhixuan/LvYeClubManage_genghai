//
//  DataPage.h
//  FM_CZFW
//
//  Created by liyuhui on 14-4-1.
//  Copyright (c) 2013年 ETelecom. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataPage : NSObject
@property (readonly, nonatomic, assign) NSUInteger      pageSize;       //分页大小
@property (readonly, nonatomic, assign) NSArray         *data;          //数据容器的快捷访问方法
@property (nonatomic, assign) NSInteger                 pageCount;      //数据的总分页数目 -1 无限页数

+ (id)pageWithPageSize:(NSUInteger)pageSize;
+ (id)page; 

- (id)initWithPageSize:(NSUInteger)pageSize;
- (id)init; //init with default page size 15

  

/*
 count
 返回当前数据容器中拥有的数据个数
 */
- (NSUInteger)count;

/*
 canLoadMore
 查询是否还有未数据可以加载. (根据pageCount和当前pageIndexRange进行判断)
 */
- (BOOL)canLoadMore;

//第一次加载配合loadmorecell使用，调用此方法后canLoadMore为true,load完毕需要修改pagecount未真正的总页数
- (void)firstLoad;
/*
 nextPageIndex
 返回当前数据的下一页数据的分页索引值
 
 Special Considerations:
 此方法不会判断是否已经超出了分页的总大小.
 */
- (NSUInteger)nextPageIndex;

/*
 appendPage:
 在当前数据容器中加上一个分页的数据
 
 Parameters
    pageData:   一个分页大小的数据
 */
- (void)appendPage:(NSArray *)pageData;
- (void)appendData:(id)objectData;
- (void)insertData:(id)objectData insertPos:(NSInteger)pos;
- (void)appendDataHead:(NSArray *)pageData;
/*
 deleteData:
 删除当前数据容器中的一个指定数据
 
 Parameters
    data:   当前数据容器中需要移除的数据对象
    !!!!!   删除数据不会影响当前的分页索引数值. 当前是第几页，删除一些数据后仍然是第几页。 
 */
- (void)deleteData:(id)data;
- (void)deleteDataInArray:(NSArray* )datas;
- (void)deleteDataAtIndex:(NSUInteger)index;
/*
 cleanAllData
 清除当前携带的所有数据。恢复到没有任何数据时的状态
 */
- (void)cleanAllData;

- (void)replaceData:(id)objectData WithPos:(NSInteger)pos;


@end
