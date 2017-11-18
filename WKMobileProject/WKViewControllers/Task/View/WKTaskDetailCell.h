//
//  WKTaskDetailCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WKHeader.h"
@interface WKTaskDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mTitle;

@property (weak, nonatomic) IBOutlet UILabel *mContent;
///底部的线
@property (weak, nonatomic) IBOutlet UIView *mLine;

@property (strong,nonatomic) MWTaskObj *mTask;

@property (strong,nonatomic) WKHome *mActivity;

@end
