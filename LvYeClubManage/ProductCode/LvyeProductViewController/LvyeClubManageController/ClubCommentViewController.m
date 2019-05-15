//
//  ClubCommentViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/13.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "ClubCommentViewController.h"
#import "LvYeHTTPClient+ClubManage.h"
#import "LvYeHTTPClient.h"
#import "ClubTourCommentCell.h"
#import "DataPage.h"

#import "TourCommentDetailController.h"

@interface ClubCommentViewController ()<UITableViewDelegate,UITableViewDataSource>

/*!
 * @property
 * @brief 数据内容
 */
@property (nonatomic ,  strong)      DataPage                      *dataSource;
@property (nonatomic, weak)     UITableView                         *tableView;
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;  //请求列表数据的操作
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;
@end

@implementation ClubCommentViewController


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
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//
//    [KShareHTTPLvyeHTTPClient userClubCommentListInfoWithClubId:KLvyeClubCurrentUser.clubId pageSize:15 pageNumber:1 completion:^(WebAPIResponse *response) {
//
//
//        dispatch_async(dispatch_get_main_queue(), ^(void){
//
//            if (response.code == WebAPIResponseCodeSuccess) {
//                NSLog(@"responseObject is \n %@",response.responseObject);
//            }
//        });
//    }];
    
    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


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
    self.requestDataOperation=[KShareHTTPLvyeHTTPClient userClubCommentListInfoWithClubId:KLvyeClubCurrentUser.clubId pageSize:self.dataSource.pageSize pageNumber:self.dataSource.nextPageIndex completion:^(WebAPIResponse *response)  {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (weakSelf.tableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf tableView]);
                
                [weakSelf.tableView.pullToRefreshView stopAnimating];
            }
            if (response.code == WebAPIResponseCodeSuccess) {
                if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]){

                    NSDictionary *dataDictionary =(NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);

                    if([dataDictionary count]>0){
                        
                        if ([ObjForKeyInUnserializedJSONDic(dataDictionary, KDataKeyList) isKindOfClass:[NSArray class]]) {
                            NSArray *dataArray =(NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, KDataKeyList);
                            
                            NSMutableArray  *mutableArray =[NSMutableArray array];
                            
                            for (NSDictionary *moduleDic in dataArray) {
                                [mutableArray addObject:moduleDic];
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
    ClubTourCommentCell *CommentCell = [[ClubTourCommentCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
    return CommentCell;
    
}


#pragma mark UITableViewDelegate
- (BOOL)_isLoadMoreCellAtIndexPath:(NSIndexPath *)indexPath{
    
    return (indexPath.row == [self.dataSource count]);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    if([self _isLoadMoreCellAtIndexPath:indexPath]) {
        return kSizeLoadMoreCellHeight;
    }
    return KClubTourCommentCellHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    ClubTourCommentCell *departmenCell=(ClubTourCommentCell *)cell;
    NSDictionary *info=(NSDictionary *)[self.dataSource.data objectAtIndex:indexPath.row];
    [departmenCell fillClubTourCommentTableCellDataSourceWithTourBasicInfo:info];
    
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

    NSLog(@"selected info is \n%@",info);
    
    TourCommentDetailController *viewController = [[TourCommentDetailController alloc]initWithTourCommentInfo:info];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
