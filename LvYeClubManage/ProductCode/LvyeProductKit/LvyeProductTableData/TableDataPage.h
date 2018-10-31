//
//  TableDataPage.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/2.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>


/**
 初始化通用的 TableView 数据源处理 入口，包括页码，总页数，每页大小等数据，可处理清空等操作；
 */
@interface TableDataPage : NSObject


/*!
 * @property
 * @brief 页面数据大小
 */
@property (readonly,nonatomic , assign)      NSUInteger     pageSize;

/*!
 * @property
 * @brief 数据源数组，可直接进行访问处理
 */
@property (readonly ,  nonatomic,assign)      NSArray       *data;

/*!
 * @property
 * @brief 数据总页数内容
 */
@property (nonatomic , assign)      NSUInteger              pageCount;


- (instancetype)init;
- (instancetype)initWithPageSize:(NSUInteger) pageSize;

+(instancetype)page;
+(instancetype)pageWithPageSize:(NSUInteger)pageSize;


- (NSUInteger)count;


- (BOOL)canLoadMore;

- (void)fristLoad;
- (void)clearAllData;

- (NSUInteger)nextPageIndex;

- (void)appendPage:(NSArray *)pageData;
- (void)appendData:(id)objectData;
- (void)insertData:(id)objectData atIndex:(NSUInteger)index;
- (void)appendDataHead:(NSArray *)pageData;



@end
