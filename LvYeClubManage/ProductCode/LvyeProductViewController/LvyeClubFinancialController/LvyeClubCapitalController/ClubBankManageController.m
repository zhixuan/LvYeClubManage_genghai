//
//  ClubBankManageController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubBankManageController.h"
#import "ClubBankAddController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubFinance.h"
#import "ClubBankTableViewCell.h"
#import "DataPage.h"

@interface ClubBankManageController ()<ClubUserAddBandDelegate,UITableViewDelegate,UITableViewDataSource>


/*!
 * @property
 * @brief 用户选择的操作协议
 */
@property (nonatomic ,  assign)      id<ClubSelectedBankDelegate>           delegate;
/*!
 * @property
 * @brief 数据内容
 */
@property (nonatomic ,  strong)      DataPage                           *dataSource;
@property (nonatomic, weak)     UITableView                             *tableView;
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;  //请求列表数据的操作
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;
@end



@implementation ClubBankManageController

#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
    }
    return self;
}

- (instancetype)initWithDelegate:(id<ClubSelectedBankDelegate>)delegate{
    self = [super init];
    if (self) {
        self.delegate = delegate;
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
    
    [self setRightNavButtonTitleStr:@"添加" withFrame: kNavBarButtonRect
                       actionTarget:self action:@selector(userRightBarButtonAddBankOperation)];
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

    self.requestDataOperation=[KShareHTTPLvyeHTTPClient  clubConnectedBankInfoWithClubId:KLvyeClubCurrentUser.clubId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (weakSelf.tableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf tableView]);
                
                [weakSelf.tableView.pullToRefreshView stopAnimating];
            }
            
            if (response.code == WebAPIResponseCodeSuccess) {
                
                if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSArray class]]){
                    NSArray *dataArray =(NSArray *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    NSMutableArray  *mutableArray =[NSMutableArray array];
                    NSInteger Index = 0;
                    for (NSDictionary *moduleDic in dataArray) {
                        NSLog(@"%ldmoduleDic is %@",(Index+1), moduleDic);
                        ClubBankInfo *bankInfor = [ClubBankInfo initClubBankInfoWithUnserializedJSONDic:moduleDic];
                        [mutableArray addObject:bankInfor];
                    }
                    [weakSelf.dataSource appendPage:mutableArray];
                    //页数
                    NSNumber* pages = (NSNumber*)ObjForKeyInUnserializedJSONDic(response.responseObject,@"totalPage");
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
    
    NSLog(@" [self.dataSource count] is %ld", [self.dataSource count]);
    return [self.dataSource count] + 1;
}


- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier{
    
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
        return CreateLoadMoreCell();
    ClubBankTableViewCell *bankCell = [[ClubBankTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    
    UILongPressGestureRecognizer *gestureRec = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(cellLongPress:)];
    [gestureRec setMinimumPressDuration:1.0f];
    [bankCell addGestureRecognizer:gestureRec];
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
    return KClubBankTableViewCellHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ClubBankTableViewCell *bankCell=(ClubBankTableViewCell *)cell;
    ClubBankInfo *info=(ClubBankInfo*)[self.dataSource.data objectAtIndex:indexPath.row];
    [bankCell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [bankCell fillClubBankInfo:info];
    
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
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ClubBankInfo *info=(ClubBankInfo*)[self.dataSource.data objectAtIndex:indexPath.row];
    
    if (info.clubBankAccounStyle == ClubBankPublicStyle) {
        if(self.delegate){
            if ([self.delegate respondsToSelector:@selector(userPersonalSelectedBank:)]) {
                [self.delegate userPersonalSelectedBank:info];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
    }else{
        ShowImportErrorAlertControl(@"当前禁止个人账户提现！",self);
    }
    
    
}


- (void)userRightBarButtonAddBankOperation{
    
    
    ClubBankAddController  *viewController = [[ClubBankAddController alloc]initWithDelegate:self];
    [viewController setTitle:@"添加"];
    [viewController setHidesBottomBarWhenPushed:YES];
    [self.navigationController pushViewController:viewController animated:YES];
}

- (void)clubUserAddClubBandOperation:(BOOL)finish{
    
    if (finish) {
        
    }
}


-(void)cellLongPress:(UILongPressGestureRecognizer *)longRecognizer{
    
    if (longRecognizer.state==UIGestureRecognizerStateBegan) {
        //成为第一响应者，需重写该方法
        [self becomeFirstResponder];
        
        CGPoint location = [longRecognizer locationInView:self.tableView];
        NSIndexPath * indexPath = [self.tableView indexPathForRowAtPoint:location];
        NSLog(@"indexPath.row is %ld",indexPath.row);
    }
}


@end
