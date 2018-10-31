//
//  ClubLeaderViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/15.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubLeaderViewController.h"
#import "ClubLeaderAddController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+CLubInfo.h"
#import "DataPage.h"
#import "ClubLeaderInfo.h"
#import "ClubLeaderTableViewCell.h"
#import "ClubLeaderDetailController.h"

@interface ClubLeaderViewController ()<UITableViewDelegate,UITableViewDataSource>


/*!
 * @property
 * @brief 数据信息
 */
@property (nonatomic ,  strong)      DataPage                           *dataSource;
@property (nonatomic, weak)     UITableView                             *tableView;
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;  //请求列表数据的操作
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;
@end

@implementation ClubLeaderViewController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        //MARK:加入其他信息
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
    [self setRightNavButtonTitleStr:@"添加" withFrame: kNavBarButtonRect
                       actionTarget:self action:@selector(userPersonalAddLeaderOperation)];
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

- (void)userPersonalAddLeaderOperation{
    
    ClubLeaderAddController *viewController = [[ClubLeaderAddController alloc]initWithUserOperaionStyle:LeaderOperationAddStyle leader:nil];
    [viewController setTitle:@"添加"];
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
    self.requestDataOperation=[KShareHTTPLvyeHTTPClient clubAllLeaderInfoWithClubId:KLvyeClubCurrentUser.clubId pageSize:self.dataSource.pageSize  pageNumber:self.dataSource.nextPageIndex completion:^(WebAPIResponse *response) {
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
                            ClubLeaderInfo *leaderInfo = [ClubLeaderInfo initClubLeaderInfoWithUnserializedJSONDic:moduleDic];
                            [mutableArray addObject:leaderInfo];
                        }
                        [weakSelf.dataSource appendPage:mutableArray];
                        
                        //页数
                        NSNumber* pages = (NSNumber*)ObjForKeyInUnserializedJSONDic(dataDictionary,@"totalPage");
                        if (pages != nil) {
                            weakSelf.dataSource.pageCount = [pages unsignedIntegerValue];
                        }
                        if ([mutableArray count] == 0) {
                            weakSelf.dataSource.pageCount = 0;
                        }
                        [weakSelf.tableView reloadData];
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
    ClubLeaderTableViewCell *leaderCell = [[ClubLeaderTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    return leaderCell;
    
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
    return KClubLeaderTableViewCellHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ClubLeaderTableViewCell *leaderCell=(ClubLeaderTableViewCell *)cell;
    ClubLeaderInfo *leaderInfo=(ClubLeaderInfo *)[self.dataSource.data objectAtIndex:indexPath.row];
    [leaderCell fillClubLeaderDataSource:leaderInfo];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString *cellIdentifier=@"ClubLeaderInfoCell";
    
    
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
    ClubLeaderInfo *info=(ClubLeaderInfo *)[self.dataSource.data objectAtIndex:indexPath.row];
    if (!IsStringEmptyOrNull(info.userId)) {
        ClubLeaderDetailController *viewController = [[ClubLeaderDetailController alloc]initWithLeaderIdInfo:info];
        [viewController setTitle:info.userName];
        [self.navigationController pushViewController:viewController animated:YES];
    }
}

@end
