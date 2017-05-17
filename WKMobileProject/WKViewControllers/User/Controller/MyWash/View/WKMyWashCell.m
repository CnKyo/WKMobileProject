//
//  WKMyWashCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyWashCell.h"

@implementation WKMyWashCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)mBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(UITableViewCellDidSelectedIndexPath:)]) {
        [self.delegate UITableViewCellDidSelectedIndexPath:self.mIndexPath];
    }

}



@end
