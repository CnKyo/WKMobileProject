//
//  WKChoiceWashTableViewCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
@interface WKChoiceWashTableViewCell : UITableViewCell

@property (strong,nonatomic) UIButton *mBtn;

@property (nonatomic, assign) BOOL isSelect;

@property (nonatomic,copy)void(^btnSelectBlock)(BOOL isChoice,NSInteger btntag);
@end
