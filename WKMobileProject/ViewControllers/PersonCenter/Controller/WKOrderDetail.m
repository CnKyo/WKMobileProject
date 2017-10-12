//
//  WKOrderDetail.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKOrderDetail.h"
#import "WKHeader.h"
#import "WKOrderDetailCell.h"
#import "WKHomeOrderDetailCell.h"
@interface WKOrderDetail ()

@end

@implementation WKOrderDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setMTitle:@"订单详情"];
    [self addTableView];
    // Do any additional setup after loading the view.
    UINib   *nib = [UINib nibWithNibName:@"WKHomeOrderDetailCell" bundle:nil];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    return 668;
    
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    CellId = @"cell";
    
    WKHomeOrderDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
    
    
}
@end
