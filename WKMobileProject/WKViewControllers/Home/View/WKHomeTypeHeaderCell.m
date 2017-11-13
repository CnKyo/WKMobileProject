//
//  WKHomeTypeHeaderCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/10.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKHomeTypeHeaderCell.h"
#import "WKCustomBtnView.h"
#import "SXMarquee.h"
#import "WKMarqueeBar.h"
@implementation WKHomeTypeHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andBannerDataSource:(NSMutableArray *)mBannerDataSource andDataSource:(NSMutableArray *)mDataSource andScrollerLabelTx:(NSString *)mText{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = COLOR(244, 248, 254);
        if (mBannerDataSource.count <= 0) {
            
        }else{
            NSMutableArray *mImgUrl = [NSMutableArray new];
            
            
            for (WKHome *mBanner in mBannerDataSource) {
                [mImgUrl addObject:[Util currentSourceImgUrl:mBanner.banner_img]];
            }
            
            mScrollerView = [[RKImageBrowser alloc] initWithFrame:CGRectMake(0, 0, screen_width, 200)];
            mScrollerView.backgroundColor = [UIColor whiteColor];
            [mScrollerView setBrowserWithImagesArray:mImgUrl];
            __weak __typeof(self)weakSelf = self;
            
            mScrollerView.didselectRowBlock = ^(NSInteger clickRow) {
                MLLog(@"333点击了图片%ld", clickRow);
                if ([weakSelf.delegate respondsToSelector:@selector(WKHomeBannerDidSelectedWithIndex:)]) {
                    [weakSelf.delegate WKHomeBannerDidSelectedWithIndex:clickRow];
                }
            };
            [self.contentView addSubview:mScrollerView];
        }
        
        UIImageView *mShadow = [UIImageView new];
        mShadow.frame = CGRectMake(0, 200, 90, 40);
//        mShadow.backgroundColor = COLOR(244, 248, 254);
//        mShadow.backgroundColor = [UIColor redColor];

        mShadow.image = [UIImage imageNamed:@"icon_new_activity"];
        [self.contentView addSubview:mShadow];
        
//        UILabel *mActivityLb = [UILabel new];
//        mActivityLb.font = [UIFont systemFontOfSize:16];
//        mActivityLb.frame = CGRectMake(0, 200, 90, 40);
//        mActivityLb.text = @"最新活动 |";
//        mActivityLb.textAlignment = NSTextAlignmentRight;
//        mActivityLb.textColor = [UIColor colorWithRed:0.97 green:0.42 blue:0 alpha:1];
//        [self.contentView addSubview:mActivityLb];
        
        __weak typeof(self)weakSelf = self;

        WKMarqueeBar* marqueeBar = [WKMarqueeBar marqueeBarWithFrame:CGRectMake(90, 200, screen_width-90, 40) title:mText action:^(UIButton *btn) {
            if ([weakSelf.delegate respondsToSelector:@selector(WKHomeScrollerLabelDidSelected)]) {
                [weakSelf.delegate WKHomeScrollerLabelDidSelected];
            }
        }];
        marqueeBar.tintColor = [UIColor blackColor];
        marqueeBar.backgroundColor = COLOR(244, 248, 254);
        
        [self.contentView addSubview:marqueeBar];
        
        
        if (mDataSource.count > 0) {
            int mPage;
            if (mDataSource.count>8) {
                mPage = 2;
            }else{
                mPage = 1;
            }
            
            //
            mBgkView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
            mBgkView2 = [[UIView alloc] initWithFrame:CGRectMake(screen_width, 0, screen_width, 160)];
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 240, screen_width, 180)];
            scrollView.backgroundColor = [UIColor whiteColor];

            scrollView.contentSize = CGSizeMake(mPage*screen_width-16, 180);
            
            scrollView.pagingEnabled = YES;
            scrollView.delegate = self;
            scrollView.showsHorizontalScrollIndicator = NO;
            
            
            CGRect mBgkView1Rect = mBgkView1.frame;
            CGRect mBgkView2Rect = mBgkView2.frame;
            CGRect mSRR = scrollView.frame;
            
            //创建8个
            for (int i = 0; i < mDataSource.count; i++) {
                if (i<2) {
                    CGRect frame = CGRectMake(i*screen_width/2, 0, screen_width/2, 80);
                    
                    WKFunc *mFC = mDataSource[i];
                    WKCustomBtnView *btnView = [[WKCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:mFC.mFuncName ImageStr:mFC.mFuncImg];
                    btnView.tag = i;
                    [mBgkView1 addSubview:btnView];
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    
                    mBgkView1Rect.size.height = 160/2;
                    mSRR.size.height = 180/2;

                }
               else if (i < 4) {
                    CGRect frame = CGRectMake(i*screen_width/4, 0, screen_width/4, 80);
                    
                    NSString *title = @"功能";
                    NSString *imageStr = mDataSource[i];
                    WKCustomBtnView *btnView = [[WKCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                    btnView.tag = i;
                    [mBgkView1 addSubview:btnView];
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    
                    mBgkView1Rect.size.height = 160/2;
                    mSRR.size.height = 180/2;
                }else if(i<8){
                    CGRect frame = CGRectMake((i-4)*screen_width/4, 80, screen_width/4, 80);
                    NSString *title = @"功能";
                    NSString *imageStr = mDataSource[i];
                    WKCustomBtnView *btnView = [[WKCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                    btnView.tag = i;
                    [mBgkView1 addSubview:btnView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    mBgkView1Rect.size.height = 160;
                    mSRR.size.height = 180;
                }else if(i < 12){
                    CGRect frame = CGRectMake((i-8)*screen_width/4, 0, screen_width/4, 80);
                    NSString *title = @"功能";
                    NSString *imageStr = mDataSource[i];
                    WKCustomBtnView *btnView = [[WKCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                    btnView.tag = i;
                    [mBgkView2 addSubview:btnView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    mBgkView2Rect.size.height = 160;
                    mSRR.size.height = 180;
                    
                }else{
                    CGRect frame = CGRectMake((i-12)*screen_width/4, 80, screen_width/4, 80);
                    NSString *title = @"功能";
                    NSString *imageStr = mDataSource[i];
                    WKCustomBtnView *btnView = [[WKCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                    btnView.tag = i;
                    [mBgkView2 addSubview:btnView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    mBgkView2Rect.size.height = 160;
                    mSRR.size.height = 180;
                    
                }
            }
            
            mBgkView1.frame =mBgkView1Rect;
            mBgkView2.frame =mBgkView2Rect;
            CGRect mTR = mSRR;
            mTR.origin.y = -88;
            scrollView.frame = mSRR;
            [scrollView addSubview:mBgkView1];
            [scrollView addSubview:mBgkView2];
            scrollView.contentSize = CGSizeMake(mSRR.size.width, mSRR.size.height);
            
            [self addSubview:scrollView];
        }
        
        
        
    }
    return self;

}
- (void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *mTap = (UITapGestureRecognizer *)sender;
    MLLog(@"%ld",[mTap view].tag);
    
    if ([self.delegate respondsToSelector:@selector(WKHomeScrollerTableViewCellDidSelectedWithIndex:)]) {
        [self.delegate WKHomeScrollerTableViewCellDidSelectedWithIndex:[mTap view].tag];
    }
    
}

@end
