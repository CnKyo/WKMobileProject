//
//  WKFindTableViewCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WKHeader.h"
@interface WKFindTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mSource;
@property (weak, nonatomic) IBOutlet UIImageView *mImg;

@property (strong,nonatomic) WKNews *mNews;

@end
