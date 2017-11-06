//
//  WKEditUserinfoViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/5/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKEditUserinfoViewController.h"
#import "WKEditUserInfoCell.h"
#import "WKChangeUserInfoViewController.h"

#import <RSKImageCropper/RSKImageCropper.h>
#import <TZImagePickerController.h>
#import <BGFMDB.h>

@interface WKEditUserinfoViewController ()<WKEditUserInfoCellDelegate,TZImagePickerControllerDelegate>

@end

@implementation WKEditUserinfoViewController
{
    
    UIImage *mHeaderImg;
    ZLPlafarmtLogin *mUserInfo;

}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"个人中心";
    mHeaderImg = [UIImage new];
    [self addTableView];
    UINib   *nib = [UINib nibWithNibName:@"WKEditUserInfoCell" bundle:nil];
    [self.tableView registerNib:nib forCellReuseIdentifier:@"cell"];
    NSArray *mUserArr = [ZLPlafarmtLogin bg_findAll];
    
    if (mUserArr.count>0) {
        mUserInfo = mUserArr[0];
        MLLog(@"接档用户信息是：%@",mUserArr);
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark -- tableviewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView              // Default is 1 if not implemented
{
    
    return 1;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 600;
 
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *reuseCellId = nil;
    
    
    reuseCellId = @"cell";
    
    WKEditUserInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseCellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.delegate = self;
    [cell setMUserInfo:mUserInfo];
    return cell;
   
    
    
    
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
 修改用户信息界面按钮点击代理方法
 
 @param mType 选择的按钮类型（1头像，2用户名，3手机号，4真实信息，5证件号，6登录密码，7退出登录）
 */
- (void)WKEditUserInfoCellDelegateWithBtnClicked:(WKEditUserInfoClicked)mType{
    MLLog(@"点击了%ld",mType);
    if (mType == 2) {
        WKChangeUserInfoViewController *vc = [WKChangeUserInfoViewController new];
        vc.mType = WKChangeNormalInfo;
        [self pushViewController:vc];
    }else if (mType == 6){
        WKChangeUserInfoViewController *vc = [WKChangeUserInfoViewController new];
        vc.mType = WKChangePwd;
        [self pushViewController:vc];
    }
    else if (mType == 1){
        TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:1 delegate:self];
        
        // You can get the photos by block, the same as by delegate.
        // 你可以通过block或者代理，来得到用户选择的照片.
        [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
            
        }];
        [self presentViewController:imagePickerVc animated:YES completion:nil];
        
    }else{
    
    }
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto{
    
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray<UIImage *> *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto infos:(NSArray<NSDictionary *> *)infos{
    
}
//- (void)imagePickerControllerDidCancel:(TZImagePickerController *)picker __attribute__((deprecated("Use -tz_imagePickerControllerDidCancel:.")));
- (void)tz_imagePickerControllerDidCancel:(TZImagePickerController *)picker{
    
}

// If user picking a video, this callback will be called.
// If system version > iOS8,asset is kind of PHAsset class, else is ALAsset class.
// 如果用户选择了一个视频，下面的handle会被执行
// 如果系统版本大于iOS8，asset是PHAsset类的对象，否则是ALAsset类的对象
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingVideo:(UIImage *)coverImage sourceAssets:(id)asset{
    
}

// If user picking a gif image, this callback will be called.
// 如果用户选择了一个gif图片，下面的handle会被执行
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingGifImage:(UIImage *)animatedImage sourceAssets:(id)asset{
    
}
@end
