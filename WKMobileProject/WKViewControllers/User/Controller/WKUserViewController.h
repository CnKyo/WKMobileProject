//
//  WKUserViewController.h
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WKUserViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *tableArr;

@property (strong,nonatomic) UIImageView *navBarHairlineImageView;

@end
