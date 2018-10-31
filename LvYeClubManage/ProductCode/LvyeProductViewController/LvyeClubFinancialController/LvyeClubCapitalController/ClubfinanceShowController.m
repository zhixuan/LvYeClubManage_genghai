//
//  ClubfinanceShowController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubfinanceShowController.h"
#import "ClubWithdrawController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubFinance.h"
#import "DataPage.h"
#import "ClubfinanceShowTableCell.h"
#import "ClubFinanceCapitalRecod.h"
#import "ClubSettleDetailController.h"


@interface ClubfinanceShowController ()<UITableViewDataSource,UITableViewDelegate>

/*!
 * @property
 * @brief 数据内容
 */
@property (nonatomic ,  strong)      DataPage                           *dataSource;
@property (nonatomic, weak)     UITableView                             *tableView;
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;  //请求列表数据的操作
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;

/*!
 * @property
 * @brief 俱乐部财务账户资金说明视图
 */
@property (nonatomic , weak)      UIView                                *clubFinanceCapitalHeaderView;

@end

@implementation ClubfinanceShowController



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
    
    [self setRightNavButtonTitleStr:@"提现" withFrame:kNavBarButtonRect
                       actionTarget:self action:@selector(userRightButtonEventOperation)];
    
    __weak __typeof(&*self)weakSelf = self;
    [KShareHTTPLvyeHTTPClient clubCapitalAccountCapitalShowWithClubId:KLvyeClubCurrentUser.clubId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            if (response.code == WebAPIResponseCodeSuccess) {
                if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]){
                    NSDictionary *dataDictionary =(NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    KLvyeClubCurrentUser.clubInsertCapital = StringForKeyInUnserializedJSONDic(dataDictionary, @"insertCap");
                    KLvyeClubCurrentUser.clubSubtractCapital = StringForKeyInUnserializedJSONDic(dataDictionary, @"subtractCap");
                    CGFloat clubReslutCapitalFloat = [KLvyeClubCurrentUser.clubInsertCapital floatValue] - [KLvyeClubCurrentUser.clubSubtractCapital floatValue];
                    NSString *clubReslutCapitalStr = [NSString stringWithFormat:@"%.2f",clubReslutCapitalFloat];
                    [KLvyeClubCurrentUser setClubCapitalSurplusMoney:clubReslutCapitalStr];
                    [weakSelf clubCapitalHeaderView];
                }
            }
        });
    }];
    
    
    UITableView* tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    tbView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    tbView.separatorStyle = UITableViewCellSeparatorStyleNone;
    tbView.backgroundColor = [UIColor clearColor];
    tbView.dataSource = self;
    tbView.delegate = self;
    self.tableView =tbView;
    [self.view addSubview:self.tableView ];
    
    
    
    [self.tableView addPullToRefreshWithActionHandler:^(void){
        [weakSelf refreshListData];
    }];
    ConfiguratePullToRefreshViewAppearanceForScrollView(self.tableView);
    [self.tableView triggerPullToRefresh];
}

- (void)clubCapitalHeaderView{

    UIView * capitalHeaderView = [[UIView alloc]init];
    [capitalHeaderView setBackgroundColor:[UIColor clearColor]];
    [capitalHeaderView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, 70.0f)];
    self.clubFinanceCapitalHeaderView = capitalHeaderView;
    return;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)userRightButtonEventOperation{
    
    
    ClubWithdrawController *viewController = [[ClubWithdrawController alloc]init];
    [viewController setTitle:@"提现"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
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
    
    
    self.requestDataOperation = [KShareHTTPLvyeHTTPClient clubOperationFinishWithdrawListWithClubId:KLvyeClubCurrentUser.clubId userId:KLvyeClubCurrentUser.userId pageSize:self.dataSource.pageSize pageNumber:self.dataSource.nextPageIndex completion:^(WebAPIResponse *response)  {
        
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
                            ClubFinanceCapitalRecod *bankInfor = [ClubFinanceCapitalRecod initClubFinanceCapitalRecodWithUnserializedJSONDic:moduleDic];
                            [mutableArray addObject:bankInfor];
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
    ClubfinanceShowTableCell *bankCell = [[ClubfinanceShowTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
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
    return KClubfinanceShowTableCellHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ClubfinanceShowTableCell *recordCell=(ClubfinanceShowTableCell *)cell;
    ClubFinanceCapitalRecod *info=(ClubFinanceCapitalRecod*)[self.dataSource.data objectAtIndex:indexPath.row];
    [recordCell fillClubfinanceShowTableCellDataSourceWithClubFinanceCapitalRecod:info];
    
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
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ClubFinanceCapitalRecod *info=(ClubFinanceCapitalRecod*)[self.dataSource.data objectAtIndex:indexPath.row];
    NSLog(@"capitalMoneyCotnent is %@",info.capitalMoneyCotnent);

    if(info.capitalRecodStatusType ==1){
        ClubSettleDetailController *viewController = [[ClubSettleDetailController alloc]initWithBillCheckNumber:info.capitalRecodNumber];
        [viewController setTitle:@"详情"];
        [self.navigationController pushViewController:viewController animated:YES];
    }

}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 70.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return self.clubFinanceCapitalHeaderView;
}

@end
