//
//  WKJoinusApplyViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/17.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKJoinusApplyViewController.h"

#import "WKJoinProgressView.h"
@interface WKJoinusApplyViewController ()<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *mNameTx;
@property (weak, nonatomic) IBOutlet UITextField *mPhoneTx;
@property (weak, nonatomic) IBOutlet UITextField *mBuildingNumTx;
@property (weak, nonatomic) IBOutlet UIButton *mManBtn;
@property (weak, nonatomic) IBOutlet UIButton *mWomen;
@property (weak, nonatomic) IBOutlet UIButton *mCommitBtn;

@end

@implementation WKJoinusApplyViewController
{
    NSMutableArray *mSexArr;
    
    WKJoinProgressView *mView;
    
    MWJoinUsObj *mJoinUs;
    
    NSInteger mSex;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"加入我们";
    mSex = 0;
    mJoinUs = [MWJoinUsObj new];
    mSexArr = [NSMutableArray new];
    [self.mCommitBtn setButtonRoundedCornersWithView:self.view andCorners:UIRectCornerAllCorners radius:3.0];
    
    self.mPhoneTx.delegate = self;
    [self initSucessView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)mSelectedSexAction:(UIButton *)sender {
    [mSexArr removeAllObjects];
    
    switch (sender.tag) {
        case 1:
        {
        if (sender.selected == NO) {
            self.mManBtn.selected = YES;
            self.mWomen.selected = NO;
            
            [mSexArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
        }else{
            
            sender.selected = NO;
            [mSexArr removeAllObjects];
        }

        }
            break;
        case 2:
        {
        if (sender.selected == NO) {
            self.mManBtn.selected = NO;
            self.mWomen.selected = YES;
            
            [mSexArr addObject:[NSString stringWithFormat:@"%ld",(long)sender.tag]];
            
        }else{
            
            sender.selected = NO;
            [mSexArr removeAllObjects];
        }
        }
            break;
            
        default:
            break;
    }
    NSInteger mtype = 0;
    
    if (mSexArr.count>0) {
        mtype = [[NSString stringWithFormat:@"%@",mSexArr[0]] integerValue];
    }else{
        mtype = 0;
    }
    mSex = mtype;

}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)mcommitAction:(id)sender {
    
    [SVProgressHUD showWithStatus:@"正在提交中..."];
    if (self.mNameTx.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的姓名！"];
        return;
    }
    if (self.mPhoneTx.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的联系方式！"];
        return;
    }
    if (![Util isMobileNumber:self.mPhoneTx.text]) {
        [SVProgressHUD showErrorWithStatus:@"请输入正确的手机号码！"];
        return;
    }
    if (self.mBuildingNumTx.text.length==0) {
        [SVProgressHUD showErrorWithStatus:@"请输入您的楼栋编号！"];
        return;
    }
    if (mSex==0) {
        [SVProgressHUD showErrorWithStatus:@"请选择您的性别！"];
        return;
    }
    [MWBaseObj MWApplyJoinUs:@{@"member_id":[WKUser currentUser].member_id,@"user_name":self.mNameTx.text,@"mobile":self.mPhoneTx.text,@"building_num":self.mBuildingNumTx.text,@"sex":[NSString stringWithFormat:@"%ld",(long)mSex],@"join_list_id":_mJoinObj.join_id} block:^(MWBaseObj *info) {
        if (info.err_code == 0) {
            [SVProgressHUD showSuccessWithStatus:info.err_msg];
            [self showSucessView];
        }else{
            [SVProgressHUD showErrorWithStatus:info.err_msg];
        }
        [SVProgressHUD dismiss];
    }];
}

#pragma mark----****----提交成功view
- (void)initSucessView{
    mView = [WKJoinProgressView initView];
//    mView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height);
    mView.alpha = 0;
    [mView.mBackBtn addTarget:self action:@selector(mReturnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mView];
    
    [mView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view).offset(0);
    }];
}
- (void)showSucessView{
    [UIView animateWithDuration:0.25 animations:^{
        mView.alpha = 1;

        CGRect mF = mView.frame;
        mF.origin.y = 64;
        mView.frame = mF;
    }];

}
- (void)hiddenSucessView{
    [UIView animateWithDuration:0.25 animations:^{
        mView.alpha = 1;
        CGRect mF = mView.frame;
        mF.origin.y = DEVICE_Height;
        mView.frame = mF;
    }];
}

- (void)WKWashPayResultViewWithBackAction{
    [self hiddenSucessView];
}
- (void)mBackAction{
    [self WKWashPayResultViewWithBackAction];
    
    [self popViewController];
    
}
- (void)mReturnAction{
    MLLog(@"返回");
    [self popViewController_2];
}
///限制电话号码输入长度
#define TEXT_MAXLENGTH 11
///密码输入长度
#define PASS_LENGHT 20
#define CODE_LENGTH 6

#pragma mark **----键盘代理方法
-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *new = [textField.text stringByReplacingCharactersInRange:range withString:string];
    NSInteger res;
    if (textField.tag==11) {
        res= TEXT_MAXLENGTH-[new length];
        
    }else if(textField.tag == 20)
        {
        res= PASS_LENGHT-[new length];
        
        }
    else {
        res= CODE_LENGTH-[new length];
        
        }
    if(res >= 0){
        return YES;
    }
    else{
        NSRange rg = {0,[string length]+res};
        if (rg.length>0) {
            NSString *s = [string substringWithRange:rg];
            [textField setText:[textField.text stringByReplacingCharactersInRange:range withString:s]];
        }
        return NO;
    }
    
}

@end
