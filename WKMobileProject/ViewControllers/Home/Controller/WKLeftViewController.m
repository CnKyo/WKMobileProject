//
//  WKLeftViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKLeftViewController.h"
#import "WKHeader.h"

#import "AppDelegate.h"
#import "CKLeftSlideViewController.h"
#import "WKLoginViewController.h"

#import "WKLeftViewCell.h"

#import "WKPersoncenterViewController.h"
@interface WKLeftViewController ()
<UITableViewDelegate,UITableViewDataSource,WKLeftViewCellDelegate>
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation WKLeftViewController
{
    NSMutableArray *mTableArr;
    NSArray *mSTableArr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor orangeColor];
    self.navigationItem.title = @"个人中心";
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor = COLOR(247, 247, 247);
    
    UINib   *nib = [UINib nibWithNibName:@"WKLeftViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
//    self.view.backgroundColor = [UIColor colorWithRed:0.949019607843137 green:0.949019607843137 blue:0.949019607843137 alpha:1.00];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
    }];

   
}



- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
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
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cell";
    
    WKLeftViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
 
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 555;
}
/**
 按钮代理方法
 
 @param mTag 0:个人信息 1:我的余额 2:接单数 3:车辆 4:订单 5:消息  6:设置。7:退出
 */
- (void)WKLeftViewCellDelegateWithBtnAction:(NSInteger)mTag{
    MLLog(@"点击了:%ld",mTag);
    switch (mTag) {
        case 0:
        {
        WKPersoncenterViewController *vc = [WKPersoncenterViewController new];
       
        [self presentViewController:vc animated:YES completion:nil];

        }
            break;
            
        default:
            break;
    }
}
@end
