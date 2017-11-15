//
//  WKMyWealthRecordCell.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/2.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
@interface WKMyWealthRecordCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *mName;

@property (weak, nonatomic) IBOutlet UILabel *mMoney;

@property (weak, nonatomic) IBOutlet UILabel *mStatus;

@property (strong, nonatomic)  MWRichesHistoryObj *mRiches;

@end
