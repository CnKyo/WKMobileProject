//
//  WKMyWashDetailViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyWashDetailViewController.h"
#import "MyWashDetailCell.h"
@interface WKMyWashDetailViewController ()

@end

@implementation WKMyWashDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"我的洗衣";
    
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"MyWashDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    [self addTableViewHeaderRefreshing];
}
- (void)tableViewHeaderReloadData{
    MLLog(@"刷头");
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
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 600;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    MyWashDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

@end
