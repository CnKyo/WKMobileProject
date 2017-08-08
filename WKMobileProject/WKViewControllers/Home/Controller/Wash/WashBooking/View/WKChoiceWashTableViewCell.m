//
//  WKChoiceWashTableViewCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKChoiceWashTableViewCell.h"

@implementation WKChoiceWashTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
      
        self.mBtn = [[UIButton alloc] init];
        [self.mBtn setTitleColor:[UIColor whiteColor] forState:0];
        [self.mBtn addTarget:self action:@selector(selectPressed:) forControlEvents:UIControlEventTouchUpInside];
        self.mBtn.layer.cornerRadius = 3;
        [self.contentView addSubview:self.mBtn];
        [self.mBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView).offset(5);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
        
    }
    return self;
}

- (void)selectPressed:(UIButton *)sender{
    self.isSelect = !self.isSelect;
    if (self.btnSelectBlock) {
        self.btnSelectBlock(self.isSelect,sender.tag);
    }
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
