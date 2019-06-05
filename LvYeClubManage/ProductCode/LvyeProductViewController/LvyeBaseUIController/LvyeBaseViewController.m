//
//  LvyeBaseViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/17.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseViewController.h"

//#define KButtonTextColor                   [UIColor colorWithRed:255.0f/255.0f green:255.0f/255.0f blue:255.0f/255.0f alpha:1.0f]

#define KButtonTextColor                        KButtonStateNormalColor
@interface LvyeBaseViewController ()

@end

@implementation LvyeBaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.enableCustomNavbarBackButton = YES;
        self.navButtonSize = KNavSize;
        
    }
    return self;
}


- (instancetype)initWithEnableDisplayOnTabBar{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = FALSE;
        self.navButtonSize = KNavSize;
    }
    return self;
}
- (instancetype)init{
    self = [super init];
    if (self) {
        self.enableCustomNavbarBackButton = TRUE;
        self.navButtonSize = KNavSize;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIScrollView * bgScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, self.view.height)];
    [bgScrollView setBackgroundColor:[UIColor clearColor]];
    [bgScrollView setShowsVerticalScrollIndicator:NO];
    [bgScrollView setUserInteractionEnabled:YES];

    [bgScrollView setContentSize:CGSizeMake(KProjectScreenWidth, (self.view.height + 20.0))];
    self.bgScrollView = bgScrollView;
    [self.view addSubview:self.bgScrollView];
    
    
    ///使其支持左滑操作，如果删除，则不再支持左滑取消操作；
    if(HUISystemVersionAboveOrIs(kHUISystemVersion_8_0)){
        self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
     }
//    NSNumericSearch
//     NSFoundationVersionNumber_iOS_7_1
//    NSOrderedAscending
    
   
//    [@"838" compare:<#(nonnull NSString *)#> options:<#(NSStringCompareOptions)#>];
//    NSLog(@"[[ UIDevice currentDevice] systemVersion] %@",[[ UIDevice currentDevice] systemVersion]);
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                                           action:@selector(finishEditOperation) ];
    [self.bgScrollView addGestureRecognizer:tapGestureRecognizer];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




/**
 关闭所有可编辑位置的键盘操作
 */
- (void)finishEditOperation{
    [self.view endEditing:YES];
}


- (void)settingNavTitle:(NSString *)title{
    CGRect rcTileView = CGRectMake(110, 0, (KProjectScreenWidth - 110.0*2), 44);
    
    UILabel *titleTextLabel = [[UILabel alloc] initWithFrame: rcTileView];
    titleTextLabel.backgroundColor = [UIColor clearColor];
    [titleTextLabel setTextAlignment:NSTextAlignmentCenter];
    titleTextLabel.textColor = KButtonStateNormalColor;
    [titleTextLabel setFont:KLVYEUIContentFontSize(18.0f)];
    [titleTextLabel setText:title];
    self.navigationItem.titleView = titleTextLabel;
}

- (void)settingNavTitle:(NSString *)title color:(UIColor *)color{
    
    
    CGRect rcTileView = CGRectMake(110, 0, (KProjectScreenWidth - 110.0*2), 44);
    
    UILabel *titleTextLabel = [[UILabel alloc] initWithFrame: rcTileView];
    titleTextLabel.backgroundColor = [UIColor clearColor];
    [titleTextLabel setTextAlignment:NSTextAlignmentCenter];
    titleTextLabel.textColor = [UIColor blackColor];
    titleTextLabel.textColor = color;

    [titleTextLabel setFont:KLVYEUIContentFontSize(18.0f)];
    [titleTextLabel setText:title];
    self.navigationItem.titleView = titleTextLabel;
    
}

- (void) setLeftNavButtonFA:(NSInteger)buttonType withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = [UIFont systemFontOfSize:self.navButtonSize];
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [navButton simpleButtonWithImageColor:KButtonTextColor withHighlightedColor:KButtonTextHighlightedColor];
    [navButton addAwesomeIcon:buttonType beforeTitle:YES];
    
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    navButton.contentEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
    self.navigationItem.leftBarButtonItem = navItem;
}
- (void) setLeftNavButton:(UIImage* )btImage withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    [navButton setImage:btImage forState:UIControlStateNormal];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    negativeSpacer.width = -6;
        [self.navigationItem setLeftBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, navItem, nil] animated:NO];
}

- (void)setLeftNavButtonTitleStr:(NSString *)titleStr withFrame:(CGRect)frame actionTarget:(id)target action:(SEL)action{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = KLVYEUIContentFontSize(16.0f);
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentLeft;
    [navButton setTitle:titleStr forState:UIControlStateNormal];
    [navButton setTitleColor:KButtonTextColor forState:UIControlStateNormal];
    [navButton setTitleColor:KButtonTextHighlightedColor
                    forState:UIControlStateHighlighted];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    
    navButton.contentEdgeInsets = UIEdgeInsetsMake(0, -6, 0, 0);
    self.navigationItem.leftBarButtonItem = navItem;
    
}

- (void) setRightNavButton:(UIImage* )btImage withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    [navButton setImage:btImage forState:UIControlStateNormal];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    [navItem.customView setFrame:frame];
        UIBarButtonItem *negativeSpacer = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
        negativeSpacer.width = -6;
        [self.navigationItem setRightBarButtonItems:[NSArray arrayWithObjects:negativeSpacer, navItem, nil] animated:NO];
    
}

- (void)setRightNavButtonFA:(NSInteger)buttonType withFrame:(CGRect) frame actionTarget:(id)target action:(SEL) action
{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = [UIFont systemFontOfSize:self.navButtonSize];
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [navButton simpleButtonWithImageColor:KButtonTextColor withHighlightedColor:KButtonTextHighlightedColor];
    [navButton addAwesomeIcon:buttonType beforeTitle:YES];
    
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    self.navigationItem.rightBarButtonItem = navItem;
}

- (void)setRightNavButtonTitleStr:(NSString *)titleStr withFrame:(CGRect)frame actionTarget:(id)target action:(SEL)action{
    if (target == nil && action == nil)
        return;
    
    UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [navButton setFrame:frame];
    navButton.titleLabel.font = KLVYEUIContentFontSize(16.0f);
    navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
    [navButton setTitle:titleStr forState:UIControlStateNormal];
    [navButton setTitleColor:KButtonTextColor forState:UIControlStateNormal];
    [navButton setTitleColor:KButtonTextHighlightedColor
                    forState:UIControlStateHighlighted];
    [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:navButton];
    navButton.contentEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 4);
    self.navigationItem.rightBarButtonItem = navItem;
    
}


- (void)setEnableCustomNavbarBackButton:(BOOL)enableCustomNavbarBackButton
{
    _enableCustomNavbarBackButton = enableCustomNavbarBackButton;
    if (!_enableCustomNavbarBackButton){
        self.navigationItem.leftBarButtonItems = nil;
    }else{
        [self setLeftNavButtonFA:FMIconFontF053 withFrame:CGRectMake(0.0f, 0.0f, 55.0f, 44.0f)
                    actionTarget:self action:@selector(_backToPrevController)];
    }
    
}

- (void)setRightNavButtonFA:(NSArray <NSNumber *> *)buttonTypeArray
                  buttonTag:(NSArray <NSNumber *> *)tagArray
        buttonSelectedColor:(NSArray <UIColor *> *)colorArray
          buttonDefautColor:(NSArray <UIColor *> *)colorDefaultArray
               actionTarget:(id)target
                     action:(SEL)action{
    
    
    NSInteger buttonTypeInt = buttonTypeArray.count;
    if (buttonTypeInt != tagArray.count) {
        return;
    }
    
    //    CGRectMake(0, 0.0f, 55, 44.0f)    //左右侧导航栏按钮大小
    UIView *buttonBGView = [[UIView alloc]init];
    for (int index = 0; index <buttonTypeInt; index ++) {
        UIButton *navButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [navButton setFrame:CGRectMake(index*38, 0.0f, 38.0f, 44.0f)];
        navButton.titleLabel.font = [UIFont systemFontOfSize:16.0f];
        navButton.contentHorizontalAlignment=UIControlContentHorizontalAlignmentRight;
        [navButton simpleButtonWithImageColor:(UIColor *)[colorArray objectAtIndex:index]];
        [navButton addAwesomeIcon:[buttonTypeArray[index] integerValue] beforeTitle:YES];
        [navButton setTag:[tagArray[index] integerValue]];
        [navButton addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
        [buttonBGView addSubview:navButton];
    }
    [buttonBGView setFrame:CGRectMake(0.0f, 0.0f, buttonTypeInt*38, 44.0f)];
    UIBarButtonItem *navItem = [[UIBarButtonItem alloc] initWithCustomView:buttonBGView];
    
    self.navigationItem.rightBarButtonItem = navItem;
    
}

- (void)_backToPrevController
{
    if (self.navBackButtonRespondBlock)
    {
        self.navBackButtonRespondBlock();
        return;
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

@end
