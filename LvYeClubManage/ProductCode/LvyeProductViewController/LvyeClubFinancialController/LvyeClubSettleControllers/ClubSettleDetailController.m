//
//  ClubSettleDetailController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/29.
//  Copyright © 2018年 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "ClubSettleDetailController.h"
#import "DataPage.h"
#import "ClubWithdrawController.h"
#import "LvYeHTTPClient.h"
#import "LvYeHTTPClient+ClubFinance.h"
#import "ClubBillRecordCell.h"
#import "ClubSettleTableCell.h"
#import "ClubOrderDetailController.h"

@interface ClubSettleDetailController ()<UITableViewDataSource,UITableViewDelegate>
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
 * @brief 账单信息总述
 */
@property (nonatomic , strong)      ClubFinanceCapitalRecod     *clubFinanceCapitalRecodInfo;
/*!
 * @property
 * @brief 结算单号
 */
@property (nonatomic , strong)      NSString            *billCheckNumber;


/*!
 * @property
 * @brief 头部视图内容
 */
@property (nonatomic ,  weak)      UIView               *clubSettleDetailHeaderView;
@end

@implementation ClubSettleDetailController

#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.clubFinanceCapitalRecodInfo = [[ClubFinanceCapitalRecod alloc]init];
    }
    return self;
}


- (instancetype)initWithBillCheckNumber:(NSString *)checkNum{
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.billCheckNumber = [[NSString alloc]initWithFormat:@"%@",checkNum];
    }
    return self;
}


- (instancetype)initWithClubFinanceCapitalRecord:(ClubFinanceCapitalRecod *)record{
    
    self = [super init];
    if (self) {
        self.dataSource = [DataPage page];
        self.clubFinanceCapitalRecodInfo = record;
        self.billCheckNumber = [[NSString alloc]initWithFormat:@"%@",record.capitalRecodNumber];
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

    
    UITableView* tbView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
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
    self.requestDataOperation =[KShareHTTPLvyeHTTPClient clubShowClubBillSettleDetailWithBillNum:self.billCheckNumber clubId:KLvyeClubCurrentUser.clubId completion:^(WebAPIResponse *response) {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (weakSelf.tableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf tableView]);
                
                [weakSelf.tableView.pullToRefreshView stopAnimating];
            }
            if (response.code == WebAPIResponseCodeSuccess) {
                if ([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]) {
                    NSDictionary *dataDic =ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    if ([ObjForKeyInUnserializedJSONDic(dataDic, @"itemBillCheck") isKindOfClass:[NSDictionary class]]) {
                        NSDictionary *itemData = (NSDictionary *)ObjForKeyInUnserializedJSONDic(dataDic, @"itemBillCheck");
                        weakSelf.clubFinanceCapitalRecodInfo = [ClubFinanceCapitalRecod initClubFinanceCapitalRecodForSettleUpListWithUnserializedJSONDic:itemData];
                    }
                    
                    if ([ObjForKeyInUnserializedJSONDic(dataDic, @"orderList") isKindOfClass:[NSArray class]]) {
                        
                        NSArray *dataArray =(NSArray *)ObjForKeyInUnserializedJSONDic(dataDic, @"orderList");
                        
                        NSMutableArray  *mutableArray =[NSMutableArray array];
                        for (NSDictionary *moduleDic in dataArray) {
                            ClubFinanceCapitalRecod *bankInfor = [ClubFinanceCapitalRecod initClubFinanceUserOrderInfoWithWithUnserializedJSONDic:moduleDic];
                            [mutableArray addObject:bankInfor];
                        }
                        [weakSelf.dataSource appendPage:mutableArray];
                    }
                    
                    
                    [weakSelf.tableView reloadData];
                }else {
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
            }else {
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
    ClubBillRecordCell *bankCell = [[ClubBillRecordCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
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
    return KClubBillRecordCellHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ClubBillRecordCell *recordCell=(ClubBillRecordCell *)cell;
    ClubFinanceCapitalRecod *info=(ClubFinanceCapitalRecod*)[self.dataSource.data objectAtIndex:indexPath.row];
    [recordCell fillClubBillRecordShowTableCellDataSourceWithClubFinanceCapitalRecod:info];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    
    NSString *cellIdentifier=@"ClubBillRecordCell";
    
    
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
    ClubOrderDetailController *viewController = [[ClubOrderDetailController alloc]initWithOrderInfo:(ClubOrderInfo *)info];
    [viewController setTitle:@"详情"];
    [self.navigationController pushViewController:viewController animated:YES];
}



- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *recordCell = [[UIView alloc]init];
    [recordCell setFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KClubSettleTableCellHeight+44.0f) ];
    [recordCell setBackgroundColor:[UIColor clearColor]];
    self.clubSettleDetailHeaderView =recordCell;
    UIView *contentBackGroudView = [[UIView alloc]init];
    [contentBackGroudView setBackgroundColor:[UIColor whiteColor]];
    [contentBackGroudView.layer setCornerRadius:2.0f];
    [contentBackGroudView.layer setMasksToBounds:YES];
    [contentBackGroudView setFrame:CGRectMake(0.0f, KInforLeftIntervalWidth,
                                              (KProjectScreenWidth),
                                              (KClubSettleTableCellHeight+44.0f - KInforLeftIntervalWidth))];
    
    [recordCell addSubview:contentBackGroudView];
    
    
    UILabel  *orderNumber = [[UILabel alloc]init];
    [orderNumber setBackgroundColor:[UIColor clearColor]];
    [orderNumber setFont:[UIFont boldSystemFontOfSize:(18*KLVYEAdapterSizeWidth)]];
    [orderNumber setTextColor:KContentTextColor];
    [contentBackGroudView addSubview:orderNumber];
    
    
    UILabel  *recodAddDate = [[UILabel alloc]init];
    [recodAddDate setBackgroundColor:[UIColor clearColor]];
    [recodAddDate setTextAlignment:NSTextAlignmentRight];
    [recodAddDate setFont:[UIFont systemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
    [recodAddDate setTextColor:KContentTextColor];
    [contentBackGroudView addSubview:recodAddDate ];
    
    
    UILabel  *recodResultMoney = [[UILabel alloc]init];
    [recodResultMoney setBackgroundColor:[UIColor clearColor]];
    [recodResultMoney setTextAlignment:NSTextAlignmentLeft];
    [recodResultMoney setFont:[UIFont systemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
    [recodResultMoney setTextColor:KContentTextColor];
    [contentBackGroudView addSubview:recodResultMoney];
    
    UILabel  *recodStatus = [[UILabel alloc]init];
    [recodStatus setBackgroundColor:[UIColor clearColor]];
    [recodStatus setTextAlignment:NSTextAlignmentRight];
    [recodStatus setFont:[UIFont boldSystemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
    [recodStatus setTextColor:[UIColor redColor]];
    [contentBackGroudView addSubview:recodStatus];
    
    
    UILabel  *recodOrderCount = [[UILabel alloc]init];
    [recodOrderCount setBackgroundColor:[UIColor clearColor]];
    [recodOrderCount setTextAlignment:NSTextAlignmentRight];
    [recodOrderCount setFont:[UIFont systemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
    [recodOrderCount setTextColor:KContentTextColor];
    [contentBackGroudView addSubview:recodOrderCount ];
    
    UILabel  *recodPeople = [[UILabel alloc]init];
    [recodPeople setBackgroundColor:[UIColor clearColor]];
    [recodPeople setTextAlignment:NSTextAlignmentLeft];
    [recodPeople setFont:[UIFont systemFontOfSize:(14*KLVYEAdapterSizeWidth)]];
    [recodPeople setTextColor:KContentTextColor];
    [contentBackGroudView addSubview:recodPeople ];
    
    
    
    [orderNumber setText:self.clubFinanceCapitalRecodInfo.capitalRecodNumber];
    
    
    [recodAddDate setText:self.clubFinanceCapitalRecodInfo.capitalAddTimeStr];
    
    
    
    if (self.clubFinanceCapitalRecodInfo.capitalBillCheckStateType ==1) {
        [recodStatus setText:@"未结算"];
    } else if (self.clubFinanceCapitalRecodInfo.capitalBillCheckStateType ==2) {
        [recodStatus setText:@"申请中"];
    } else if (self.clubFinanceCapitalRecodInfo.capitalBillCheckStateType ==3) {
        [recodStatus setText:@"已结算"];
    }
    
    
    NSString *resultContentStr = [NSString stringWithFormat:@"余额: ¥%@",self.clubFinanceCapitalRecodInfo.capitalMoneyCotnent];
    NSMutableAttributedString *resultAttributedString = [[NSMutableAttributedString alloc] initWithString:resultContentStr];
    NSRange resultAttributeRange=[ resultContentStr rangeOfString: [NSString stringWithFormat:@"¥%@",self.clubFinanceCapitalRecodInfo.capitalMoneyCotnent]];
    [resultAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:resultAttributeRange];
    [resultAttributedString addAttribute:NSFontAttributeName
                                   value:[UIFont boldSystemFontOfSize:(17*KLVYEAdapterSizeWidth)]
                                   range:resultAttributeRange];
    recodResultMoney.attributedText= resultAttributedString;
    
    
    
    NSString *increaseContentStr = [NSString stringWithFormat:@"人 数： %ld人",self.clubFinanceCapitalRecodInfo.capitalOrderPeopleCount];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:increaseContentStr];
    NSRange attributeRange=[ increaseContentStr rangeOfString:[NSString stringWithFormat:@"%ld人",self.clubFinanceCapitalRecodInfo.capitalOrderPeopleCount]];
    [attributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:(18*KLVYEAdapterSizeWidth)] range:attributeRange];
    recodPeople.attributedText = attributedString;
    
    NSString *subtractContentStr = [NSString stringWithFormat:@"订单个数： %ld个",self.clubFinanceCapitalRecodInfo.capitalOrderCount];
    NSMutableAttributedString *subtractAttributedString = [[NSMutableAttributedString alloc] initWithString:subtractContentStr];
    NSRange subtractAttributeRange=[ subtractContentStr rangeOfString: [NSString stringWithFormat:@"%ld个",self.clubFinanceCapitalRecodInfo.capitalOrderCount]];
    [subtractAttributedString addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:(18*KLVYEAdapterSizeWidth)] range:subtractAttributeRange];
    recodOrderCount.attributedText= subtractAttributedString;
    
    
    [orderNumber setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,recordCell.width, KBtnCellHeight)];
    
    [recodStatus setFrame:CGRectMake(KInforLeftIntervalWidth, 0.0f,
                                     (recordCell.width -KInforLeftIntervalWidth*2), KBtnCellHeight)];
    
    
    [recodResultMoney setFrame:CGRectMake(KInforLeftIntervalWidth, KBtnCellHeight, (recordCell.width -KInforLeftIntervalWidth*2), KBtnCellHeight*0.7)];
    
    [recodAddDate setFrame:CGRectMake(KInforLeftIntervalWidth, KBtnCellHeight,
                                      (recordCell.width -KInforLeftIntervalWidth*2), KBtnCellHeight*0.7)];
    
    [recodPeople setFrame:CGRectMake(KInforLeftIntervalWidth, recodAddDate.bottom,
                                     (recordCell.width -KInforLeftIntervalWidth*2)/2, KBtnCellHeight*0.7)];
    
    [recodOrderCount setFrame:CGRectMake(recodPeople.right, recodAddDate.bottom,
                                         (recordCell.width -KInforLeftIntervalWidth*2)/2, KBtnCellHeight*0.7)];
    
    
    
    UILabel *nextLabel = [FontAwesome labelWithFAIcon:FMIconFontF103 size:33.0f color:KButtonStateNormalColor];
    [nextLabel setBackgroundColor:[UIColor clearColor]];
    [nextLabel setFrame:CGRectMake((contentBackGroudView.width - 33.0f)/2.0f, recodOrderCount.bottom+5.5f, 33.0f, 33.0f)];
    
    [contentBackGroudView addSubview:nextLabel ];
    
    return recordCell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return KClubSettleTableCellHeight+44.0f;
}

@end
