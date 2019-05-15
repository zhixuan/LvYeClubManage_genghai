//
//  LvyeBaseWebViewController.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/4/9.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "LvyeBaseWebViewController.h"
#import <WebKit/WebKit.h>


#define KLvyeClubTourDetailURL [KEY_LVYE_API_URL stringByAppendingString:KURLClubItemTourDetailURL]
//#define KLvyeClubTourDetailURL [KEY_LVYE_API_URL stringByAppendingString:@"web/tour/tourDetailNew"]

@interface LvyeBaseWebViewController ()<WKUIDelegate,WKNavigationDelegate,WKScriptMessageHandler>

@property (nonatomic , strong)      WKWebView           *clubTourWebView;
/*!
 * @property
 * @brief 活动 ID
 */
@property (nonatomic , strong)      NSString            *clubTourId;

/*!
 * @property
 * @brief 网址URL Str
 */
@property (nonatomic , strong)      NSString            *clubTourDetailURLStr;
@end

@implementation LvyeBaseWebViewController



#pragma mark -
#pragma mark -  系统方法
- (instancetype)init{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithTourId:(NSString *)tourId{
    self = [super init];
    if (self) {
        
        self.clubTourId = [[NSString alloc]initWithFormat:@"%@",tourId];
        self.clubTourDetailURLStr = [NSString stringWithFormat:@"?tourId=%@&&userId=0",tourId];
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
    
    [self setTitle:@"活动详情"];
    
    
    [self setRightNavButtonFA:FMIconFontF045 withFrame:kNavBarButtonRect
                 actionTarget:self action:@selector(setRightButtonEvent)];
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc]init];
    

    WKWebView  *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, KProjectScreenWidth, KProjectScreenHeight) configuration:config];
    [webView setNavigationDelegate:self];
    [webView setUIDelegate:self];
    
    NSLog(@"%@" ,[NSURL URLWithString:[KLvyeClubTourDetailURL stringByAppendingString:self.clubTourDetailURLStr]].absoluteString);
    NSMutableURLRequest *request =[NSMutableURLRequest requestWithURL:[NSURL URLWithString:[KLvyeClubTourDetailURL stringByAppendingString:self.clubTourDetailURLStr]]];
    [webView loadRequest:request];
    self.clubTourWebView =webView;
    [self.view addSubview:self.clubTourWebView];
    
    
    
    
    
    /**此处用于原生获取 JS 的方法内容，，然后根据这里传递的数据及方法名进行信息调整处理**/
    WKUserContentController *userCC = config.userContentController;
    //意思是网页中需要传递的参数是通过这个JS中的showMessage方法来传递的
    [userCC addScriptMessageHandler:self name:@"openNewPageWithActionBar"];
    
    
    
    // Do any additional setup after loading the view.
}




- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }])];
    [self presentViewController:alertController animated:YES completion:nil];
}



- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    
    NSLog(@"error is %@",error.description);
}


- (void)webViewDidClose:(WKWebView *)webView{
    NSLog(@"Close");
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{
    NSLog(@"didCommitNavigation");
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    NSLog(@"didFinishNavigation");
}


- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{
    NSLog(@"webViewWebContentProcessDidTerminate is ");
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    NSLog(@"didStartProvisionalNavigation");
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler{

    NSLog(@"decidePolicyForNavigationAction");
    
    
    
//    NSURLRequest *request = navigationAction.request;
//    WMPageActionType actionType = ActionTypeNone;
    WKNavigationActionPolicy actionPolicy = WKNavigationActionPolicyAllow;
//    if([request.URL.absoluteString hasPrefix:OC_CLOSE_REQUEST]){
//        actionType = ActionTypeClose;
//        actionPolicy = WKNavigationActionPolicyCancel;
//    }
//    if(self.actionDelegate && [self.actionDelegate respondsToSelector:@selector(webView:action:type:)]) {
//        [self.actionDelegate webView:webView action:navigationAction type:actionType];
//    }
    
    ///是否允许跳转操作
    //这句是必须加上的，不然会异常
    decisionHandler(actionPolicy);
}
- (void)setRightButtonEvent{
    
}

//- (void)showMessage{
//
//}
//
//- (void)openNewPageWithActionBar{
//}


- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    NSLog(@"message is %@",message.name);
    
    NSLog(@"message.body %@",message.body);
}
@end
