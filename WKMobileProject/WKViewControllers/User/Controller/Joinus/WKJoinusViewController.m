//
//  WKJoinusViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKJoinusViewController.h"
#import "WKJoinusCell.h"
#import "WKJoinusHeaderFooterSectionView.h"
#import "WKJoinusApplyViewController.h"
@interface WKJoinusViewController ()

@end

@implementation WKJoinusViewController
{

    WKJoinusHeaderFooterSectionView *mHeaderView;
    WKJoinusHeaderFooterSectionView *mFooterView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"加入我们";
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKJoinusCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];

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
    return 4;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
        return 80;
     
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 80;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    
    mHeaderView = [WKJoinusHeaderFooterSectionView initHeaderView];
    return mHeaderView;
    
    
}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    mFooterView = [WKJoinusHeaderFooterSectionView initFooterView];
    [mFooterView.mJoinBtn addTarget:self action:@selector(joinAction) forControlEvents:UIControlEventTouchUpInside];
    return mFooterView;
}
-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    
    reuseCellId = @"cell";
    
    WKJoinusCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    
    return cell;
    
    
    
    
}

- (void)joinAction{
    MLLog(@"加入我们");
    WKJoinusApplyViewController *vc = [[WKJoinusApplyViewController alloc] initWithNibName:@"WKJoinusApplyViewController" bundle:nil];
    [self pushViewController:vc];
}
@end
