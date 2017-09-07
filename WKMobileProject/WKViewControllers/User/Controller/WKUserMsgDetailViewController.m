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
    cell.mContent.text = @"编者按：近来网络上热议的有关谋生、生育、养老的话题其实都多多少少跟社会的老龄化和不均衡的人口结构相关。无论是“为了下一代死守北上广”还是“是否应该开放代孕”，都包含着深深的担忧和无奈。日本人比中国人更早遇到这些问题，也警醒得更早。听过这些日本老人的故事之后，你又有哪些想法呢？欢迎分享到评论区";
    return cell;
}



@end
