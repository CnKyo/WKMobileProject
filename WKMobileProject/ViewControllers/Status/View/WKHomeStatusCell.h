//
//  WKHomeStatusCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKHomeStatusCellDelegate <NSObject>

@optional

- (void)WKHomeStatusCellDelegateWithBtnAction:(NSInteger)mTag withIndexPath:(NSIndexPath *)mIndexPath;

@end

@interface WKHomeStatusCell : UITableViewCell

///名称
@property (weak, nonatomic) IBOutlet UILabel *mName;
///声音按钮
@property (weak, nonatomic) IBOutlet UIButton *mVoiceBtn;
///日期
@property (weak, nonatomic) IBOutlet UILabel *mDate;
///气温
@property (weak, nonatomic) IBOutlet UILabel *mTemperature;
///天气
@property (weak, nonatomic) IBOutlet UILabel *mWether;
///空气
@property (weak, nonatomic) IBOutlet UILabel *mAir;
///风
@property (weak, nonatomic) IBOutlet UILabel *mWind;
///报警状态
@property (weak, nonatomic) IBOutlet UILabel *mAlertStatus;
///查看摄像机
@property (weak, nonatomic) IBOutlet UIButton *mCheckCamBtn;
///k线图View
@property (weak, nonatomic) IBOutlet UIView *mKLineView;

@property (strong,nonatomic) NSIndexPath *mIndexPath;

@property (weak,nonatomic) id<WKHomeStatusCellDelegate>delegate;

@end
