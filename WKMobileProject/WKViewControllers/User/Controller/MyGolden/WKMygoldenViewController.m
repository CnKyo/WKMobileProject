//
//  WKMygoldenViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMygoldenViewController.h"
#import "WKMyGoldenCell.h"
@interface WKMygoldenViewController ()<WKSegmentControlDelagate>

@end

@implementation WKMygoldenViewController
{
    WKSegmentControl *mSegmentView;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"金币";
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKMyGoldenCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
}
- (void)tableViewHeaderReloadData{
    MLLog(@"刷头");
}
- (void)tableViewFooterReloadData{
    MLLog(@"刷尾");
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
#pragma mark----****---- 分段选择控件
///选择了哪一个？
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    [self tableViewHeaderReloadData];
}

#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *mSection = [UIView new];
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 0, DEVICE_Width, 50) andTitleWithBtn:@[@"全部",@"待付款",@"已完成"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor whiteColor] andBtnTitleColor:[UIColor blackColor] andUndeLineColor: [UIColor whiteColor] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
    [mSection addSubview:mSegmentView];
    
    UIView *mLineView = [UIView new];
    mLineView.backgroundColor = [UIColor colorWithRed:0.956862745098039 green:0.972549019607843 blue:0.996078431372549 alpha:1.00];
    mLineView.frame = CGRectMake(0, 50, DEVICE_Width, 10);
    [mSection addSubview:mLineView];
    return mSection;
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIButton *mBtn = [UIButton new];
    mBtn.backgroundColor = [UIColor colorWithRed:0.972549019607843 green:0.584313725490196 blue:0.270588235294118 alpha:1.00];
    [mBtn setTitle:@"一共1000个金币" forState:0];
    return mBtn;
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 60;
}

-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 50;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 75;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKMyGoldenCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}


@end
