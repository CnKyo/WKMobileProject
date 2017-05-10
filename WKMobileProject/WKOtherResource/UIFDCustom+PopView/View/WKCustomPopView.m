//
//  WKUIButtonCorners.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/5/8.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKCustomPopView.h"
#import "FDAlertView.h"
#import "WKHeader.h"
@interface WKCustomPopView ()

@end

@implementation WKCustomPopView
+ (WKCustomPopView *)initViewType:(WKCustomPopViewType)mType andTitle:(NSString *)mTitle andContentTx:(NSString *)mContent andOkBtntitle:(NSString *)mOkTitle andCancelBtntitle:(NSString *)mCancelTitle{

    WKCustomPopView *contentView = [[NSBundle mainBundle] loadNibNamed:@"WKCustomPopView" owner:nil options:nil].lastObject;

    if (mType == WKCustomPopViewSucess) {
        
        [contentView.mBtn setButtonRoundedCornersWithView:contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
        contentView.mLeftBtn.hidden = contentView.mrightBtn.hidden = YES;
        
        [contentView.mBtn setTitle:mOkTitle forState:0];
        contentView.mTitle.text = mTitle;
        contentView.mContentView.text = mContent;
        
        return contentView;
    }else if (mType == WKCustomPopViewError){
        contentView.mTitleView.backgroundColor = COLOR(153, 153, 153);
        [contentView.mBtn setButtonRoundedCornersWithView:contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
        contentView.mLeftBtn.hidden = contentView.mrightBtn.hidden = YES;
        [contentView.mBtn setTitle:mOkTitle forState:0];
        contentView.mTitle.text = mTitle;
        contentView.mContentView.text = mContent;
        return contentView;
    }else if (mType == WKCustomPopViewHaveCloseBtn){
        [contentView.mLeftBtn setButtonRoundedCornersWithView:contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
        [contentView.mrightBtn setButtonRoundedCornersWithView:contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
        contentView.mLeftBtn.hidden = contentView.mrightBtn.hidden = YES;

        [contentView.mBtn setButtonRoundedCornersWithView:contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
        contentView.mTitle.text = mTitle;
        contentView.mContentView.text = mContent;
        return contentView;
    }else{
        [contentView.mLeftBtn setButtonRoundedCornersWithView:contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
        [contentView.mrightBtn setButtonRoundedCornersWithView:contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
        [contentView.mBtn setButtonRoundedCornersWithView:contentView.superview andCorners:UIRectCornerAllCorners radius:3.0];
        contentView.mBtn.hidden = YES;
        [contentView.mLeftBtn setTitle:mOkTitle forState:0];
        [contentView.mrightBtn setTitle:mCancelTitle forState:0];
        contentView.mTitle.text = mTitle;
        contentView.mContentView.text = mContent;
        return contentView;
    }


}
- (IBAction)shutdown:(id)sender {

    if ([self.delegate respondsToSelector:@selector(WKCustomPopViewWithCloseBtnAction)]) {
        [self.delegate WKCustomPopViewWithCloseBtnAction];
        FDAlertView *alert = (FDAlertView *)self.superview;
        [alert hide];
    }
    
    
}

- (IBAction)ok:(id)sender {

    if ([self.delegate respondsToSelector:@selector(WKCustomPopViewWithOkBtnAction)]) {
        [self.delegate WKCustomPopViewWithOkBtnAction];
        FDAlertView *alert = (FDAlertView *)self.superview;
        [alert hide];

    }
}
@end
