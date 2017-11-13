//
//  WKUserMsgDetailViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/9/7.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKUserMsgDetailViewController.h"
#import <UITableView+FDTemplateLayoutCell.h>
#import "WKUserMsgDetailCell.h"
@interface WKUserMsgDetailViewController ()

@end

@implementation WKUserMsgDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"消息详情";

    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKUserMsgDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.tableView.estimatedRowHeight = 88;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.backgroundColor = [UIColor colorWithRed:0.956862745098039 green:0.972549019607843 blue:0.996078431372549 alpha:1.00];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    WKUserMsgDetailCell * cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    cell.mTime.text = _mMsg.title;
    
    cell.mContent.text = _mMsg.content;
    return cell;
}



@end
