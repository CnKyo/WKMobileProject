//
//  WKBaseViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/9.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBaseViewController.h"
#import "AppDelegate.h"
#import "WKHeader.h"
#import "WKCustomNavView.h"
#import "CKLeftSlideViewController.h"
@interface WKBaseViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation WKBaseViewController
{
    WKCustomNavView *mNav;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    mNav = [WKCustomNavView initView];
    mNav.frame = CGRectMake(0, -20, DEVICE_Width, 84);
    [mNav.mBackBtn addTarget:self action:@selector(mBackAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mNav];
    
}
- (void)setMTitle:(NSString *)mTitle{
    mNav.mTitle.text = mTitle;

    
}
- (void)addTableView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor = COLOR(247, 247, 247);

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.bottom.equalTo(self.view);
    }];
}
- (void)mBackAction{
//    [[CKLeftSlideViewController alloc]closeLeftView];
    CKLeftSlideViewController *leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
    [leftSlide closeLeftView];
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
