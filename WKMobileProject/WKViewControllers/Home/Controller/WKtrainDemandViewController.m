//
//  WKtrainDemandViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/22.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKtrainDemandViewController.h"
#import "WKTrainDemandCell.h"
#import "UIViewController+GYDNav.h"

@interface WKtrainDemandViewController ()

@end

@implementation WKtrainDemandViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"火车票查询";
    
    self.d_navBarAlpha = 1;
    
//    [self setRightBtnImage:@"icon_search"];
    [self setRightBtnTitle:@"右边右边"];
    
    [self addTableView];

    UINib *nib = [UINib nibWithNibName:@"WKTrainDemandCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
    [self addTableViewFootererRefreshing];
}

- (void)tableViewHeaderReloadData{
    self.mPage = 1;
    [self.tableArr removeAllObjects];
    NSMutableArray *mArr = [NSMutableArray new];
    for (int i = 0; i<2; i++) {
        [mArr addObject:[NSString stringWithFormat:@"第%d行   查询",i]];
    }
    [self.tableArr addObjectsFromArray:mArr];
    [self.tableView reloadData];

}
- (void)tableViewFooterReloadData{
    self.mPage++;
    NSMutableArray *mArr = [NSMutableArray new];
    for (int i = 0; i<2; i++) {
        [mArr addObject:[NSString stringWithFormat:@"第%d行   查询",i]];
    }
    [self.tableArr addObjectsFromArray:mArr];
    [self.tableView reloadData];

}
- (void)rightBtnAction{
    MLLog(@"dasdasd");
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
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.tableArr.count;

}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKTrainDemandCell  *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.mName.text = self.tableArr[indexPath.row];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}
@end
