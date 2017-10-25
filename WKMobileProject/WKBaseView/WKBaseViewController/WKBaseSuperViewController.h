//
//  WKBaseSuperViewController.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/25.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WKHeader.h"
#import "WKCustomPopView.h"

#import "UIScrollView+DREmptyDataSet.h"
#import "UIScrollView+DRRefresh.h"
@interface WKBaseSuperViewController : UIViewController<UITableViewDataSource, UITableViewDelegate,WKCustomPopViewDelegate,ZJJTimeCountDownDelegate>

@property (strong,nonatomic) UIImageView *navBarHairlineImageView;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

- (UIImageView *)findHairlineImageViewUnder:(UIView *)view;

@property(nonatomic,strong) ZJJTimeCountDown * countDown;
@property(nonatomic,strong) WKCustomPopView *mCustomView;

/**
 列表数据源
 */
@property(nonatomic,strong) NSMutableArray      *tableArr;
/**
 分页
 */
@property(nonatomic,assign) int mPage;

/**
 设置左边的按钮
 
 @param mHidden    是否显示
 @param mBackTitle 标题
 @param mImage     图片
 */
- (void)addLeftBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage;


/**
 设置右边的按钮
 
 @param mHidden    是否显示
 @param mBackTitle 标题
 @param mImage     图片
 */
- (void)addRightBtn:(BOOL)mHidden andTitel:(NSString *)mBackTitle andImage:(UIImage *)mImage;


- (void)setRightBtnTitle:(NSString *)mTitle;

- (void)setRightBtnImage:(NSString *)mImage;
/**
 右边按钮的点击事件
 */
- (void)rightBtnAction;

#pragma mark----****----页面跳转操作
/**
 跳转到某个controller
 
 @param vc vc
 */
-(void)pushViewController:(UIViewController *)vc;
/**
 返回上个controller
 */
-(void)popViewController;
/**
 返回上上个controller
 */
-(void)popViewController_2;
/**
 *  返回上上上个controller
 */
- (void)popViewController_3;
/**
 *  想返回哪几个上级controller
 *
 *  @param whatYouWant 上级页面个数
 */
- (void)popViewController:(int)whatYouWant;



/**
 *  模态跳转方法
 *
 *  @param vc 跳转的viewcontroller
 */
- (void)presentModalViewController:(UIViewController *)vc;
/**
 *  模态跳转返回上一级
 */
- (void)dismissViewController;
/**
 *  模态跳转返回上二级
 */
- (void)dismissViewController_2;
/**
 *  模态跳转返回上三级
 */
- (void)dismissViewController_3;
/**
 *  模态跳转返回上n级
 */
- (void)dismissViewController:(int)whatYouWant;

#pragma mark----****----自定义弹出框
/**
 自定义弹出框
 
 @param mType 弹出框类型
 @param mTitle 标题
 @param mContent 内容
 @param mOkTitle 确定按钮
 @param mCancelTitle 取消按钮
 */
- (void)showCustomViewType:(WKCustomPopViewType)mType andTitle:(NSString *)mTitle andContentTx:(NSString *)mContent andOkBtntitle:(NSString *)mOkTitle andCancelBtntitle:(NSString *)mCancelTitle;

#pragma mark----****----hud框
- (void)showSucess:(NSString *)text;
- (void)showError:(NSString *)text;
- (void)showAlert:(NSString *)text;
- (void)showWithLoading:(NSString *)text;

-(void)dismiss;
//隐藏svprogressview
@end
