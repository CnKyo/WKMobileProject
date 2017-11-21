//
//  ViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/7.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "ViewController.h"
#import "WKHeader.h"
#import "WKHomeTableViewCell.h"
#import <BAButton.h>
#import <LKDBHelper.h>
#import <AVFoundation/AVSpeechSynthesis.h>
#import "WKLoginViewController.h"
#import "WKNavLeftView.h"
#import "WKHomeStatusCell.h"
#import "WKCameraViewController.h"
#import "WKAddDeviceViewController.h"

#import "WKStatusTableViewCell.h"
#import "WKSegmentControl.h"
#import "WKWarningTableViewCell.h"

#import "WKDeviceListViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,AVSpeechSynthesizerDelegate,UIAlertViewDelegate,WKNavLeftViewDelegate,WKHomeStatusCellDelegate,WKSegmentControlDelagate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ViewController
{
    AVSpeechSynthesizer *AVOice;
    HDAlertView *alertView;
    
    NSMutableArray *mTableArr;
    NSArray *mSTableArr;

    WKNavLeftView *mNavLView;
    
    WKSegmentControl *mSegmentView;
    
    NSInteger mType;

}
@synthesize mTableView;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"状态";
    [mTableArr addObject:[NSString stringWithFormat:@"https://tbm.alicdn.com/Y73o4CKjm22oPjIGMxw/7149iEtPiobvJOHhfVz%40%40ld.mp4"]];
    [mTableArr addObject:[NSString stringWithFormat:@"https://tbm.alicdn.com/Y73o4CKjm22oPjIGMxw/7149iEtPiobvJOHhfVz%40%40ld.mp4"]];
    mSTableArr = @[@"1号蜂巢",@"2号蜂巢"];
    [self initNavLeftView];

    mTableArr = [NSMutableArray new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getPushMessage:)
                                                 name:KAppFetchJPUSHService
                                               object:nil];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    mTableView.backgroundColor = [UIColor colorWithRed:0.96 green:0.97 blue:0.98 alpha:1];
//    UINib   *nib = [UINib nibWithNibName:@"WKHomeStatusCell" bundle:nil];
//    [self.mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    
    UINib   *nib = [UINib nibWithNibName:@"WKStatusTableViewCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    nib = [UINib nibWithNibName:@"WKWarningTableViewCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"cell2"];
    
    
    self.view.backgroundColor = [UIColor colorWithRed:0.949019607843137 green:0.949019607843137 blue:0.949019607843137 alpha:1.00];

    mTableArr = [WKHomeModel searchWithWhere:[NSString stringWithFormat:@"mId=1"]];
    
    [mTableView reloadData];
    
    WKLoginViewController *vc = [[WKLoginViewController alloc] initWithNibName:@"WKLoginViewController" bundle:nil];
    
    [self presentViewController:vc animated:YES completion:nil];
    
    mSegmentView = [WKSegmentControl initWithSegmentControlFrame:CGRectMake(0, 0, DEVICE_Width, 50) andTitleWithBtn:@[@"蜂巢列表",@"蜂巢预警"] andBackgroudColor:[UIColor whiteColor] andBtnSelectedColor:[UIColor colorWithRed:0.23 green:0.54 blue:0.89 alpha:1] andBtnTitleColor:[UIColor blackColor] andUndeLineColor:[UIColor colorWithRed:0.23 green:0.54 blue:0.89 alpha:1] andBtnTitleFont:[UIFont systemFontOfSize:15] andInterval:5 delegate:self andIsHiddenLine:YES andType:4];
    
}
- (void)initNavLeftView{
    
//    mNavLView = [WKNavLeftView initView];
//    mNavLView.frame = CGRectMake(0, 20, 124, 44);
//    mNavLView.delegate = self;
//
//    self.navigationItem.titleView = mNavLView;
    
    //    UIBarButtonItem *releaseButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mNavLView];
    //    self.navigationItem.leftBarButtonItem = releaseButtonItem;
    CGRect frame = CGRectMake(0, 0, 150, 40);
    CGRect mRFrame = CGRectMake(DEVICE_Width-80, 0, 80, 40);


    UIButton *mNavLeftBtn = [UIButton ba_creatButtonWithFrame:frame title:@"重庆 小雨 15℃" selTitle:nil titleColor:[UIColor colorWithRed:0.223529411764706 green:0.533333333333333 blue:0.886274509803922 alpha:1.00] titleFont:[UIFont systemFontOfSize:14] image:[UIImage imageNamed:@"icon_littleRing"] selImage:nil padding:2 buttonPositionStyle:BAKit_ButtonLayoutTypeLeftImageLeft viewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:0 target:self selector:@selector(handleLeftNaviButtonAction:)];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mNavLeftBtn];
    
    UIButton *mRightBtn = [UIButton ba_creatButtonWithFrame:mRFrame title:@"+添加蜂眼" selTitle:nil titleColor:[UIColor colorWithRed:0.223529411764706 green:0.533333333333333 blue:0.886274509803922 alpha:1.00] titleFont:[UIFont systemFontOfSize:14] image:nil selImage:nil padding:2 buttonPositionStyle:BAKit_ButtonLayoutTypeCenterImageRight viewRectCornerType:BAKit_ViewRectCornerTypeAllCorners viewCornerRadius:20 target:self selector:@selector(handleRightNaviButtonAction:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:mRightBtn];
    
}
- (void)handleLeftNaviButtonAction:(UIButton *)sender{
    
    MLLog(@"左边的天气");
}
- (void)handleRightNaviButtonAction:(UIButton *)sender{
    
    MLLog(@"左边的添加");
    WKAddDeviceViewController *vc = [WKAddDeviceViewController new];
    vc.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:vc animated:YES];
}
- (void)WKNavLeftViewDelegateWithBtnAction{
    
    MLLog(@"左边的天气");
}

- (void)AlertViewShow:(NSString *)alerViewTitle alertViewMsg:(NSString *)msg alertViewCancelBtnTiele:(NSString *)cancelTitle alertTag:(int)tag{
    
    UIAlertView* al = [[UIAlertView alloc] initWithTitle:alerViewTitle message:msg delegate:self cancelButtonTitle:cancelTitle otherButtonTitles:@"确定", nil];
    al.delegate = self;
    al.tag = tag;
    [al show];
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    
    if( buttonIndex == 1)
        {
        [WKHomeModel deleteWithWhere:[NSString stringWithFormat:@"1"]];
        [mTableArr removeAllObjects];
        [mTableView reloadData];
        
        }
    
    
}
- (void)getPushMessage:(NSNotification *)notification{
    NSDictionary * infoDic = notification.object;
    WKJPushObj *mJpush = [WKJPushObj mj_objectWithKeyValues:[infoDic objectForKey:@"pushObj"]];
    
    WKHomeModel *mHome = [WKHomeModel new];
    mHome.mId = 1;
    mHome.mName = mJpush.aps.alert;
    mHome.mPrice = mJpush.price;
    mHome.mTime = mJpush.time;
    mHome.mNo+=1;
    [mHome saveToDB];
    
    mTableArr = [WKHomeModel searchWithWhere:[NSString stringWithFormat:@"mId=1"]];
    
    [mTableView reloadData];
    
    [self palyVoice:mJpush.aps.alert];
}
- (void)palyVoice:(NSString *)mText{
//    alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:mText];
//
//    [alertView addButtonWithTitle:@"知道了" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
//        NSLog(@"知道了");
//
//    }];
//
//
//    [alertView show];
    [self performSelector:@selector(dissmissAlert) withObject:nil afterDelay:10];
    
    if ([AVOice isPaused]) {
        [AVOice continueSpeaking];
    }else{
        AVOice = [[AVSpeechSynthesizer alloc] init];
        AVOice.delegate = self;
        
        AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:mText];//需要转换的文字
        
        utterance.rate=0.4;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
        
        AVSpeechSynthesisVoice*voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];//设置发音，这是中文普通话
        
        
        utterance.voice= voice;
        
        [AVOice speakUtterance:utterance];//开始
        
        
    }
    
}
- (void)dissmissAlert{
    [alertView removeAlertView];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 1;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    return mSegmentView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 50;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (mType == 0) {
        return mSTableArr.count;
    }else{
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (mType == 0) {
        NSString *cellId = @"cell";
        
        WKStatusTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        //    cell.delegate = self;
        //    cell.mIndexPath = indexPath;
        cell.mName.text = mSTableArr[indexPath.row];
        return cell;
    }else{
        
        NSString *cellId = @"cell2";
        
        WKWarningTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
  
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (mType == 0) {
        WKDeviceListViewController *vc = [WKDeviceListViewController new];
        //        WKCameraViewController *vc = [WKCameraViewController new];
        //        vc.mUrlString = @"https://tbm.alicdn.com/Y73o4CKjm22oPjIGMxw/7149iEtPiobvJOHhfVz%40%40ld.mp4";
//        https://cloud.video.taobao.com/play/u/3257655479/p/1/e/6/t/1/50008124793.mp4
        
        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (mType == 0) {
        return 130;
    }else{
        return 120;
    }
    
}
#pragma mark----****----这是语音代理方法
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didStartSpeechUtterance:(AVSpeechUtterance*)utterance{
    NSLog(@"---开始播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didFinishSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---完成播放");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didPauseSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---播放中止");
    
}
- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didContinueSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---恢复播放");
    
}

- (void)speechSynthesizer:(AVSpeechSynthesizer*)synthesizer didCancelSpeechUtterance:(AVSpeechUtterance*)utterance{
    
    NSLog(@"---播放取消");
    
}
- (void)WKHomeStatusCellDelegateWithBtnAction:(NSInteger)mTag withIndexPath:(NSIndexPath *)mIndexPath{

    
    switch (mTag) {
        case 0:
            {
                
            [self palyVoice:@"1号蜂巢。今天是9月28。农历八月初九。气温25度。天气。晴。空气质量。优。风向。西北风。报警状态。正常"];
            }
            break;

        case 1:
        {
        
        WKDeviceListViewController *vc = [WKDeviceListViewController new];
//        WKCameraViewController *vc = [WKCameraViewController new];
//        vc.mUrlString = @"https://tbm.alicdn.com/Y73o4CKjm22oPjIGMxw/7149iEtPiobvJOHhfVz%40%40ld.mp4";

        vc.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
    
}
///选择了哪一个？
- (void)WKDidSelectedIndex:(NSInteger)mIndex{
    MLLog(@"%ld",mIndex);
    mType = mIndex;
    [mTableView reloadData];
}
@end
