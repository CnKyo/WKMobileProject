//
//  WKMyWashCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"


@protocol WKMyWashCellDelegate <NSObject>

@optional

- (void)UITableViewCellDidSelectedIndexPath:(NSIndexPath*)mIndexPath;

@end

@interface WKMyWashCell : UITableViewCell
@property (weak, nonatomic) IBOutlet WPHotspotLabel *mName;
@property (weak, nonatomic) IBOutlet UILabel *mStatus;

@property (strong,nonatomic) NSIndexPath *mIndexPath;

@property (weak,nonatomic) id<WKMyWashCellDelegate>delegate;

@end
