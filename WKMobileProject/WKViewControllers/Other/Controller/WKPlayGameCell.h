//
//  WKPlayGameCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
@interface WKPlayGameCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *mImg;
@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mPayPrice;

@property (strong, nonatomic) MWGameObj *mGame;

@end
