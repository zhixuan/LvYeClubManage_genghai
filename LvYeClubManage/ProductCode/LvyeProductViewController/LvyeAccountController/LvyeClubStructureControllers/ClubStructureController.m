//
//  ClubStructureController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/16.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubStructureController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+CLubInfo.h"
#import "DepartmenUserTableCell.h"
#import "ClubAddAdministratorController.h"
#import "DataPage.h"


@interface ClubStructureController ()<UITableViewDelegate,UITableViewDataSource>


/*!
 * @property
 * @brief 数据内容
 */
@property (nonatomic ,  strong)      DataPage                           *dataSource;
@property (nonatomic, weak)     UITableView                             *tableView;
//请求列表数据的操作
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;


/*!
 * @property
 * @brief 部门头部信息
 */
@property (nonatomic , strong)      NSMutableArray                      *clubDepartmentNameArray;

/*!
 * @property
 * @brief 用户信息数据
 */
@property (nonatomic , strong)      NSMutableArray                      *clubDepartmentUserArray;
@end

@implementation ClubStructureController


#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.clubDepartmentUserArray = [[NSMutableArray alloc]init];
    self.clubDepartmentNameArray = [[NSMutableArray alloc]init];
    
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
    
    
    [self setRightNavButtonTitleStr:@"添加管理员" withFrame: kNavBarButtonRect actionTarget:self action:@selector(setRightButtonEventClicked)];
}


- (void)setRightButtonEventClicked{
    ClubAddAdministratorController *viewController = [[ClubAddAdministratorController alloc]init];
    [viewController setTitle:@"添加管理员"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];

}

- (void)refreshListData
{
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    [self.clubDepartmentNameArray removeAllObjects];
    [self.clubDepartmentUserArray removeAllObjects];
    //清空当前数据源中所有数据
    [self.dataSource cleanAllData];
    [self.tableView reloadData];
    [self loadMoreListData];
}



- (void)loadMoreListData{
    
    __weak __typeof(&*self)weakSelf = self;
    
    self.requestDataOperation= [KShareHTTPLvyeHTTPClient clubAccountManageGetDepartmentUsersWithClubId:KLvyeClubCurrentUser.clubId completion:^(WebAPIResponse *response) {
        
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (weakSelf.tableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf tableView]);
                
                [weakSelf.tableView.pullToRefreshView stopAnimating];
            }
            
            if (response.code == WebAPIResponseCodeSuccess) {

                if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]){
                    
                    
                    
                    NSDictionary *dataDictionary =(NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    NSLog(@"dataDictionary is %@",dataDictionary);
                    
                    if([dataDictionary count]>0){
                        NSArray *allKeyArray =[dataDictionary allKeys];
                         [weakSelf.clubDepartmentNameArray addObjectsFromArray:allKeyArray];
                        
                        NSArray *allValuesArray = [dataDictionary allValues];
                        [weakSelf.clubDepartmentUserArray addObjectsFromArray:allValuesArray];
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
    return [self.clubDepartmentNameArray count];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if ([self.clubDepartmentUserArray count] >0) {
        NSArray *itemDepartmentUserArray = (NSArray *)[self.clubDepartmentUserArray objectAtIndex:section];
        if((section +1) == [self.clubDepartmentNameArray count] ){
            return [itemDepartmentUserArray count] + 1;
        }else{
           return  [itemDepartmentUserArray count];
        }
    }else{
        return 0;
    }
    return 0;
}


- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier{
    
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
        return CreateLoadMoreCell();
    DepartmenUserTableCell *userCell = [[DepartmenUserTableCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    return userCell;
    
}

#pragma mark UITableViewDelegate
- (BOOL)_isLoadMoreCellAtIndexPath:(NSIndexPath *)indexPath
{
//    return (indexPath.row == [self.dataSource count]);

    if((indexPath.section+1)== [self.clubDepartmentNameArray count]){
        NSArray *itemDepartmentUserArray = (NSArray *)[self.clubDepartmentUserArray objectAtIndex:indexPath.section];
        if(indexPath.row == [itemDepartmentUserArray count]){
            return YES;
        }else{
            return NO;
        }
    }else{
        return NO;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if([self _isLoadMoreCellAtIndexPath:indexPath]) {
        return kSizeLoadMoreCellHeight;
    }
    return KDepartmenUserTableCellHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([self.clubDepartmentUserArray count] >0) {
        NSArray *itemDepartmentUserArray = (NSArray *)[self.clubDepartmentUserArray objectAtIndex:indexPath.section];
        if((indexPath.section +1) == [self.clubDepartmentNameArray count] ){
            if(indexPath.row == [itemDepartmentUserArray count]){
                return;
            }
        }
    }
    DepartmenUserTableCell *userCell=(DepartmenUserTableCell *)cell;
    if ([self.clubDepartmentUserArray count] >0) {
        NSArray *itemDepartmentUserArray = (NSArray *)[self.clubDepartmentUserArray objectAtIndex:indexPath.section];
        if(indexPath.row < [itemDepartmentUserArray count]){
            NSDictionary *dataInfo = (NSDictionary *)[itemDepartmentUserArray objectAtIndex:indexPath.row];
            [userCell fillDataInforForCellWithUserDataSource:dataInfo];
        }
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString *cellIdentifier=@"DepartmenUserTableCell";
    
    
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
    
    
    if ([self.clubDepartmentUserArray count] >0) {
        NSArray *itemDepartmentUserArray = (NSArray *)[self.clubDepartmentUserArray objectAtIndex:indexPath.section];
        if((indexPath.section +1) == [self.clubDepartmentNameArray count] ){
            if(indexPath.row == [itemDepartmentUserArray count]){
                return;
            }
        }
    }
    if ([self.clubDepartmentUserArray count] >0) {
        NSArray *itemDepartmentUserArray = (NSArray *)[self.clubDepartmentUserArray objectAtIndex:indexPath.section];
        if(indexPath.row < [itemDepartmentUserArray count]){
            NSDictionary *dataInfo = (NSDictionary *)[itemDepartmentUserArray objectAtIndex:indexPath.row];
            ClubUserInfo *userInfo = [ClubUserInfo initClubUserInfoForDepartmenUserWithUnserializedJSONDic:dataInfo];
    
            NSLog(@"%@",[userInfo toStringPropertyExportString]);
            
//            if(!userInfo.userIsLock){
//
                ClubAddAdministratorController *viewController = [[ClubAddAdministratorController alloc]initWithUserInfo:userInfo];
                [viewController setTitle:@"编辑"];
                [viewController setHidesBottomBarWhenPushed:YES];
                [self.navigationController pushViewController:viewController animated:YES];
//            }
            
        }
    }
   
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *tvBGView = [[UIView alloc]init];
    [tvBGView setBackgroundColor:[UIColor colorWithRed:228.0f/255.0 green:228.0/255.0 blue:228.0/255.0 alpha:1.0]];
    [tvBGView setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, 30.0f)];
    
    UILabel *departmentNameLabel = [[UILabel alloc]init];
    [departmentNameLabel setBackgroundColor:[UIColor clearColor]];
    [departmentNameLabel setFrame:CGRectMake(KBtnContentLeftWidth, 0.0f,
                                             (KProjectScreenWidth - KBtnContentLeftWidth), 30.0f)];
    [departmentNameLabel setFont:KLVYEUIContentFontSize(15.0f)];
    if([self.clubDepartmentNameArray count] >0){
        [departmentNameLabel setText:[self.clubDepartmentNameArray objectAtIndex:section]];
    }
    
    [departmentNameLabel setTextColor:KContentTextColor];
    [departmentNameLabel setTextAlignment:NSTextAlignmentLeft];
    [tvBGView addSubview:departmentNameLabel];
    return tvBGView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 30.0f;
}

@end
