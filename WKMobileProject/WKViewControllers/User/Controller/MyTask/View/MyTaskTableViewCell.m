//
//  MyTaskTableViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "MyTaskTableViewCell.h"

@implementation MyTaskTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.mCommitBtn.layer.cornerRadius  =4;
}
- (IBAction)mBtnAction:(id)sender {
    if ([self.delegate respondsToSelector:@selector(MyTaskTableViewCellDelegateWithBtnAction:)]) {
        [self.delegate MyTaskTableViewCellDelegateWithBtnAction:self.mIndexPath];
    }
    
}

- (void)setMTask:(MWMyTaskOrderObj *)mTask{

    [self.mImg sd_setImageWithURL:[NSURL URLWithString:[Util currentSourceImgUrl:mTask.task_image]] placeholderImage:[UIImage imageNamed:@"icon_task"]];
    self.mName.text = mTask.task_title;
    self.mPrice.text = [NSString stringWithFormat:@"¥%@/次",mTask.task_price];
    self.mContent.text = [NSString stringWithFormat:@"已领取%@次 任务通过率%@",mTask.task_choose_num,mTask.task_complete_rate];
}
@end
