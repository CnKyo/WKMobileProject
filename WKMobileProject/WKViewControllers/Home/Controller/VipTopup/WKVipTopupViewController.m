//
//  WKVipTopupViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/15.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKVipTopupViewController.h"
#import "WKTopupHeaderView.h"
#import "WKTopupCollectionReusableView.h"
#import "WKTopupCollectionViewCell.h"
#import "WKPayVIPTopupViewController.h"
@interface WKVipTopupViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,WKTopupHeaderViewDelegate>
@property(strong,nonatomic) UICollectionView *mCollectionView;

@end

@implementation WKVipTopupViewController
{
    WKTopupHeaderView *mHeaderView;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"上网产品";
    self.view.backgroundColor = [UIColor colorWithRed:0.956862745098039 green:0.972549019607843 blue:0.996078431372549 alpha:1.00];
    mHeaderView = [WKTopupHeaderView initview];
//    mHeaderView.frame = CGRectMake(0, 64, DEVICE_Width, 180);
    mHeaderView.delegate  = self;
    [self.view addSubview:mHeaderView];

    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
//    self.mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, DEVICE_Width, DEVICE_Height-460) collectionViewLayout:flowLayout];
    self.mCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 200, DEVICE_Width, DEVICE_Height-460) collectionViewLayout:flowLayout];

//    self.mCollectionView = [[UICollectionView alloc] init];
//    self.mCollectionView.collectionViewLayout = flowLayout;
    [self.mCollectionView registerClass:[WKTopupCollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    
    self.mCollectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:self.mCollectionView];
    
    self.mCollectionView.dataSource = self;
    self.mCollectionView.delegate = self;
    [self.mCollectionView registerClass:[WKTopupCollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header"];
    
    UIButton *mCommitBtn = [UIButton new];
    mCommitBtn.frame = CGRectMake(DEVICE_Width/2-80, DEVICE_Height-80, 160, 45);
    [mCommitBtn setTitle:@"提交订单" forState:0];
    mCommitBtn.backgroundColor = [UIColor colorWithRed:0.972549019607843 green:0.584313725490196 blue:0.270588235294118 alpha:1.00];
    [mCommitBtn addTarget:self action:@selector(mCommitAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mCommitBtn];
    [mCommitBtn setButtonRoundedCornersWithView:self.view andCorners:UIRectCornerAllCorners radius:3.0];
    
    [mHeaderView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(64);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.mCollectionView.mas_top);
        make.height.offset(180);
    }];
    
    [self.mCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(mHeaderView.mas_bottom);
        
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-125);
        
    }];
    

    
}
#pragma mark----****----去支付按钮
- (void)mCommitAction{
    MLLog(@"提交");
    WKPayVIPTopupViewController *vc = [WKPayVIPTopupViewController new];
    [self pushViewController:vc];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 26;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    WKTopupCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    cell.mBgk.backgroundColor = M_CO;
    cell.mName.text = @"365天黄金会员（0.1折）";
    cell.mPrice.text = @"25.0元";
    return cell;
}


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionReusableView *reusable = nil;
    if (kind == UICollectionElementKindSectionHeader) {
        
        WKTopupCollectionReusableView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"Header" forIndexPath:indexPath];
        view.title.text = [[NSString alloc] initWithFormat:@"头部视图%ld",indexPath.section];
        reusable = view;
    }
    return reusable;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *message = [[NSString alloc] initWithFormat:@"你点击了第%ld个section，第%ld个cell",(long)indexPath.section,(long)indexPath.row];
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        //点击确定后执行的操作；
    }]];
    [self presentViewController:alert animated:true completion:^{
        //显示提示框后执行的事件；
    }];
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake((SCREEN_WIDTH - 80) / 3, (SCREEN_WIDTH - 80) / 3 + 20);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    return UIEdgeInsetsMake(20, 20, 10, 20);
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    return CGSizeMake(300, 20);
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
/**
 充值账号输入代理
 
 @param mText 返回文本
 */
- (void)WKTopupHeaderViewDelegateWithTextFieldEndEdit:(NSString *)mText{
    MLLog(@"文本内容是:%@",mText);
}
///通讯录代理方法（为他人充值）
- (void)WKTopupHeaderViewDelegateWithAddressBookBtnClicked{
    MLLog(@"通讯录");
}
@end
