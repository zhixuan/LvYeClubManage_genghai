//
//  LvyeFunctions.m
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/7/10.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "LvyeFunctions.h"
#import <CommonCrypto/CommonDigest.h>

#pragma mark - JSON
void AddObjectForKeyIntoDictionary(id object, id key, NSMutableDictionary *dic)
{
    if (object == nil || key == nil || dic == nil
        || ![dic isKindOfClass:[NSDictionary class]]
        || ([object isKindOfClass:[NSString class]] && [object isEqualToString:@""]))
        return;
    
    [dic setObject:object forKey:key];
}

id ObjForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key)
{
    if (unserializedJSONDic == nil || key == nil || ![unserializedJSONDic isKindOfClass:[NSDictionary class]])
        return nil;
    
    id obj = [unserializedJSONDic objectForKey:key];
    if (obj == [NSNull null])
        return nil;
    else if ([obj isKindOfClass:[NSString class]] && [obj isEqualToString:@""])
        return nil;
    else
        return obj;
}
NSString* StringForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key)
{
    id obj = ObjForKeyInUnserializedJSONDic(unserializedJSONDic,key);
    if (obj == nil) {
        return  @"";
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return obj;
    }
    return  [NSString stringWithFormat:@"%@",obj];
}
float FloatForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key)
{
    id obj = ObjForKeyInUnserializedJSONDic(unserializedJSONDic,key);
    if (obj == nil) {
        return  0.0;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj floatValue];
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return [obj floatValue];
    }
    return  0.0;
}
double DoubleForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key)
{
    id obj = ObjForKeyInUnserializedJSONDic(unserializedJSONDic,key);
    if (obj == nil) {
        return  0.0;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj doubleValue];
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return [obj doubleValue];
    }
    return  0.0;
}
NSInteger IntForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key)
{
    id obj = ObjForKeyInUnserializedJSONDic(unserializedJSONDic,key);
    if (obj == nil) {
        return  0;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj intValue];
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return [obj intValue];
    }
    return  0;
}
Boolean BoolForKeyInUnserializedJSONDic(NSDictionary *unserializedJSONDic, id key)
{
    id obj = ObjForKeyInUnserializedJSONDic(unserializedJSONDic,key);
    if (obj == nil) {
        return  NO;
    }
    if ([obj isKindOfClass:[NSNumber class]]) {
        return [obj boolValue];
    }
    if ([obj isKindOfClass:[NSString class]]) {
        return [obj boolValue];
    }
    return  NO;
}

#pragma mark -MD5加密
NSString* EncryptPassword(NSString *str)
{
    const char *cStr = [str UTF8String];
    unsigned char result[16];
    CC_MD5( cStr, (CC_LONG)strlen(cStr), result );
    return [NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]
            ];
}

#pragma mark -判断是否为空
Boolean IsStringEmptyOrNull(NSString * str)
{
    if (!str) {
        // null object
        return true;
    } else {
        NSString *trimedString = [str stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
        if ([trimedString length] == 0) {
            // empty string
            return true;
        } else if([trimedString isEqualToString:@"null"]){
            // is neither empty nor null
            return true;
        }
        else if([trimedString isEqualToString:@"(null)"]){
            // is neither empty nor null
            return true;
        }else {
            return false;
        }
    }
}

Boolean IsNormalMobileNum(NSString  *userMobileNum){
    if ([userMobileNum length] != 11) {
        return NO;
    }
    NSString *patternStr = [NSString stringWithFormat:@"^(0?1[3578]\\d{9})$|^((0(10|2[1-3]|[3-9]\\d{2}))?[1-9]\\d{6,7})$"];
    NSRegularExpression *regularexpression=[[NSRegularExpression alloc]initWithPattern:patternStr
                                                                               options:NSRegularExpressionCaseInsensitive
                                                                                 error:nil];
    NSUInteger numberOfMatch = [regularexpression numberOfMatchesInString:userMobileNum
                                                                  options:NSMatchingReportProgress
                                                                    range:NSMakeRange(0, userMobileNum.length)];
    if (numberOfMatch > 0) {
        return YES;
    }
    return NO;
    
}

#pragma mark - 判断是否为合法的含两位2小数的资金金额内容

/**
 判断是否为合法的含两位2小数的资金金额内容

 @param money 资金金额字符串
 @return  YES 有效，被认可的资金金额，即：是合法的2位小数资金金额；NO，无效，不被认可的资金金额。
 */
extern Boolean isValidateMoney(NSString *money){
    NSString *regex = @"^\\-?([1-9]\\d*|0)(\\.\\d{0,2})?$";
    NSPredicate *predicte = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex];
    return [predicte evaluateWithObject:money];
}

#pragma mark -Image TOOL
UIImage* createImageWithColor(UIColor *color)
{
    CGRect rect = CGRectMake(0.0f, 0.0f, 1.0f, 1.0f);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, [color CGColor]);
    CGContextFillRect(context, rect);
    
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
    
}

UIColor* colorAddAlpha(UIColor* color,CGFloat alpha)
{
    if (CGColorGetNumberOfComponents([color CGColor]) == 2) {
        const CGFloat *colorComponents = CGColorGetComponents([color CGColor]);
        return [UIColor colorWithRed:colorComponents[0]
                               green:colorComponents[0]
                                blue:colorComponents[0]
                               alpha:alpha];
    }
    else if (CGColorGetNumberOfComponents([color CGColor]) == 4) {
        const CGFloat * colorComponents = CGColorGetComponents([color CGColor]);
        return [UIColor colorWithRed:colorComponents[0]
                               green:colorComponents[1]
                                blue:colorComponents[2]
                               alpha:alpha];
    }
    return color;
}

void ShowImportErrorAlertView(NSString *errorString){
    UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"" message:errorString delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    [alertView show];
}

///生成固定位数的随机字符串
NSString* generateRandStringWithBity(int numberCount)
{
    const int N = numberCount;
    ///sourceString中不能出现”Y“字母，“Y”字母作为分隔符进行操作处理
    NSString *sourceString = @"ABCDEFGHIJKLMNOPQRSTUVWYXZ0123456789";
    NSMutableString *result = [[NSMutableString alloc] init];
    ////生成随机不重复随机数  使用无符号数字信息内容 ，避免出现警告内容
    srand((unsigned)time(0));
    for (int i = 0; i < N; i++)
    {
        unsigned index = rand() % [sourceString length];
        NSString *s = [sourceString substringWithRange:NSMakeRange(index, 1)];
        [result appendString:s];
    }
    
    //        return @"F8Z7RVHSC29GUXLSS0FA71Y5ZI5NL2M0";
    return result;
}

#pragma mark -MBProgressHUD
MBProgressHUD* CreateCustomColorHUDOnView(UIView *onView)
{
    MBProgressHUD *hud = [[MBProgressHUD alloc] initWithView:onView];
    hud.color = KContentGreyTextColor;
//    hud.labelColor = kColorTextColorDarkClay;
    return hud;
}

void ShowAutoHideMBProgressHUD(UIView *onView, NSString *labelText)
{
    if (!onView || [labelText length] <= 0)
        return;
    
    MBProgressHUD *hud = CreateCustomColorHUDOnView(onView);
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = labelText;
    hud.completionBlock = nil;
    [hud hide:YES afterDelay:2.0];
    [onView addSubview:hud];
    [hud show:YES];
}

void ShowAutoHideMBProgressHUDWithOneSec(UIView *onView, NSString *labelText)
{
    if (!onView || [labelText length] <= 0)
        return;
    
    MBProgressHUD *hud = CreateCustomColorHUDOnView(onView);
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = labelText;
    hud.completionBlock = nil;
    [hud hide:YES afterDelay:0.3];
    [onView addSubview:hud];
    [hud show:YES];
}

void ShowIMAutoHideMBProgressHUD(UIView *onView, NSString *labelText)
{
    if (!onView || [labelText length] <= 0)
        return;
    
    MBProgressHUD *hud = CreateCustomColorHUDOnView(onView);
    hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = labelText;
    hud.completionBlock = nil;
    [hud hide:YES afterDelay:1.0];
    [onView addSubview:hud];
    [hud show:YES];
}

void WaittingMBProgressHUD(UIView *onView, NSString *labelText)
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:onView];
    if (hud == nil) {
        hud = CreateCustomColorHUDOnView(onView);
    }
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = labelText;
    hud.completionBlock = nil;
    [onView addSubview:hud];
    [hud show:YES];
}
void SuccessMBProgressHUD(UIView *onView, NSString *labelText)
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:onView];
    if (hud == nil) {
        return;
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black_tips_ok.png"]];
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = labelText;
    hud.completionBlock = nil;
    [onView addSubview:hud];
    [onView bringSubviewToFront:hud];
    [hud hide:YES afterDelay:1.0];
}
void FailedMBProgressHUD(UIView *onView, NSString *labelText)
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:onView];
    if (hud == nil) {
        return;
    }
    hud.mode = MBProgressHUDModeCustomView;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"black_tips_error.png"]];
    hud.removeFromSuperViewOnHide = YES;
    hud.labelText = labelText;
    hud.completionBlock = nil;
    [onView addSubview:hud];
    [onView bringSubviewToFront:hud];
    [hud hide:YES afterDelay:2.0];
}
void FinishMBProgressHUD(UIView *onView)
{
    MBProgressHUD *hud = [MBProgressHUD HUDForView:onView];
    if (hud == nil) {
        return;
    }
    [hud hide:YES];
}

#pragma mark -dateFormat
NSDateFormatter* dateLocalShortStyleFormatter()
{
    NSDateFormatter *dateFormatter = dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterShortStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    dateFormatter.locale = [NSLocale currentLocale];
    return dateFormatter;
}

#pragma mark -PullToRefreshView
void UpdateLastRefreshDataForPullToRefreshViewOnView(UIScrollView *view)
{
    if (![view respondsToSelector:@selector(pullToRefreshView)])
        return;
    NSString *lastUpdateString = [NSString stringWithFormat:@"上次更新:%@",
                                  [dateLocalShortStyleFormatter() stringFromDate:[NSDate date]]];
    [view.pullToRefreshView setSubtitle:lastUpdateString forState:SVPullToRefreshStateAll];
}

void ConfiguratePullToRefreshViewAppearanceForScrollView(UIScrollView *view)
{
    if (![view respondsToSelector:@selector(pullToRefreshView)]
        || view.pullToRefreshView == nil)
        return;
    [view.pullToRefreshView setArrowColor:kColorTextColorClay];
    [view.pullToRefreshView setTextColor:kColorTextColorClay];
    [view.pullToRefreshView.subtitleLabel setTextColor:kColorTextColorClay];
    [view.pullToRefreshView setTitle:@"下拉即可刷新..." forState:SVPullToRefreshStateStopped];
    [view.pullToRefreshView setTitle:@"松开即可刷新..." forState:SVPullToRefreshStateTriggered];
    [view.pullToRefreshView setTitle:@"刷新中..." forState:SVPullToRefreshStateLoading];
    UpdateLastRefreshDataForPullToRefreshViewOnView(view);
}

#pragma mark -LoadMoreCell
HUILoadMoreCell* CreateLoadMoreCell(void)
{
    HUILoadMoreCell *cell = [[HUILoadMoreCell alloc] initWithReuseIdentifier:kHUILoadMoreCellIdentifier];
    cell.textLabel.textAlignment    =  NSTextAlignmentCenter;
    cell.textLabel.textColor        = [UIColor grayColor];//[FMThemeManager.skin textColor];
    cell.textLabel.font             = [UIFont systemFontOfSize:12.0];
    cell.textLabel.text             = LOADMORE_LOADING;
    return cell;
}

#pragma mark -
#pragma mark -  根据固定格式格式化为时间字符串
NSString *formatDateWithFormat(NSString  *intformate,NSString  *outFormate,NSString *dateStr){
    
    ///默认为年-月-日，2018-08-27
    NSString *formatter = @"yyyy-MM-dd HH:mm:ss";
    if(!IsStringEmptyOrNull(intformate)){
        formatter =intformate;
    }
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    format.dateFormat = formatter;
    NSDate *data = [format dateFromString:dateStr];
    format.dateFormat =outFormate;
    return  [format stringFromDate:data];;
}
