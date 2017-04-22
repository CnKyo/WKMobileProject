//
//  WKBaseViewController.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/9.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <IQKeyboardManager.h>
#import <MJRefresh.h>
#import <UIView+LayoutMethods.h>
#import <Masonry.h>
#import "WKAPIManager.h"
#import "WKHeader.h"
@interface WKBaseViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
///数据源
@property(nonatomic,strong) NSMutableArray      *tableArr;
///列表
@property(nonatomic,strong) UITableView         *tableView;

/**
 初始化tableview
 */
-(void)addTableView;


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
@end
