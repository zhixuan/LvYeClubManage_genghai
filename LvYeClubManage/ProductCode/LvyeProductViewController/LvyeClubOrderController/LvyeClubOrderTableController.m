//
//  LvyeClubOrderTableController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/9.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeClubOrderTableController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubOrder.h"
#import "DataPage.h"
#import "ClubOrderBaiscCell.h"
#import "ClubOrderInfo.h"
#import "ClubOrderDetailController.h"

 NSString    *const LvyeClubOrderForAllStyle = @"全部订单";
/**
 已支付订单
 **/
 NSString    *const LvyeClubOrderForHasPayStyle = @"已支付订单";
 NSString    *const LvyeClubOrderForUnPayStyle = @"未支付订单";
 NSString    *const LvyeClubOrderForRefundStyle = @"活动退款单";
 NSString    *const LvyeClubOrderForAfterServiceStyle = @"售后订单";

@interface LvyeClubOrderTableController ()<UITableViewDelegate,UITableViewDataSource>


/*!
 * @property
 * @brief 数据信息载体
 */
@property (nonatomic , strong)      DataPage            *dataSource;


@property (nonatomic, weak)     UITableView                             *tableView;
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;  //请求列表数据的操作
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;
/*!
 * @property
 * @brief 订单类别内容
 */
@property (nonatomic , copy)      NSString                              *clubOrderStyleStr;

@end

@implementation LvyeClubOrderTableController



#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.clubOrderStyleStr = [[NSString alloc]initWithFormat:@"%@",@"1"];
        
    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =  KDefaultViewBackGroundColor;
    
}
- (id)initWithOrderStyle:(NSInteger)orderStyle{
    self = [super init];
    if (self) {
        
        self.dataSource = [DataPage page];
         self.clubOrderStyleStr = [[NSString alloc]initWithFormat:@"%@",@"1"];
        
    }
    return self;
    
}

- (id)initWithTitle:(NSString *)title{
    self = [super init];
    if (self) {
        
        self.dataSource = [DataPage page];
         self.clubOrderStyleStr = [[NSString alloc]initWithFormat:@"%@",@"1"];
        
    }
    return self;
    
}
- (void)viewDidLoad {
    

    
    [super viewDidLoad];

    
    
    
    if([self.title isEqualToString:LvyeClubOrderForAllStyle]){
        self.clubOrderStyleStr = [[NSString alloc]initWithFormat:@"%@",@"1"];
    }else if ([self.title isEqualToString:LvyeClubOrderForHasPayStyle]){
        self.clubOrderStyleStr = [[NSString alloc]initWithFormat:@"%@",@"2"];
    }else if ([self.title isEqualToString:LvyeClubOrderForUnPayStyle]){
        self.clubOrderStyleStr = [[NSString alloc]initWithFormat:@"%@",@"3"];
    }else if ([self.title isEqualToString:LvyeClubOrderForRefundStyle]){
        self.clubOrderStyleStr = [[NSString alloc]initWithFormat:@"%@",@"4"];
    }else if ([self.title isEqualToString:LvyeClubOrderForAfterServiceStyle]){
        self.clubOrderStyleStr = [[NSString alloc]initWithFormat:@"%@",@"5"];
    }else{
        self.clubOrderStyleStr = [[NSString alloc]initWithFormat:@"%@",@""];
    }
    
    UITableView* tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.dataSource = self;
    tbView.delegate = self;
    self.tableView =tbView;
    [self.view addSubview:self.tableView ];
    
    
    __weak __typeof(&*self)weakSelf = self;
    [self.tableView addPullToRefreshWithActionHandler:^(void){
        [weakSelf refreshListData];
    }];
    ConfiguratePullToRefreshViewAppearanceForScrollView(self.tableView);
    [self.tableView triggerPullToRefresh];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)refreshListData
{
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    //清空当前数据源中所有数据
    [self.dataSource cleanAllData];
    [self.tableView reloadData];
    [self loadMoreListData];
}


- (void)loadMoreListData{
    
    __weak __typeof(&*self)weakSelf = self;
    
    
    self.requestDataOperation = [KShareHTTPLvyeHTTPClient clubOrderForOrderManageListInforWithClubId:KLvyeProductClubSettings.clubLoginUserAtClubId orderStyle:self.clubOrderStyleStr operationStyle:nil searchKey:nil pageSize:self.dataSource.pageSize pageNumber:self.dataSource.nextPageIndex completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (weakSelf.tableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf tableView]);
                
                [weakSelf.tableView.pullToRefreshView stopAnimating];
            }
            
            
            if (response.code == WebAPIResponseCodeSuccess) {
                
                if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]){
                    NSDictionary *dataDictionary =(NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"list") isKindOfClass:[NSArray class]]) {
                        NSArray *dataArray =(NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"list");
                        
                        NSMutableArray  *mutableArray =[NSMutableArray array];
                        
//                        NSDictionary *moduleDicfirst = (NSDictionary *)[dataArray firstObject];
                        for (NSDictionary *moduleDic in dataArray) {
                            ClubOrderInfo * itemInfo  =[ClubOrderInfo initWithClubItemOrderInfoCellAtOrderManagerWithUnserializedJSONDic:moduleDic];
                            [mutableArray addObject:itemInfo];
                        }
                        [weakSelf.dataSource appendPage:mutableArray];
                        //页数
                        NSNumber* pages = (NSNumber*)ObjForKeyInUnserializedJSONDic(dataDictionary,@"totalPage");
                        if (pages!=nil) {
                            weakSelf.dataSource.pageCount = [pages unsignedIntegerValue];
                        }
                        if ([mutableArray count] == 0) {
                            weakSelf.dataSource.pageCount = 0;
                        }
                        [weakSelf.tableView reloadData];
                    }else{
                        
                        if (response.code == WebAPIResponseCodeNetError) {
                            ShowAutoHideMBProgressHUD(weakSelf.view,NETERROR_LOADERR_TIP);
                        }
                        if (self.loadMoreCell) {
                            [self.loadMoreCell stopLoadingAnimation];
                            if (response.code == WebAPIResponseCodeNetError) {
                                self.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                            }else{
                                self.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                            }
                        }
                    }
                }else{
                    
                    if (response.code == WebAPIResponseCodeNetError) {
                        ShowAutoHideMBProgressHUD(weakSelf.view,NETERROR_LOADERR_TIP);
                    }
                    if (self.loadMoreCell) {
                        [self.loadMoreCell stopLoadingAnimation];
                        if (response.code == WebAPIResponseCodeNetError) {
                            self.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                        }else{
                            self.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                        }
                    }
                }
            }else{
                
                if (response.code == WebAPIResponseCodeNetError) {
                    ShowAutoHideMBProgressHUD(weakSelf.view,NETERROR_LOADERR_TIP);
                }
                if (self.loadMoreCell) {
                    [self.loadMoreCell stopLoadingAnimation];
                    if (response.code == WebAPIResponseCodeNetError) {
                        self.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                    }else{
                        self.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                    }
                }
            }
            
        });
    }];
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource count] + 1;
}


- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier{
    
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
        return CreateLoadMoreCell();
    ClubOrderBaiscCell *orderCell = [[ClubOrderBaiscCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    return orderCell;
    
}


#pragma mark UITableViewDelegate
- (BOOL)_isLoadMoreCellAtIndexPath:(NSIndexPath *)indexPath
{
    return (indexPath.row == [self.dataSource count]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if([self _isLoadMoreCellAtIndexPath:indexPath]) {
        return kSizeLoadMoreCellHeight;
    }
    
    
    CGFloat tourNameHeightFloat = 0.0f;
    ClubFinanceCapitalRecod *info=(ClubFinanceCapitalRecod*)[self.dataSource.data objectAtIndex:indexPath.row];
    CGSize boundingSize = CGSizeMake((KProjectScreenWidth - KBtnContentLeftWidth*1.5), MAXFLOAT);
    ///设置属性
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:KInforLeftIntervalWidth/2.5];
    NSDictionary *attDic =@{NSFontAttributeName: [UIFont systemFontOfSize:(16*KLVYEAdapterSizeWidth)],
                            NSParagraphStyleAttributeName:paragraphStyle,};
    CGRect contentRect =  [[NSString stringWithFormat:@"%@ -- %@",info.tourName,info.tourBasicId] boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
    
    tourNameHeightFloat =contentRect.size.height;
    
    return (KClubOrderBaiscCellHeight + tourNameHeightFloat);
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    /*
    ClubBillRecordCell *recordCell=(ClubBillRecordCell *)cell;
    ClubFinanceCapitalRecod *info=(ClubFinanceCapitalRecod*)[self.dataSource.data objectAtIndex:indexPath.row];
    [recordCell fillClubBillRecordShowTableCellDataSourceWithClubFinanceCapitalRecod:info];
    */
    
    ClubOrderInfo * itemInfo =(ClubOrderInfo*)[self.dataSource.data objectAtIndex:indexPath.row];
    ClubOrderBaiscCell *orderCell= (ClubOrderBaiscCell*)cell;
    [orderCell setupCellDataInfo:itemInfo];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString *cellIdentifier=@"ClubOrderBaiscCell";
    
    
    BOOL isLoadMoreCell = [self _isLoadMoreCellAtIndexPath:indexPath];
    cellIdentifier = isLoadMoreCell? kHUILoadMoreCellIdentifier: cellIdentifier;
    
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    
    if (!cell) {
        cell=[self createCellWithIdentifier:cellIdentifier];
    }
    
    if (!isLoadMoreCell)
        [self _configureCell:cell forRowAtIndexPath:indexPath];
    else
    {
        self.loadMoreCell = (HUILoadMoreCell*)cell;
        if ([self.dataSource canLoadMore])
        {
            
            __weak __typeof(&*self)weakSelf = self;
            [(HUILoadMoreCell*)cell setLoadMoreOperationDidStartedBlock:^{
                [weakSelf loadMoreListData];
            }];
            [(HUILoadMoreCell*)cell startLoadMore];
        }
        else
        {
            
            if (tableView.pullToRefreshView.state == SVPullToRefreshStateLoading) {
                cell.textLabel.text = LOADMORE_LOADING;
            }else{
                cell.textLabel.text = LOADMORE_LOADOVER;
            }
        }
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    /*
    ClubFinanceCapitalRecod *info=(ClubFinanceCapitalRecod*)[self.dataSource.data objectAtIndex:indexPath.row];
    ClubOrderDetailController *viewController = [[ClubOrderDetailController alloc]initWithOrderInfo:(ClubOrderInfo *)info];
    [viewController setTitle:@"订单详情"];
    [self.navigationController pushViewController:viewController animated:YES];
     */
    
    ClubOrderInfo *info=(ClubOrderInfo*)[self.dataSource.data objectAtIndex:indexPath.row];
    ClubOrderDetailController *viewController = [[ClubOrderDetailController alloc]initWithOrderInfo:(ClubOrderInfo *)info];
    [viewController setTitle:@"详情"];
    [self.navigationController pushViewController:viewController animated:YES];
}



@end
