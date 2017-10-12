//
//  WKRegistViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKRegistViewController.h"
#import "WKHeader.h"
#import "WKRegistCell.h"
#import "WKBundlePersonMsgViewController.h"
@interface WKRegistViewController ()<UITableViewDelegate,UITableViewDataSource,WKRegistCellDelegate>
@property (strong,nonatomic) UITableView *tableView;

@end

@implementation WKRegistViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"注册";

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
    
    UINib   *nib = [UINib nibWithNibName:@"WKRegistCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
   
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
        return 600;

}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
   
        CellId = @"cell";
    WKRegistCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];

        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.delegate = self;
        return cell;
   
    
}
/**
 按钮代理方法
 
 @param mTag 0:验证码。1:注册。2:去登录
 */
- (void)WKRegistCellDelegateBtnActions:(NSInteger)mTag{
    switch (mTag) {
        case 0:
            {
                
                
            }
            break;
        case 1:
        {
        WKBundlePersonMsgViewController *vc = [WKBundlePersonMsgViewController new];
//        [self.navigationController pushViewController:vc animated:YES];
        [self presentViewController:vc animated:YES completion:nil];

        }
            break;
        case 2:
        {
        [self dismissViewControllerAnimated:YES completion:nil];

        
        }
            break;
            
        default:
            break;
    }
    
}
@end
