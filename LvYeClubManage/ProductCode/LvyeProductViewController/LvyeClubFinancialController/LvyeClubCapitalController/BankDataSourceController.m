//
//  BankDataSourceController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "BankDataSourceController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubFinance.h"
#import "BankDataTableViewCell.h"
#import "DataPage.h"

@interface BankDataSourceController ()<UITableViewDelegate,UITableViewDataSource>
/*!
 * @property
 * @brief 操作协议
 */
@property (nonatomic ,  assign)      id<UserSelectedBankSourceDelegate>         delegate;

/*!
 * @property
 * @brief 数据内容
 */
@property (nonatomic ,  strong)      DataPage                      *dataSource;
@property (nonatomic, weak)     UITableView                         *tableView;
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;  //请求列表数据的操作
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;
@end

@implementation BankDataSourceController

#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {

    }
    return self;
}

- (instancetype)initWithDelegate:(id<UserSelectedBankSourceDelegate>)delegate{
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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


- (void)refreshListData
{
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    //清空当前数据源中所有数据
    [self.dataSource cleanAllData];
    [self.tableView reloadData];
    [self loadMoreListData];
}


- (void)userSelectedBankOperation:(UIButtonCell *)button{
    
    
    if(!IsStringEmptyOrNull(button.btnItemInfoContent)){
        BankInfo *itemBankInfo = [[BankInfo alloc]init];
        [itemBankInfo setBankSourceId:button.btnItemInfoId];
        [itemBankInfo setBankInfoId:button.btnItemInfoId];
        [itemBankInfo setBankSourceName:button.btnItemInfoContent];
        
        if (self.delegate) {
            if ([self.delegate respondsToSelector:@selector(userPersonalSelectedOperation:)]) {
                [self.delegate userPersonalSelectedOperation:itemBankInfo];
                [self.navigationController popViewControllerAnimated:YES];
            }
        }
        
    }
}


- (void)loadMoreListData{
    
    __weak __typeof(&*self)weakSelf = self;
    self.requestDataOperation=[KShareHTTPLvyeHTTPClient clubCanConnectBankInfoCompletion:^(WebAPIResponse *response) {
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
                    for (NSDictionary *moduleDic in dataArray) {
                        BankInfo *bankInfor = [BankInfo initBankInfoWithUnserializedJSONDic:moduleDic];
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
    
    NSLog(@" [self.dataSource count] is %ld", [self.dataSource count]);
    return [self.dataSource count] + 1;
}


- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier{
    
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
        return CreateLoadMoreCell();
    BankDataTableViewCell *merchantCell = [[BankDataTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    return merchantCell;
    
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
    return KBtnForRegisterOrLoginButtonHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    BankDataTableViewCell *bankCell=(BankDataTableViewCell *)cell;
    BankInfo *info=[self.dataSource.data objectAtIndex:indexPath.row];
    [bankCell fillDataInfoWithBankInfo:info];
    
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
   BankInfo *info=[self.dataSource.data objectAtIndex:indexPath.row];
    if (self.delegate) {
        if ([self.delegate respondsToSelector:@selector(userPersonalSelectedOperation:)]) {
            [self.delegate userPersonalSelectedOperation:info];
            [self.navigationController popViewControllerAnimated:YES];
        }
    }
}

@end
