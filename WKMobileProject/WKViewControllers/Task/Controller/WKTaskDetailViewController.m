
//
//  WKTaskDetailViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/14.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTaskDetailViewController.h"
#import "WKTaskDetailCell.h"

#import "WKTaskSectionHeaderView.h"


@interface WKTaskDetailViewController ()

@end

@implementation WKTaskDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSString *mT = nil;
    
    if (_mType == WKTaskDetail) {
        mT = @"任务详情";
    }else{
     mT = @"活动详情";
    }
    
    self.navigationItem.title = mT;
    
    [self addTableView];
    
    UINib   *nib = [UINib nibWithNibName:@"WKTaskDetailCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    [self addTableViewHeaderRefreshing];
}
- (void)tableViewHeaderReloadData{

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
    if (_mType == WKTaskDetail) {
        return 1;
    }else{
        return 2;
    }
    
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (_mType == WKTaskDetail) {
        return 125;
    }else{
        if (section == 0) {
            return 150;
        }else{
            return 80;
        }
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_mType == WKTaskDetail) {
        return 4;
    }else{
        if (section == 0) {
            return 0;
        }else{
            return 4;
        }
        
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (_mType == WKTaskDetail) {
        WKTaskSectionHeaderView *mHeaderView = [WKTaskSectionHeaderView initView];
        
        return mHeaderView;
    }else{
        if (section == 0) {
            _mScrollerView = [[RKImageBrowser alloc] initWithFrame:CGRectMake(0, 0, screen_width, 150)];
            _mScrollerView.backgroundColor = [UIColor whiteColor];
            [_mScrollerView setBrowserWithImagesArray:@[@"https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1493210044049&di=ac402c2ce8259c98e5e4ea1b7aac4cac&imgtype=0&src=http%3A%2F%2Fimg2.3lian.com%2F2014%2Ff4%2F209%2Fd%2F97.jpg",@"https://ss0.bdstatic.com/94oJfD_bAAcT8t7mm9GUKT-xh_/timg?image&quality=100&size=b4000_4000&sec=1493199772&di=66346cd79eed9c8cb4ec03c3734d0b31&src=http://img15.3lian.com/2015/f2/128/d/123.jpg",@"http://wmtp.net/wp-content/uploads/2017/04/0420_sweet945_1.jpeg",@"http://wmtp.net/wp-content/uploads/2017/04/0407_shouhui_1.jpeg"]];
            __weak __typeof(self)weakSelf = self;
            
            _mScrollerView.didselectRowBlock = ^(NSInteger clickRow) {
                MLLog(@"333点击了图片%ld", clickRow);
   
            };
            
            return _mScrollerView;
        }else{
            WKTaskSectionHeaderView *mHeaderView = [WKTaskSectionHeaderView initActivityView];
            
            return mHeaderView;
        }
        
    }
 

}
-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    if (_mType == WKTaskDetail) {
        UIView *mFootView = [UIView new];
        mFootView.frame = CGRectMake(0, 0, DEVICE_Width, 80);
        mFootView.backgroundColor = [UIColor colorWithRed:0.952941176470588 green:0.968627450980392 blue:0.992156862745098 alpha:1.00];
        
        UIButton *mCommitBtn = [UIButton new];
        mCommitBtn.frame = CGRectMake(0, 30, DEVICE_Width, 50);
        [mCommitBtn setTitle:@"领取任务" forState:0];
        [mCommitBtn setBackgroundColor:[UIColor colorWithRed:0.976470588235294 green:0.596078431372549 blue:0.27843137254902 alpha:1.00]];
        [mCommitBtn addTarget:self action:@selector(mFetchTaskAction:) forControlEvents:UIControlEventTouchUpInside];
        [mFootView addSubview:mCommitBtn];
        return mFootView;
    }else{
        return nil;
    }

    
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (_mType == WKTaskDetail) {
        return 80;

    }else{
        return 0;
    }
}
- (void)mFetchTaskAction:(UIButton *)sender{

    MLLog(@"领取任务");
    [WKProgressView WKShowView:self.view andStatus:WKProgressSucess WithTitle:@"成功" andContent:@"这是什么？" andBtnTitle:@"重新加载" andImgSRC:@"icon_paysucess" andBlock:^(WKProgressView *progressView, NSInteger btnIndex) {
        MLLog(@"%ld",btnIndex);
        
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    return 90;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    reuseCellId = @"cell";
    
    WKTaskDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (_mType == WKTaskDetail) {
        cell.backgroundColor = [UIColor whiteColor];
        cell.mLine.hidden = YES;
        
    }else{
        cell.backgroundColor = [UIColor colorWithRed:0.952941176470588 green:0.968627450980392 blue:0.992156862745098 alpha:1.00];
        cell.mLine.hidden = NO;
    }
    return cell;

    
}

@end
