//
//  ClubSettleController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/15.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubSettleController.h"
#import "DataPage.h"
#import "ClubWithdrawController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubFinance.h"
#import "ClubSettleTableCell.h"
#import "ClubFinanceCapitalRecod.h"
#import "ClubSettleDetailController.h"
@interface ClubSettleController ()<UITableViewDataSource,UITableViewDelegate>

/*!
 * @property
 * @brief 数据内容
 */
@property (nonatomic ,  strong)      DataPage                           *dataSource;
@property (nonatomic, weak)     UITableView                             *tableView;
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;  //请求列表数据的操作
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;
@end

@implementation ClubSettleController


#pragma mark -
#pragma mark -  系统方法
- (id)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
    }
    return self;
}
- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:HUIApplicationFrame()];
    self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.view.backgroundColor =  KDefaultViewBackGroundColor;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
    
    
    self.requestDataOperation = [KShareHTTPLvyeHTTPClient clubShowClubBillsettleUpListWithClubId:KLvyeClubCurrentUser.clubId userId:KLvyeClubCurrentUser.userId billNum:@"" state:@"" addTime:@"" pageSize:self.dataSource.pageSize pageNumber:self.dataSource.nextPageIndex completion:^(WebAPIResponse *response) {
  
        
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
                        for (NSDictionary *moduleDic in dataArray) {
                            ///信息解析
                            ClubFinanceCapitalRecod *recordInfor = [ClubFinanceCapitalRecod initClubFinanceCapitalRecodForSettleUpListWithUnserializedJSONDic:moduleDic];
                            [mutableArray addObject:recordInfor];
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
                        if (weakSelf.loadMoreCell) {
                            [weakSelf.loadMoreCell stopLoadingAnimation];
                            if (response.code == WebAPIResponseCodeNetError) {
                                weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                            }else{
                                weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                            }
                        }
                    }
                }
            }else{
                if (response.code == WebAPIResponseCodeNetError) {
                    ShowAutoHideMBProgressHUD(weakSelf.view,NETERROR_LOADERR_TIP);
                }
                if (weakSelf.loadMoreCell) {
                    [weakSelf.loadMoreCell stopLoadingAnimation];
                    if (response.code == WebAPIResponseCodeNetError) {
                        weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                    }else{
                        weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                    }
                }
            }
        });
    } ];
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
    ClubSettleTableCell *bankCell = [[ClubSettleTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    return bankCell;
    
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
    return KClubSettleTableCellHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ClubSettleTableCell *recordCell=(ClubSettleTableCell *)cell;
    ClubFinanceCapitalRecod *info=(ClubFinanceCapitalRecod*)[self.dataSource.data objectAtIndex:indexPath.row];
    [recordCell fillClubSettleTableCellDataSourceWithClubFinanceCapitalRecod:info];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString *cellIdentifier=@"ClubBankInforCell";
    
    
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
    
    ///点击反馈
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    ///容错处理
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ///信息传递
    ClubFinanceCapitalRecod *info=(ClubFinanceCapitalRecod*)[self.dataSource.data objectAtIndex:indexPath.row];
    ClubSettleDetailController *viewController = [[ClubSettleDetailController alloc]initWithClubFinanceCapitalRecord:info];
    [viewController setTitle:@"账单详情"];
    [self.navigationController pushViewController:viewController animated:YES];

}

@end
