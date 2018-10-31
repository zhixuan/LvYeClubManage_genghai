//
//  ClubDepartmentViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubDepartmentViewController.h"
#import "ClubAddDepartmentViewController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+CLubInfo.h"

#import "DepartmenUserTableCell.h"
#import "DataPage.h"


@interface ClubDepartmentViewController ()<UITableViewDelegate,UITableViewDataSource,ClubAddDepartmentDelegate>


/*!
 * @property
 * @brief 操作控制协议
 */
@property (nonatomic ,  assign)      id<ClubDepartmentSelectDelegate>           delegate;
/*!
 * @property
 * @brief 数据内容
 */
@property (nonatomic ,  strong)      DataPage                      *dataSource;
@property (nonatomic, weak)     UITableView                         *tableView;
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;  //请求列表数据的操作
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;
@end

@implementation ClubDepartmentViewController
#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
         self.dataSource = [DataPage page];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<ClubDepartmentSelectDelegate>) delegate{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.delegate = delegate;
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
    
    [self setRightNavButtonTitleStr:@"新建" withFrame: kNavBarButtonRect actionTarget:self action:@selector(setRightButtonEventClicked)];
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


- (void)refreshListData
{
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    //清空当前数据源中所有数据
    [self.dataSource cleanAllData];
    [self.tableView reloadData];
    [self loadMoreListData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setRightButtonEventClicked{
    ClubAddDepartmentViewController * viewController = [[ClubAddDepartmentViewController alloc]initWithDelegate:self];
    [viewController setTitle:@"新建部门"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)loadMoreListData{
    
    __weak __typeof(&*self)weakSelf = self;
    self.requestDataOperation=[KShareHTTPLvyeHTTPClient clubAccountManageGetDepartmentListsWithClubId:KLvyeClubCurrentUser.clubId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (weakSelf.tableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf tableView]);
                
                [weakSelf.tableView.pullToRefreshView stopAnimating];
            }
            
            if (response.code == WebAPIResponseCodeSuccess) {
                
                if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSArray class]]){
                    NSArray *dataArray =(NSArray *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    NSLog(@"ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) is %@", ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData));
                    [weakSelf.dataSource appendPage:dataArray];
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
    DepartmenUserTableCell *departmenCell = [[DepartmenUserTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    return departmenCell;
    
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
    return KDepartmenUserTableCellHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    DepartmenUserTableCell *departmenCell=(DepartmenUserTableCell *)cell;
    NSDictionary *info=(NSDictionary *)[self.dataSource.data objectAtIndex:indexPath.row];
    [departmenCell fillDataInfoForCellWithClubDepartmenDataSource:info];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString *cellIdentifier=@"FocusListCell";
    
    
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
    NSDictionary *info=(NSDictionary *)[self.dataSource.data objectAtIndex:indexPath.row];
    
    if(self.delegate){
        if ([self.delegate respondsToSelector:@selector(userSelectedClubDepartmentFinishOperation:)]) {
            [self.delegate userSelectedClubDepartmentFinishOperation:info];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
    
}


- (void)userAddClubAddDepartmentOperationSuccessful{
    [self refreshListData];
}

@end
