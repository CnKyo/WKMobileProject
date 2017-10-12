//
//  WKReleaseCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WKReleaseCellDelegate <NSObject>

@optional

- (void)WKReleaseCellDelegateWithBtnAction:(NSInteger)mTag;

@end

@interface WKReleaseCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *mSelectedDateBtn;

@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;

@property (weak,nonatomic) id<WKReleaseCellDelegate>delegate;

@end
