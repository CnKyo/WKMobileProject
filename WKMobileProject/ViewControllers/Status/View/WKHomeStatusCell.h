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

- (void)WKHomeStatusCellDelegateWithBtnAction:(NSInteger)mTag;

@end

@interface WKHomeStatusCell : UITableViewCell

///名称
@property (weak, nonatomic) IBOutlet UILabel *mOrderCode;
///声音按钮
@property (weak, nonatomic) IBOutlet UIButton *mOrderStatus;

///查看摄像机
@property (weak, nonatomic) IBOutlet UIButton *mAcceptBtn;


@property (strong,nonatomic) NSIndexPath *mIndexPath;

@property (weak,nonatomic) id<WKHomeStatusCellDelegate>delegate;

@end
