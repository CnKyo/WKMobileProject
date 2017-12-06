//
//  WKConnectViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/18.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKConnectViewController.h"
#import "WKConnectCell.h"
@interface WKConnectViewController ()

@end

@implementation WKConnectViewController
{
    NSString *mHImg;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *mTitle = nil;
    if (_mType == 1) {
        mTitle = @"联系我们";
        mHImg = @"contact_us_03";
    }else{
        mTitle = @"帮助中心";
        
        mHImg = @"help_center_03";

    }
    self.navigationItem.title = mTitle;
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKConnectCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
}
- (void)tableViewHeaderReloadData{
    MLLog(@"刷头");

    [self.tableArr removeAllObjects];
    [MWBaseObj MWGetHelpCenter:@{} andType:_mType block:^(MWBaseObj *info,NSArray *mArr,NSArray *mList) {
        if (info.err_code == 0) {
            [self.tableArr addObjectsFromArray:mList];
            
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [self.tableView reloadData];


    }];

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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    UIView *mSection = [UIView new];
    
    UIImageView *mImg = [UIImageView new];
    mImg.backgroundColor = [UIColor colorWithRed:0.956862745098039 green:0.972549019607843 blue:0.996078431372549 alpha:1.00];

    mImg.frame = CGRectMake(15, 15, DEVICE_Width-30, 180);
    mImg.image = [UIImage imageNamed:mHImg];
    [mSection addSubview:mImg];

    return mSection;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 210;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKConnectCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (_mType == 2) {
        cell.mWcontraints.constant = 0;
        [cell setMHelpObj:self.tableArr[indexPath.row]];
    }else{
        cell.mWcontraints.constant = 50;
        [cell setMConnectObj:self.tableArr[indexPath.row]];
    }
    return cell;
    
}

@end
