//
//  MyTaskTableViewCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKCountLabel.h"
@protocol MyTaskTableViewCellDelegate <NSObject>

@optional

- (void)MyTaskTableViewCellDelegateWithBtnAction:(NSIndexPath *)mIndexPath;

@end

@interface MyTaskTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *mImg;

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mPrice;

@property (weak, nonatomic) IBOutlet UILabel *mContent;

@property (weak, nonatomic) IBOutlet WKCountLabel *mCountTime;

@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;

@property (assign,nonatomic) NSIndexPath *mIndexPath;

@property (weak,nonatomic) id <MyTaskTableViewCellDelegate>delegate;

@end
