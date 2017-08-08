//
//  WKTaskHeaderCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTaskHeaderCell.h"

@implementation WKTaskHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier data:(NSArray *)data{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = COLOR(244, 248, 254);
        if (data.count <= 0) {
            
        }else{
            NSMutableArray *mImgUrl = [NSMutableArray new];
            
            
            for (NSString *mBanner in data) {
                [mImgUrl addObject:mBanner];
            }
            
            _mScrollerView = [[RKImageBrowser alloc] initWithFrame:CGRectMake(0, 0, screen_width, 200)];
            _mScrollerView.backgroundColor = [UIColor whiteColor];
            [_mScrollerView setBrowserWithImagesArray:mImgUrl];
            __weak __typeof(self)weakSelf = self;
            
            _mScrollerView.didselectRowBlock = ^(NSInteger clickRow) {
                MLLog(@"333点击了图片%ld", clickRow);
                if ([weakSelf.delegate respondsToSelector:@selector(WKTaskHeaderCellBannerClicked:)]) {
                    [weakSelf.delegate WKTaskHeaderCellBannerClicked:clickRow];
                }
            };
            [self.contentView addSubview:_mScrollerView];
        }

    }
    return self;

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
