//
//  TourCommentDetailController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/5/10.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TourCommentDetailController.h"
#import "LvYeHTTPClient+ClubManage.h"
#import "LvYeHTTPClient.h"
#import "DataPage.h"

#import "CommentDetailCell.h"

@interface TourCommentDetailController ()<UITableViewDelegate,UITableViewDataSource>

/*!
 * @property
 * @brief 数据内容
 */
@property (nonatomic ,  strong)      DataPage                      *dataSource;
@property (nonatomic, weak)     UITableView                         *tableView;
@property (nonatomic, weak)     AFHTTPRequestOperation                  *requestDataOperation;  //请求列表数据的操作
@property (nonatomic,weak)      HUILoadMoreCell                         *loadMoreCell;
/*!
 * @property
 * @brief 线路评论信息内容
 */
@property (nonatomic , strong)      NSDictionary            *clubTourCommentInfo;
@end

@implementation TourCommentDetailController



- (instancetype)initWithTourCommentInfo:(NSDictionary *)info{
    self = [super init];
    if (self) {
        self.clubTourCommentInfo = [[NSDictionary alloc]initWithDictionary:info];
        self.dataSource = [DataPage page];
    }
    return self;
}

#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        self.clubTourCommentInfo = [[NSDictionary alloc]init];
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

    [self setTitle:@"详情信息"];
    
    
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
    
    
    /*
    NSLog(@" 星级 is %@",StringForKeyInUnserializedJSONDic(self.clubTourCommentInfo, @"scale"));
    
    
    
    CGFloat leftFloat  = KBtnContentLeftWidth ;
    for (int index = 1; index<6; index++) {
        
        UIColor *color =[UIColor redColor];
        if (index>3) {
            color = [UIColor yellowColor];
        }
        UIImage *rightImage = [FontAwesome imageWithIcon:FMIconFontF005 iconColor:color iconSize:25.0f imageSize:CGSizeMake(25.0f, 25.0f)];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setFrame:CGRectMake(leftFloat+index*(25+10), 130.0f, 25.0f, 25.0f)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setImage:rightImage];
        [self.view addSubview:imageView];
    }
    
    leftFloat  = KBtnContentLeftWidth ;
    for (int index = 1; index<6; index++) {
        
        
        FMIconFont defalut = FMIconFontF005;
        
        if (index>3) {
            defalut =FMIconFontF006;
        }
        
//        #f77911
//        UIImage *rightImage = [FontAwesome imageWithIcon:defalut iconColor:[UIColor yellowColor] iconSize:25.0f imageSize:CGSizeMake(25.0f, 25.0f)];
        
        
        
//         UIImage *rightImage = [FontAwesome imageWithIcon:defalut iconColor:HUIRGBHexColor(0xF77911,1.0) iconSize:25.0f imageSize:CGSizeMake(25.0f, 25.0f)];
         UIImage *rightImage = [FontAwesome imageWithIcon:defalut iconColor:HUIRGBColor(229.0f,83.0f,21.0f,1.0f) iconSize:25.0f imageSize:CGSizeMake(25.0f, 25.0f)];
        
        UIImageView *imageView = [[UIImageView alloc]init];
        [imageView setFrame:CGRectMake(leftFloat+index*(25+10), 170.0f, 25.0f, 25.0f)];
        [imageView setBackgroundColor:[UIColor clearColor]];
        [imageView setImage:rightImage];
        [self.view addSubview:imageView];
    }
     */
    
    
}



- (void)refreshListData{
    //停掉当前未完成的请求操作
    [self.requestDataOperation cancel];
    //清空当前数据源中所有数据
    [self.dataSource cleanAllData];
    [self.tableView reloadData];
    [self loadMoreListData];
}

- (void)loadMoreListData{
    
    __weak __typeof(&*self)weakSelf = self;
    
    self.requestDataOperation=[KShareHTTPLvyeHTTPClient userClubGetTourCommentDetailListWithCommentId:StringForKeyInUnserializedJSONDic(self.clubTourCommentInfo, @"comments_id")  completion:^(WebAPIResponse *response)  {
        dispatch_async(dispatch_get_main_queue(), ^(void){
            
            if (weakSelf.tableView.pullToRefreshView.state == SVPullToRefreshStateLoading)
            {
                UpdateLastRefreshDataForPullToRefreshViewOnView([weakSelf tableView]);
                
                [weakSelf.tableView.pullToRefreshView stopAnimating];
            }
            
            NSLog(@"dataDictionary is %@",response.responseObject);
            if (response.code == WebAPIResponseCodeSuccess) {
                if([ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData) isKindOfClass:[NSDictionary class]]){
                    
                    NSDictionary *dataDictionary =(NSDictionary *)ObjForKeyInUnserializedJSONDic(response.responseObject, KDataKeyData);
                    
                    
                    if([dataDictionary count]==2){
                        
                        if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"commentList") isKindOfClass:[NSArray class]]) {
                            NSArray *dataArray =(NSArray *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"commentList");
                            
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
                            if (weakSelf.loadMoreCell) {
                                [weakSelf.loadMoreCell stopLoadingAnimation];
                                if (response.code == WebAPIResponseCodeNetError) {
                                    weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADFAILD;
                                }else{
                                    weakSelf.loadMoreCell.textLabel.text = LOADMORE_LOADOVER;
                                }
                            }
                        }
                        
                        
                        if ([ObjForKeyInUnserializedJSONDic(dataDictionary, @"basicInfo") isKindOfClass:[NSDictionary class]]) {
                            weakSelf.clubTourCommentInfo =(NSDictionary *)ObjForKeyInUnserializedJSONDic(dataDictionary, @"basicInfo");
                            
                            NSLog(@"weakSelf.clubTourCommentInfo is %@",weakSelf.clubTourCommentInfo);
                            [weakSelf.tableView setTableHeaderView:nil];
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
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.dataSource count] + 1;
}


- (UITableViewCell *)createCellWithIdentifier:(NSString *)cellIdentifier{
    
    if ([cellIdentifier isEqualToString:kHUILoadMoreCellIdentifier])
        return CreateLoadMoreCell();
    
    CommentDetailCell *CommentCell = [[CommentDetailCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier];
//    [CommentCell setSelected:NO animated:NO];
    
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
    
    NSDictionary *info=(NSDictionary *)[self.dataSource.data objectAtIndex:indexPath.row];
    CGFloat contentHeight = 0.00;
    
    if(!IsStringEmptyOrNull(StringForKeyInUnserializedJSONDic(info, @"content"))){
        
        ///设置宽高限制。
        CGSize boundingSize = CGSizeMake((KProjectScreenWidth - KBtnContentLeftWidth*2), MAXFLOAT);
        
        NSDictionary *attDic =@{NSFontAttributeName:KCommentDetailContentFont,};
         CGRect contentRect =  [StringForKeyInUnserializedJSONDic(info, @"content") boundingRectWithSize:boundingSize options:NSStringDrawingUsesFontLeading|NSStringDrawingUsesLineFragmentOrigin attributes:attDic context:nil];
        ///内容+上下间距信息
        contentHeight = contentRect.size.height + 10.0f;
    }
   
    
    return KCommentDetailCellHeight + contentHeight;
}

- (void)_configureCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row >= [self.dataSource.data count]) {
        return;
    }
    CommentDetailCell *departmenCell=(CommentDetailCell *)cell;
    NSDictionary *info=(NSDictionary *)[self.dataSource.data objectAtIndex:indexPath.row];
    [departmenCell fildCommentDetailDataSourceWithTourCommentInfo: info];
    
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
    
}


@end
