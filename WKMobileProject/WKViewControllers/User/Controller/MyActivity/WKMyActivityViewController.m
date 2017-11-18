//
//  WKMyActivityViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyActivityViewController.h"
#import "WKActivityTableViewCell.h"
#import "WKTaskDetailViewController.h"
@interface WKMyActivityViewController ()

@end

@implementation WKMyActivityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"活动";

    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKActivityTableViewCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
}
- (void)tableViewHeaderReloadData{
    [self.tableArr removeAllObjects];
    [SVProgressHUD showWithStatus:@"正在加载中..."];
    
    [MWBaseObj MWFetchActivityList:@{} block:^(MWBaseObj *info, NSArray *mArr) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self.tableArr addObjectsFromArray:mArr];
            [self.tableView reloadData];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        
    }];
}
- (void)tableViewFooterReloadData{
    
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
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    return 0;
    
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 200;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKActivityTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [cell setMActObj:self.tableArr[indexPath.row]];

//    [cell.mImg sd_setImageWithURL:[NSURL URLWithString:@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg"] placeholderImage:nil];
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了%ld行",indexPath.row);
    WKTaskDetailViewController *vc = [WKTaskDetailViewController new];
    vc.mType = WKActivityDetail;
    vc.mAct = self.tableArr[indexPath.row];
    
    [self.navigationController pushViewController:vc animated:YES];
}

@end
