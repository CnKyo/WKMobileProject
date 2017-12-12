//
//  WKAlertView.m
//  WKMobileProject
//
//  Created by wangke on 2017/12/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKAlertView.h"
#import <Masonry.h>

#define TagValue  1000
#define AlertTime 0.2 //弹出动画时间
#define kAlertWidth showView_Width - 10   //textContentView
#define kButtonSpace 10
#define kButtonTag 100

@interface WKAlertView()

@property(nonatomic)UIView *mMainView;
@property(nonatomic)UIView *mLineView;
@property(nonatomic)UILabel *mTitleLabel;
@property(nonatomic)UILabel *mMessageLabel;
@property(nonatomic)UIView *mBtnView;

@property(nonatomic)NSMutableArray *buttons;
@property(nonatomic)NSMutableArray *actions;

@property(nonatomic)UIButton *mCloseBtn;

@end

@implementation WKAlertView

#pragma mark - init Method
- (instancetype)initWithFrame:(CGRect)frame{
    if (self =[super initWithFrame:CGRectMake(0, 0, showView_Width, showView_Height)]) {
        
        [self setupInit];
        [self setupSubView];
    }
    return self;
}
#pragma mark----****----初始化控制器
/**
 初始化控制器
 
 @param mTitle 标题
 @param mTextColor 标题内容颜色
 @param mLineColor 线颜色
 @param mTitleBgkColor 标题背景颜色
 @param mHideCloseBtn 是否隐藏x按钮
 @param mHideLine 是否隐藏线
 @param mRadius 控件圆角
 @param mMessage 显示信息详情
 @return 返回控件
 */
+ (instancetype)alertTitle:(NSString *)mTitle andTitleTextColor:(UIColor *)mTextColor andLineViewColor:(UIColor *)mLineColor andTitleBgkColor:(UIColor *)mTitleBgkColor andHideCloseBtn:(BOOL)mHideCloseBtn andHideLineView:(BOOL)mHideLine andCornerRadius:(CGFloat)mRadius andMessage:(NSString *)mMessage{
    return [[self alloc] initWithTitle:mTitle andTitleTextColor:mTextColor andLineViewColor:mLineColor andTitleBgkColor:mTitleBgkColor andHideCloseBtn:mHideCloseBtn andHideLineView:mHideLine andCornerRadius:mRadius andMessage:mMessage];
}
- (instancetype)initWithTitle:(NSString *)title andTitleTextColor:(UIColor *)mTextColor andLineViewColor:(UIColor *)mLineColor andTitleBgkColor:(UIColor *)mTitleBgkColor andHideCloseBtn:(BOOL)mHideCloseBtn andHideLineView:(BOOL)mHideLine andCornerRadius:(CGFloat)mRadius andMessage:(NSString *)mMessage{
    if (self = [self init]) {
        _mTitleLabel.text = title;
        _mMessageLabel.text = mMessage;
        
        _mTitleLabel.backgroundColor = mTitleBgkColor;
        _mTitleLabel.textColor = mTextColor;
        _mLineView.backgroundColor = mLineColor;
        
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = mRadius;
        _mLineView.hidden = mHideLine;
        _mCloseBtn.hidden = mHideCloseBtn;
    }
    return self;
}
#pragma mark - Custom Methods
- (void)addAction:(WKAlertAction *)action{
    
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.clipsToBounds = YES;
    [btn setTitle:action.title forState:UIControlStateNormal];
    btn.layer.cornerRadius = 4.0;
    btn.backgroundColor = [self buttonBgColorWithStyle:action.style];
    btn.enabled = action.enabled;
    btn.tag = kButtonTag + _buttons.count;
    [btn addTarget:self action:@selector(actionButtonOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.mBtnView addSubview:btn];
    [self.buttons addObject:btn];
    [self.actions addObject:action];
    
    if (_buttons.count == 1) {
        [self layoutContentViews];
        [self layoutTextLabels];
        
    }
    [self layoutButtons];
}
-(void)show{
    if (self.superview) {
        [self removeFromSuperview];
    }
    UIView *oldView = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
    if (oldView) {
        [oldView removeFromSuperview];
    }
    UIView *bgView = [[UIView alloc]initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
    bgView.tag = TagValue;
    bgView.userInteractionEnabled = YES;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(hide)];
    [bgView addGestureRecognizer:tap];
    bgView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    [[UIApplication sharedApplication].keyWindow addSubview:bgView];
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.center = [UIApplication sharedApplication].keyWindow.center;
    self.alpha = 0;
    self.transform = CGAffineTransformScale(self.transform, 0.1, 0.1);
    
    [UIView animateWithDuration:AlertTime animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}
//隐藏
-(void)hide{
    
    if (self.superview) {
        [UIView animateWithDuration:AlertTime animations:^{
            self.transform  = CGAffineTransformScale(self.transform, 0.1, 0.1);
            self.alpha = 0;
            
        } completion:^(BOOL finished) {
            
            UIView *bgView = [[UIApplication sharedApplication].keyWindow viewWithTag:TagValue];
            if (bgView) {
                [bgView removeFromSuperview];
                [self removeFromSuperview];
            }
            [bgView removeFromSuperview];
            [self removeFromSuperview];
            
        }];
    }
}
- (UIColor *)buttonBgColorWithStyle:(WKAlertActionStyle )style{
    
    switch (style) {
        case WKAlertActionCancel:
            return _butttonCancelBgColor;
            break;
        case WKAlertActionConfirm:
            return _butttonConfirmBgColor;
            break;
        default:
            break;
    }
}

#pragma mark - setupInit Method
- (void)setupInit{
    self.backgroundColor = [UIColor whiteColor];
    //    self.layer.cornerRadius = 10.0;
    //    self.layer.masksToBounds = YES;
    _butttonCancelBgColor = [UIColor colorWithRed:127/255.0 green:140/255.0 blue:141/255.0 alpha:1];
    _butttonConfirmBgColor = [UIColor colorWithRed:231/255.0 green:76/255.0 blue:60/255.0 alpha:1];
    
}
#pragma mark - setupSubView Method
- (void)setupSubView{
    
    [self addSubview:self.mMainView];
    [self addSubview:self.mBtnView];
    [self.mMainView addSubview:self.mTitleLabel];
    [self.mMainView addSubview:self.mLineView];
    [self.mMainView addSubview:self.mMessageLabel];
    [self.mMainView addSubview:self.mCloseBtn];
}

#pragma mark - layout Method
- (void)didMoveToSuperview
{
    if (self.superview) {
        [self layoutContentViews];
        [self layoutTextLabels];
    }
}
- (void)layoutContentViews{
    
    [_mMainView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(8);
        make.center.mas_equalTo(self);
        make.width.mas_equalTo(kAlertWidth);
    }];
    [_mBtnView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.mas_equalTo(_mMainView.mas_bottom);
        make.left.mas_equalTo(kButtonSpace);
        make.right.mas_equalTo(-kButtonSpace);
        make.height.mas_equalTo(45);
    }];
}
- (void)layoutTextLabels{
    
    //title
    [_mTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.mas_equalTo(self);
        make.height.mas_equalTo(50);
    }];
    //lineView
    [_mLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mTitleLabel.mas_bottom);
        make.left.right.mas_equalTo(self);
        make.height.mas_equalTo(1);
    }];
    //message
    [_mMessageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mLineView.mas_bottom);
        make.left.right.mas_equalTo(_mMainView);
        make.centerY.mas_equalTo(_mMainView.mas_centerY);
    }];
    
    [_mCloseBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_mMainView).offset(5);
        make.right.mas_equalTo(_mMainView).offset(-5);
        
        make.height.width.mas_equalTo(25);
    }];
    
}
- (void)layoutButtons{
    
    UIButton *button =_buttons.lastObject;
    if (_buttons.count == 1) {
        [self.mBtnView addSubview:button];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.mas_equalTo(_mBtnView);
        }];
    }else if (_buttons.count == 2){
        
        UIButton *firstButton = _buttons.firstObject;
        [firstButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.mas_equalTo(_mBtnView);
            make.right.equalTo(button.mas_left).offset(-kButtonSpace);
            
            make.width.mas_equalTo(button.mas_width);
        }];
        [button mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(firstButton.mas_right).offset(kButtonSpace);
            make.right.equalTo(_mBtnView.mas_right);
            make.top.mas_equalTo(_mBtnView.mas_top);
            make.bottom.mas_equalTo(_mBtnView.mas_bottom);
        }];
        [button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(45);
        }];
    }
}
#pragma mark - SEL Method
- (void)actionButtonOnClick:(UIButton *)sender{
    
    WKAlertAction *action = _actions[sender.tag - kButtonTag];
    [self hide];
    
    if (action.handler) {
        action.handler(action);
    }
}
#pragma mark - Setter && Getter Methods

-(UILabel *)mTitleLabel{
    if (!_mTitleLabel) {
        _mTitleLabel = [[UILabel alloc]init];
        _mTitleLabel.textAlignment = NSTextAlignmentCenter;
        _mTitleLabel.textColor = [UIColor whiteColor];
    }
    return _mTitleLabel;
}
- (UILabel *)mMessageLabel{
    
    if (!_mMessageLabel) {
        _mMessageLabel = [[UILabel alloc]init];
        _mMessageLabel.numberOfLines = 0;
        _mMessageLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _mMessageLabel;
}
- (UIView *)mLineView{
    
    if (!_mLineView) {
        _mLineView = [[UIView alloc]init];
        _mLineView.backgroundColor = [UIColor colorWithRed:220/255.0 green:221/255.0 blue:221/255.0 alpha:1];
    }
    return _mLineView;
}

- (UIView *)mMainView{
    
    if (!_mMainView) {
        _mMainView = [[UIView alloc]init];
    }
    return _mMainView;
}
- (UIView *)mBtnView{
    if (!_mBtnView) {
        _mBtnView = [[UIView alloc]init];
        _mBtnView.userInteractionEnabled = YES;
        
    }
    return _mBtnView;
}
- (NSMutableArray *)buttons{
    
    if (!_buttons) {
        _buttons = [NSMutableArray array];
    }
    return _buttons;
}
- (NSMutableArray *)actions{
    
    if (!_actions) {
        _actions = [NSMutableArray array];
    }
    return _actions;
}
- (void)dealloc{
    NSLog(@"deallocdealloc");
}
- (UIButton *)mCloseBtn{
    if (!_mCloseBtn) {
        _mCloseBtn = [[UIButton alloc] init];
        _mCloseBtn.backgroundColor = [UIColor clearColor];
        [_mCloseBtn addTarget:self action:@selector(mCloseAction:) forControlEvents:UIControlEventTouchUpInside];
        [_mCloseBtn setBackgroundImage:[UIImage imageNamed:@"icon_close"] forState:0];
    }
    return _mCloseBtn;
}
- (void)mCloseAction:(UIButton *)sender{
    [self hide];
}
@end

#pragma mark -*********** HHAlertAction ************
@implementation WKAlertAction
#pragma mark - init Method
- (instancetype)initWithTitle:(NSString *)title style:(WKAlertActionStyle)style handler:(void(^)(WKAlertAction *))hander{
    
    if (self = [super init]) {
        _title = title;
        _style = style;
        _handler = hander;
        _enabled = YES;
    }
    return self;
}
+ (instancetype)actionTitle:(NSString *)title style:(WKAlertActionStyle)style handler:(void(^)(WKAlertAction *action))handler{
    
    return [[self alloc]initWithTitle:title style:style handler:handler];
}

@end
