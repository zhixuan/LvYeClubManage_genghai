//
//  CommentDetailCell.h
//  LvYeClubManage
//
//  Created by ZhangLiGuang on 2019/5/15.
//  Copyright © 2019 BJ_LY_SJ Technology Co.,Ltd. All rights reserved.
//

#import "TableViewBasicCell.h"

NS_ASSUME_NONNULL_BEGIN


#define KCommentDetailCellHeight                (100.0f + KInforLeftIntervalWidth*2)
#define KCommentDetailContentFont               [UIFont systemFontOfSize:16.0f]

@interface CommentDetailCell : TableViewBasicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;


- (void)fildCommentDetailDataSourceWithTourCommentInfo:(NSDictionary *)info;
@end

NS_ASSUME_NONNULL_END
