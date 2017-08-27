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

#import <LKDBHelper.h>
#import <AVFoundation/AVSpeechSynthesis.h>
#import "WKLoginViewController.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,AVSpeechSynthesizerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;

@end

@implementation ViewController
{
    AVSpeechSynthesizer *AVOice;
    HDAlertView *alertView;
    
    NSMutableArray *mTableArr;
}
@synthesize mTableView;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"首页";
    
    mTableArr = [NSMutableArray new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(getPushMessage:)
                                                 name:KAppFetchJPUSHService
                                               object:nil];
    mTableView.delegate = self;
    mTableView.dataSource = self;
    mTableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    UINib   *nib = [UINib nibWithNibName:@"WKHomeTableViewCell" bundle:nil];
    [self.mTableView registerNib:nib forCellReuseIdentifier:@"cell"];
    
    self.view.backgroundColor = [UIColor colorWithRed:0.949019607843137 green:0.949019607843137 blue:0.949019607843137 alpha:1.00];
    
    
    

    
    
    mTableArr = [WKHomeModel searchWithWhere:[NSString stringWithFormat:@"mId=1"]];
    
    [mTableView reloadData];
    
    WKLoginViewController *vc = [[WKLoginViewController alloc] initWithNibName:@"WKLoginViewController" bundle:nil];
    
    [self presentViewController:vc animated:YES completion:nil];
}
- (IBAction)mClearndata:(id)sender {
    if (mTableArr.count<=0) {
        [SVProgressHUD showErrorWithStatus:@"没有数据!"];
    }else{
        [self AlertViewShow:@"提示" alertViewMsg:@"确定要清空数据吗？" alertViewCancelBtnTiele:@"取消" alertTag:10];
    }
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
    alertView = [HDAlertView alertViewWithTitle:@"提示" andMessage:mText];
    
    [alertView addButtonWithTitle:@"知道了" type:HDAlertViewButtonTypeDefault handler:^(HDAlertView *alertView) {
        NSLog(@"知道了");
        
    }];
    
    
    [alertView show];
    [self performSelector:@selector(dissmissAlert) withObject:nil afterDelay:10];
    
    if ([AVOice isPaused]) {
        [AVOice continueSpeaking];
    }else{
        AVOice = [[AVSpeechSynthesizer alloc] init];
        AVOice.delegate = self;
        
        AVSpeechUtterance*utterance = [[AVSpeechUtterance alloc]initWithString:mText];//需要转换的文字
        
        utterance.rate=0.5;// 设置语速，范围0-1，注意0最慢，1最快；AVSpeechUtteranceMinimumSpeechRate最慢，AVSpeechUtteranceMaximumSpeechRate最快
        
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
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return mTableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cell";
    
    WKHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setMHome:mTableArr[indexPath.row]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 75;
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
@end
