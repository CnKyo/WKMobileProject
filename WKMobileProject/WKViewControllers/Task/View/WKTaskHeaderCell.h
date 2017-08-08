//
//  WKTaskHeaderCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
#import "RKImageBrowser.h"

@protocol WKTaskHeaderCellDelegate <NSObject>

@optional

- (void)WKTaskHeaderCellBannerClicked:(NSInteger)mIndex;

@end

@interface WKTaskHeaderCell : UITableViewCell
//    DCPicScrollView  *mScrollerView;
@property (nonatomic,strong) RKImageBrowser  *mScrollerView;

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(NSArray *)data;
@property (strong,nonatomic) id <WKTaskHeaderCellDelegate>delegate;

@end
