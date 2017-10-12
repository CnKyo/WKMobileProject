//
//  WKMyCollectionViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyCollectionViewController.h"
#import "WKHeader.h"
#import <BAButton.h>

#import "WKMyReleaseCell.h"
#import "WKReleaseViewController.h"
@interface WKMyCollectionViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;


@end

@implementation WKMyCollectionViewController
{
    NSMutableArray *mTableArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的发布";
    mTableArr = [NSMutableArray new];
    CGRect mRFrame = CGRectMake(DEVICE_Width-60, 0, 60, 40);

    UIButton *mRightBtn = [UIButton ba_creatButtonWithFrame:mRFrame title:@"发布" selTitle:nil titleColor:[UIColor colorWithRed:0.223529411764706 green:0.533333333333333 blue:0.886274509803922 alpha:1.00] titleFont:[UIFont systemFontOfSize:14] image:nil selImage:nil padding:2 buttonPositionStyle:BAKit_ButtonLayoutTypeCenterImageRight viewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:20 target:self selector:@selector(handleRightNaviButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mRightBtn];
    
    [self initView];
}
- (void)initView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor = COLOR(247, 247, 247);
    
    UINib   *nib = [UINib nibWithNibName:@"WKMyReleaseCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
    }];
    
}
- (void)handleRightNaviButtonAction:(UIButton *)sender{
    
    MLLog(@"左边的添加");
    
    WKReleaseViewController *vc = [WKReleaseViewController new];
    [self.navigationController pushViewController:vc animated:YES];
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 5;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 160;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    
    CellId = @"cell";
    
    WKMyReleaseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    return cell;
    
        
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
    
}
@end
