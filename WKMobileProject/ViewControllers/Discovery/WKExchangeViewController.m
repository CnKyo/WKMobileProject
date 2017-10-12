//
//  WKExchangeViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKExchangeViewController.h"
#import "WKHeader.h"
#import "WKExchangeCell.h"
#import "WKExchangeBarcodeView.h"
@interface WKExchangeViewController ()
<UITableViewDelegate,UITableViewDataSource>
@property (strong,nonatomic) UITableView *tableView;
@end

@implementation WKExchangeViewController

{
    WKExchangeBarcodeView *mPopView;
    NSMutableArray *mTableArr;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"交流群";
    
    mTableArr = [NSMutableArray new];
    [self initView];
    [self initPopView];
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
    
    UINib   *nib = [UINib nibWithNibName:@"WKExchangeCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
        make.height.equalTo(self.view.mas_height);
    }];
    
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
    
    return 3;
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 90;
    
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellId = nil;
    
    CellId = @"cell";
    
    WKExchangeCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    MLLog(@"点击了第：%ld",indexPath.row);
    [self showPopView];
}

- (void)initPopView{
    mPopView = [WKExchangeBarcodeView initView];
    mPopView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height);
    [mPopView.mDissMissBTn addTarget:self action:@selector(dismissAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mPopView];
}
- (void)showPopView{
    
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mRRR = mPopView.frame;
        mRRR.origin.y = 0;
        mPopView.frame = mRRR;
    }];
}
- (void)dismissAction{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mRRR = mPopView.frame;
        mRRR.origin.y = DEVICE_Height;
        mPopView.frame = mRRR;
    }];
    
}
@end
