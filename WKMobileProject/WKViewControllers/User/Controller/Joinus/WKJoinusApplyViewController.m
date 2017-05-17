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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = @"加入我们";
    
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
    [self showSucessView];
}

#pragma mark----****----提交成功view
- (void)initSucessView{
    mView = [WKJoinProgressView initView];
    mView.frame = CGRectMake(0, DEVICE_Height, DEVICE_Width, DEVICE_Height);
    [mView.mBackBtn addTarget:self action:@selector(mReturnAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:mView];
}
- (void)showSucessView{
    [UIView animateWithDuration:0.25 animations:^{
        CGRect mF = mView.frame;
        mF.origin.y = 64;
        mView.frame = mF;
    }];

}
- (void)hiddenSucessView{
    [UIView animateWithDuration:0.25 animations:^{
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
