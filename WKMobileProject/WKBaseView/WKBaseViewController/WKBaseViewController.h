//
//  WKBaseViewController.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/9.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKBaseViewController : UIViewController
@property (strong,nonatomic) NSString *mTitle;
@property (strong,nonatomic) UITableView *tableView;

- (void)addTableView;
- (void)setMTitle:(NSString *)mTitle;
@end
