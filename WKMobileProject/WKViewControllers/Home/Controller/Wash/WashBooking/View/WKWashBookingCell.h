//
//  WKWashBookingCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKWashBookingCellDelegate <NSObject>

@optional

- (void)WKWashBookingCellBtnAction:(NSIndexPath *)mIndexPath;

@end

@interface WKWashBookingCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mBgkImg;
///状态
@property (weak, nonatomic) IBOutlet UILabel *mStatus;
///内容
@property (weak, nonatomic) IBOutlet UILabel *mContent;
///按钮
@property (weak, nonatomic) IBOutlet UIButton *mBtn;
///索引
@property (weak,nonatomic) NSIndexPath *mIndexPath;

@property (weak,nonatomic) id<WKWashBookingCellDelegate>delegate;

@end
