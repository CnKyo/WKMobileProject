//
//  WKConnectCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/18.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
@interface WKConnectCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mImg;

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mAcount;

@property (weak, nonatomic) IBOutlet UIButton *mConnectBtn;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *mWcontraints;


@property (strong, nonatomic)  MWConntactUsObj *mConnectObj;
@property (strong, nonatomic)  MWHelpCenterObj *mHelpObj;

@end
