//
//  ViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/7.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "ViewController.h"
#import "WKHeader.h"
#import "WKHomeTableViewCell.h"
#import <BAButton.h>
#import <LKDBHelper.h>
#import <AVFoundation/AVSpeechSynthesis.h>
#import "WKLoginViewController.h"
#import "WKNavLeftView.h"
#import "WKHomeStatusCell.h"
#import "WKCameraViewController.h"
#import "WKAddDeviceViewController.h"

#import "AppDelegate.h"
#import "CKLeftSlideViewController.h"
#import "WKOrderDetailViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,AVSpeechSynthesizerDelegate,UIAlertViewDelegate,WKNavLeftViewDelegate,WKHomeStatusCellDelegate>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation ViewController
{
    AVSpeechSynthesizer *AVOice;
    HDAlertView *alertView;
    
    NSMutableArray *mTableArr;
    NSArray *mSTableArr;

    WKNavLeftView *mNavLView;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
   
    self.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTranslucent:NO];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithImage:[UIImage imageNamed:@"icon_header"] style:UIBarButtonItemStylePlain target:self action:@selector(leftAction:)];
    self.navigationItem.title = @"首页";
    CGRect mRFrame = CGRectMake(DEVICE_Width-80, 0, 80, 40);

    UIButton *mRightBtn = [UIButton ba_creatButtonWithFrame:mRFrame title:@"+" selTitle:nil titleColor:[UIColor colorWithRed:0.223529411764706 green:0.533333333333333 blue:0.886274509803922 alpha:1.00] titleFont:[UIFont systemFontOfSize:18] image:nil selImage:nil padding:2 buttonPositionStyle:BAKit_ButtonLayoutTypeCenterImageRight viewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:20 target:self selector:@selector(handleRightNaviButtonAction)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mRightBtn];

    
    mSTableArr = @[@"1号蜂巢",@"2号蜂巢"];


    mTableArr = [NSMutableArray new];
    

    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor = COLOR(247, 247, 247);

    UINib   *nib = [UINib nibWithNibName:@"WKHomeStatusCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.949019607843137 green:0.949019607843137 blue:0.949019607843137 alpha:1.00];

    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
    }];
    
    WKLoginViewController *vc = [[WKLoginViewController alloc] initWithNibName:@"WKLoginViewController" bundle:nil];
    
    [self presentViewController:vc animated:YES completion:nil];
}
- (void)leftAction:(UIButton *)sender
{
    CKLeftSlideViewController *leftSlide = (CKLeftSlideViewController *)[((AppDelegate *)[UIApplication sharedApplication].delegate) leftSlideVc];
    [leftSlide openLeftView];
}
- (void)handleRightNaviButtonAction{
    MLLog(@"右边");
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mSTableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cell";
    
    WKHomeStatusCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    cell.mIndexPath = indexPath;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WKOrderDetailViewController *vc = [WKOrderDetailViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 190;
}


@end
