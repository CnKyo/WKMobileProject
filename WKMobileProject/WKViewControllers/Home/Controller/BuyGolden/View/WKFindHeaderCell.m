//
//  WKFindHeaderCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKFindHeaderCell.h"
#import "WKCustomBtnView.h"

@implementation WKFindHeaderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

/**
 重设cell的重用方法
 
 @param style           cell类型
 @param reuseIdentifier 重用id
 @param mDataSource     主功能按钮数据源
 
 @return 返回cell
 */
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier andBannerDataSource:(NSMutableArray *)mBannerDataSource andDataSource:(NSMutableArray *)mDataSource{

    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        NSMutableArray *mFuncArr = [NSMutableArray new];
        
        UIView *mBannerView = [UIView new];
        [self addSubview:mBannerView];
        
        
        UIView *mFuncView = [UIView new];
        [self addSubview:mFuncView];

        [mBannerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self);
            make.bottom.equalTo(mFuncView.mas_top);
            make.height.offset(170);
        }];
        
        [mFuncView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.top.equalTo(mBannerView.mas_bottom);
            make.height.offset(85);
        }];
        
        if (mBannerDataSource.count <= 0) {
            
        }else{
            NSMutableArray *mImgUrl = [NSMutableArray new];
            
            
            for (int i = 0;i<mBannerDataSource.count;i++) {
                WKNews *mNew = mBannerDataSource[i];
                [mImgUrl addObject:mNew.thumbnail_pic_s];
                if (i==4) {
                    break;
                }
                
            }
            
            mScrollerView = [[RKImageBrowser alloc] initWithFrame:CGRectMake(0, 0, screen_width, 170)];
            mScrollerView.backgroundColor = [UIColor redColor];
            [mScrollerView setBrowserWithImagesArray:mImgUrl];
            __weak __typeof(self)weakSelf = self;
            
            mScrollerView.didselectRowBlock = ^(NSInteger clickRow) {
                MLLog(@"333点击了图片%ld", clickRow);
                if ([weakSelf.delegate respondsToSelector:@selector(WKFindHeaderCellDelegateWithBannerClicked:)]) {
                    [weakSelf.delegate WKFindHeaderCellDelegateWithBannerClicked:clickRow];
                }
            };
            [mBannerView addSubview:mScrollerView];
            
            UIView *mSearchView = [UIView new];
            mSearchView.backgroundColor = [UIColor colorWithRed:1.0 green:1.0 blue:1.0 alpha:0.8];
            mSearchView.layer.cornerRadius = 6.0f;
            mSearchView.layer.borderColor = [UIColor colorWithRed:0.686274509803922 green:0.768627450980392 blue:0.8 alpha:1.00].CGColor;
            mSearchView.layer.borderWidth = 0.5;
            
            [mBannerView addSubview:mSearchView];
            
            [mSearchView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(mBannerView).offset(15);
                make.right.equalTo(mBannerView).offset(-15);
                make.bottom.equalTo(mBannerView.mas_bottom).offset(-15);
                make.height.offset(40);
            }];
            
            UITextField *mSearchTx = [UITextField new];
            //mSearchTx.delegate = self;
            [mSearchTx addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];

            mSearchTx.placeholder = @"请输入搜索内容";
            [mSearchView addSubview:mSearchTx];


            UIButton *mSaerchBtn = [UIButton new];

            [mSaerchBtn setImage:[UIImage imageNamed:@"icon_search_blue"] forState:0];
            [mSaerchBtn addTarget:self action:@selector(searchAction) forControlEvents:UIControlEventTouchUpInside];
            [mSearchView addSubview:mSaerchBtn];
            
            [mSaerchBtn mas_makeConstraints:^(MASConstraintMaker *make) {
                make.right.bottom.equalTo(mSearchView).offset(-8);
                make.top.equalTo(mSearchView).offset(8);
                make.width.offset(28);
                make.left.equalTo(mSearchTx.mas_right).offset(8);

            }];
            [mSearchTx mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.top.equalTo(mSearchView).offset(5);
                make.bottom.equalTo(mSearchView).offset(-5);
                make.right.equalTo(mSaerchBtn.mas_left).offset(-8);

            }];
            
            
        }
        for (int i = 0;i<mBannerDataSource.count;i++) {
            WKNews *mNew = mBannerDataSource[i];
            [mFuncArr addObject:mNew];
            if (i==3) {
                break;
            }
            
        }
        if (mFuncArr.count > 0) {
            int mPage;
            if (mFuncArr.count>8) {
                mPage = 2;
            }else{
                mPage = 1;
            }
            
            //
            mBgkView1 = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 160)];
            mBgkView2 = [[UIView alloc] initWithFrame:CGRectMake(screen_width, 0, screen_width, 160)];
            UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, screen_width, 180)];
            scrollView.backgroundColor = [UIColor whiteColor];
            
            scrollView.contentSize = CGSizeMake(mPage*screen_width-16, 180);
            
            scrollView.pagingEnabled = YES;
            scrollView.delegate = self;
            scrollView.showsHorizontalScrollIndicator = NO;
            
            
            CGRect mBgkView1Rect = mBgkView1.frame;
            CGRect mBgkView2Rect = mBgkView2.frame;
            CGRect mSRR = scrollView.frame;
            
            //创建8个
            for (int i = 0; i < mFuncArr.count; i++) {
                if (i < 4) {
                    CGRect frame = CGRectMake(i*screen_width/4, 0, screen_width/4, 80);
                    WKNews *mNew = mFuncArr[i];
                    NSString *title = @"功能";
                    NSString *imageStr = mNew.thumbnail_pic_s02;
                    WKCustomBtnView *btnView = [[WKCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                    btnView.tag = i;
                    [mBgkView1 addSubview:btnView];
                    
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    
                    mBgkView1Rect.size.height = 160/2;
                    mSRR.size.height = 180/2;
                }else if(i<8){
                    CGRect frame = CGRectMake((i-4)*screen_width/4, 80, screen_width/4, 80);
                    WKNews *mNew = mFuncArr[i];
                    NSString *title = @"功能";
                    NSString *imageStr = mNew.thumbnail_pic_s02;
                    WKCustomBtnView *btnView = [[WKCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                    btnView.tag = i;
                    [mBgkView1 addSubview:btnView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    mBgkView1Rect.size.height = 160;
                    mSRR.size.height = 180;
                }else if(i < 12){
                    CGRect frame = CGRectMake((i-8)*screen_width/4, 0, screen_width/4, 80);
                    WKNews *mNew = mFuncArr[i];
                    NSString *title = @"功能";
                    NSString *imageStr = mNew.thumbnail_pic_s02;
                    WKCustomBtnView *btnView = [[WKCustomBtnView alloc] initWithZLCustomBtnViewFrame:frame Title:title ImageStr:imageStr];
                    btnView.tag = i;
                    [mBgkView2 addSubview:btnView];
                    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(OnTapBtnView:)];
                    [btnView addGestureRecognizer:tap];
                    mBgkView2Rect.size.height = 160;
                    mSRR.size.height = 180;
                    
                }else{
                    CGRect frame = CGRectMake((i-12)*screen_width/4, 80, screen_width/4, 80);
                    WKNews *mNew = mFuncArr[i];
                    NSString *title = @"功能";
                    NSString *imageStr = mNew.thumbnail_pic_s02;
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
            scrollView.frame = mSRR;
            [scrollView addSubview:mBgkView1];
            [scrollView addSubview:mBgkView2];
            scrollView.contentSize = CGSizeMake(mSRR.size.width, mSRR.size.height);
            
            [mFuncView addSubview:scrollView];
        }

        
        
    }
    return self;

}
- (void)OnTapBtnView:(UITapGestureRecognizer *)sender{
    UITapGestureRecognizer *mTap = (UITapGestureRecognizer *)sender;
    MLLog(@"%ld",[mTap view].tag);
    
    if ([self.delegate respondsToSelector:@selector(WKFindHeaderCellDelegateWithFuncClicked:)]) {
        [self.delegate WKFindHeaderCellDelegateWithFuncClicked:[mTap view].tag];
    }
    
}
- (void)searchAction{
    if ([self.delegate respondsToSelector:@selector(WKFindHeaderCellDelegateWithSearchBtnClicked)]) {
        [self.delegate WKFindHeaderCellDelegateWithSearchBtnClicked];
    }
}
- (void)textFieldDidChange:(UITextField *)textField{
    if (textField.markedTextRange == nil) {
        if (textField.text.length>0) {
            if ([self.delegate respondsToSelector:@selector(WKFindHeaderCellDelegateWithSearchText:)]) {
                [self.delegate WKFindHeaderCellDelegateWithSearchText:textField.text];
            }
        }
    }
}

@end
