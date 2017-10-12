//
//  WKTransetViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTransetViewController.h"
#import "WKSegmentControl.h"
#import "WKHeader.h"
#import <BAButton.h>
#import "WKDriverCell.h"
#import "WKMyReleaseCell.h"
#import "WKOrderDetailViewController.h"
@interface WKTransetViewController ()
<UITableViewDelegate,UITableViewDataSource,WKSegmentControlDelagate>
@property (strong,nonatomic) UITableView *tableView;
@end

@implementation WKTransetViewController
{
    NSMutableArray *mTableArr;
    WKSegmentControl *mSegmentView;
    
    WKTransferType mType;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我要运输";
    mType = 0;
    mTableArr = [NSMutableArray new];
    
    CGRect mRFrame = CGRectMake(DEVICE_Width-60, 0, 60, 40);
    
    UIButton *mRightBtn = [UIButton ba_creatButtonWithFrame:mRFrame title:@"发布" selTitle:nil titleColor:[UIColor colorWithRed:0.223529411764706 green:0.533333333333333 blue:0.886274509803922 alpha:1.00] titleFont:[UIFont systemFontOfSize:14] image:nil selImage:nil padding:2 buttonPositionStyle:BAKit_ButtonLayoutTypeCenterImageRight viewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:20 target:self selector:@selector(handleRightNaviButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mRightBtn];
    [self initView];
}

- (void)initView{
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 0, DEVICE_Width, 50) andTitleWithBtn:@[@"司机列表",@"我的订单"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor blueColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor blueColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
    //    [self.view addSubview:mSegmentView];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor = COLOR(247, 247, 247);
    
    UINib   *nib = [UINib nibWithNibName:@"WKDriverCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"WKMyReleaseCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
        
    }];
    
}
- (void)handleRightNaviButtonAction:(UIButton *)sender{
    
    MLLog(@"左边的添加");
    
  
}
/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    return mSegmentView;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 50;
    
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 3;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (mType == 0) {
        return 80;
        
    }else{
        
        return 160;
        
    }
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    if (mType == 0) {
        CellId = @"cell";
        
        WKDriverCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        return cell;
    }else{
        
        CellId = @"cell2";
        
        WKMyReleaseCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        return cell;
    }
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
    if (mType == 0) {
       
    }else{
        WKOrderDetailViewController *vc = [WKOrderDetailViewController new];
        [self.navigationController pushViewController:vc animated:YES];
        
    }
    
}
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"点击了%lu",(unsigned long)mIndex);
    mType = mIndex;
    [self.tableView reloadData];
    
}
@end
