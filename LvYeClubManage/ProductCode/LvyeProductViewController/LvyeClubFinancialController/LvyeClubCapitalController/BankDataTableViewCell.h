//
//  BankDataTableViewCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2018/8/13.
//  Copyright © 2018年 Beijing Lvye Shijie Information Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"
#import "BankInfo.h"


#define KBankDataTableViewCellHeight  KBtnCellHeight

@interface BankDataTableViewCell : TableViewBasicCell
/*!
 * @property
 * @brief 用户选中的信息内容
 */
@property (nonatomic , strong)      BankInfo        *selectedBankInfo;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (void) fillDataInfoWithBankInfo:(BankInfo *) bank;
@end
