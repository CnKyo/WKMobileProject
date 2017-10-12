//
//  WKBundlePersonMsgViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBundlePersonMsgViewController.h"
#import "WKBundlePersonMsgCell.h"
#import "WKHeader.h"
#import "WKBundleCarCell.h"
#import "WKBundleFinishCell.h"
@interface WKBundlePersonMsgViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@end

@implementation WKBundlePersonMsgViewController
{
    int mType;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人信息";
    mType = 0;
    [self initView];
}
- (void)initView{
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    
    //self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    self.tableView.backgroundColor = COLOR(247, 247, 247);
    
    UINib   *nib = [UINib nibWithNibName:@"WKBundlePersonMsgCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"WKBundleCarCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    
    nib = [UINib nibWithNibName:@"WKBundleFinishCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell3"];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
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
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 700;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    if (mType == 0) {
        CellId = @"cell";
        WKBundlePersonMsgCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.mNextBtn addTarget:self action:@selector(mNextAction) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }else if(mType == 1){
        
        CellId = @"cell2";
        WKBundleCarCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.mFinishBtn addTarget:self action:@selector(mFinishAction) forControlEvents:UIControlEventTouchUpInside];
        return cell;

    }else{
        
        CellId = @"cell3";
        WKBundleFinishCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell.mBackBtn addTarget:self action:@selector(mBackAction) forControlEvents:UIControlEventTouchUpInside];
        return cell;
    }

    
    
}
- (void)mBackAction{
    

        
        [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
- (void)mFinishAction{
    
    MLLog(@"下一步");
    mType = 2;
    [self.tableView reloadData];


    
}
- (void)mNextAction{
    
    MLLog(@"下一步");
    mType = 1;
    [self.tableView reloadData];

}

@end
