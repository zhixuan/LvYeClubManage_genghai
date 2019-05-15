//
//  ClubTourManagesController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/20.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubTourManagesController.h"
#import "LGRightMenuView.h"
#import "TourBasicInfo.h"
#import "DataPage.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubTour.h"
#import "ClubToursMoreChooseViewController.h"
#import "ClubTourTableCell.h"
#import "LvyeBaseWebViewController.h"


@interface ClubTourManagesController ()<ClubToursMoreChooseDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
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
 * @brief 活动查询状态
 */
@property (nonatomic , strong)      NSString                            *tourChooseStatusStr;
/*!
 * @property
 * @brief 用户查询类别 operaType 默认=1，表示基本查询;=2 即:线路编号查 询;=3，表示活动名查询;=4，则为时间查询;
 */
@property (nonatomic , strong)      NSString                            *tourChooseOperaTypeStr;

/*!
 * @property
 * @brief 用户c选中的活动线路
 */
@property (nonatomic , strong)      TourBasicInfo                       *clubUserSelectedTourInfo;



/*!
 * @property
 * @brief 用户操作界面
 */
@property (nonatomic , weak)      LGRightMenuView     *rightMenuChooseView;
@end

@implementation ClubTourManagesController
#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.tourChooseStatusStr = [[NSString alloc]initWithFormat:@"%@",@"0"];
        self.tourChooseOperaTypeStr = [[NSString alloc]initWithFormat:@"%@",@"1"];
        self.clubUserSelectedTourInfo = [[TourBasicInfo alloc]init ];
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
    
    
    [self setRightNavButtonFA:FMIconFontF142 withFrame:kNavBarButtonRect
                 actionTarget:self action:@selector(tourMoreConditionalOperation)];
    
    
    CGRect rect = CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight);
    NSDictionary *menuDict= @{@"全部":@"0",
                              @"编辑中":@"9",
                              @"报名中":@"2",
                              @"已下架":@"8",
                              @"更多":@"999",
                              };
    
    NSArray  *menuArray = @[@"全部",@"编辑中",@"报名中",@"已下架",@"更多"];
    LGRightMenuView *rightMenuView = [[LGRightMenuView alloc]initWithFrame:rect content:menuDict menuContent:menuArray];
    self.rightMenuChooseView =rightMenuView;
    [self.rightMenuChooseView setHidden:YES];
    [self.navigationController.view.window addSubview:self.rightMenuChooseView ];
    
    

    
    __weak __typeof(&*self)weakSelf = self;
    self.rightMenuChooseView.block=^(BOOL showMore,NSDictionary *operation){
        
        if (showMore) {
            NSLog(@"显示更多操作条件");
            [weakSelf.rightMenuChooseView setHidden:YES];

            ClubToursMoreChooseViewController *viewController = [[ClubToursMoreChooseViewController alloc]initWithDelegate:weakSelf];
            [viewController setTitle:@"更多"];
            [weakSelf.navigationController pushViewController:viewController animated:YES];
            
        }else{
             [weakSelf.rightMenuChooseView setHidden:YES];
            weakSelf.tourChooseStatusStr  = StringForKeyInUnserializedJSONDic(operation, @"tourStatus");
            [weakSelf refreshListData];
           NSLog(@"///刷新界面内容");
            
           
        }
    };
    

    UITableView* tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
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
    
    
    /*
     
     [NSDictionary dictionaryWithObjectsAndKeys:self.tourChooseStatusStr,@"tourStatus", nil]
     
     **/
    
    
    NSDictionary *paramInfo= @{@"tourStatus":self.tourChooseStatusStr,
                               @"operaType":self.tourChooseOperaTypeStr,
                               @"searchKey":@""
                               };
    
    
    if (self.dataSource.nextPageIndex ==1) {
        WaittingMBProgressHUD(self.view, @"加载中....");
    }
    self.requestDataOperation = [KShareHTTPLvyeHTTPClient clubTourManageTourListDataInfoWithClubId:KLvyeClubCurrentUser.clubId pageSize:self.dataSource.pageSize pageNumber:self.dataSource.nextPageIndex param:paramInfo completion:^(WebAPIResponse *response) {
        
       
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (weakSelf.dataSource.nextPageIndex ==1) {
                FinishMBProgressHUD(weakSelf.view);
            }
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
                            TourBasicInfo *recordInfor = [TourBasicInfo initClubTourBasicInfoForClubTourManagesTourTableWithUnserializedJSONDic:moduleDic];
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
    ClubTourTableCell *bankCell = [[ClubTourTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
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
    return KClubTourTableCellHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ClubTourTableCell *recordCell=(ClubTourTableCell *)cell;
    TourBasicInfo *info=(TourBasicInfo*)[self.dataSource.data objectAtIndex:indexPath.row];
    [recordCell fillClubTourTableCellDataSourceWithTourBasicInfo:info];
    
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

    
    TourBasicInfo *cellInfo  =(TourBasicInfo*)[self.dataSource.data objectAtIndex:indexPath.row];
    self.clubUserSelectedTourInfo =cellInfo;
//    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:@"是否确定提交审核该活动" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
//    [alertView show];
    
    LvyeBaseWebViewController *webViewContrl = [[LvyeBaseWebViewController alloc] initWithTourId:cellInfo.tourBasicId];
    [self.navigationController pushViewController:webViewContrl animated:YES ];
}


#pragma mark -
#pragma mark -  更多条件的筛选操作
- (void)tourMoreConditionalOperation{
    

    [self.rightMenuChooseView setHidden:NO];
}

- (void)userPersonalChooseMoreOperation:(NSDictionary *)info{
    
    NSLog(@"啥信息都没有");
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    
    
    NSLog(@"buttonIndex is %ld",buttonIndex);
    
    if(buttonIndex!=0){
        [self userPersonalSubmintTourInfoRequest];
    }
}

- (void)userPersonalSubmintTourInfoRequest{
    
    WaittingMBProgressHUD(self.view, @"正在提交...");
    __weak __typeof(&*self)weakSelf = self;
    [KShareHTTPLvyeHTTPClient clubTourManageUpdateItemTourStatueWithClubId:KLvyeClubCurrentUser.clubId tourId:self.clubUserSelectedTourInfo.tourId tourBaseId:self.clubUserSelectedTourInfo.tourBasicId opeartion:1 completion:^(WebAPIResponse *response) {
   
        dispatch_async(dispatch_get_main_queue(), ^(void){
       
            if (response.code == WebAPIResponseCodeSuccess) {
                FinishMBProgressHUD(self.view);
                [weakSelf refreshListData];
            }else if (response.code == WebAPIResponseCodeFailed){
                FailedMBProgressHUD(self.view, StringForKeyInUnserializedJSONDic(response.responseObject, KDataKeyMsg));
            }else{
                FailedMBProgressHUD(self.view, @"请稍后重试！");
            }
        });
    }];
}
@end
