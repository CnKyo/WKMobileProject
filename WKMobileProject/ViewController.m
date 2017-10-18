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

#import <BGFMDB.h>
#import <AVFoundation/AVSpeechSynthesis.h>
#import "WKLoginViewController.h"

#import "JWBluetoothManage.h"

#define WeakSelf __block __weak typeof(self)weakSelf = self;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,AVSpeechSynthesizerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSMutableArray *mTableArr;

@property (nonatomic, strong) NSMutableArray * dataSource; //设备列表
@property (nonatomic, strong) NSMutableArray * rssisArray; //信号强度 可选择性使用
@end

@implementation ViewController
{
    AVSpeechSynthesizer *AVOice;
    HDAlertView *alertView;
    
    
    WKHomeModel *mHome;
    
    JWBluetoothManage * manage;

}
@synthesize mTableView;
- (void)viewWillAppear:(BOOL)animated{
    WeakSelf
    [super viewWillAppear:YES];
    [manage autoConnectLastPeripheralCompletion:^(CBPeripheral *perpheral, NSError *error) {
        if (!error) {
            [ProgressShow alertView:self.view Message:@"连接成功！" cb:nil];
            weakSelf.title = [NSString stringWithFormat:@"已连接-%@",perpheral.name];
            dispatch_async(dispatch_get_main_queue(), ^{
//                [weakSelf.mTableView reloadData];
            
            });
        }else{
            [ProgressShow alertView:self.view Message:error.domain cb:nil];
        }
    }];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"首页";

    mHome = [WKHomeModel new];
    _mTableArr = [NSMutableArray new];
    manage = [JWBluetoothManage sharedInstance];
    self.dataSource = @[].mutableCopy;
    self.rssisArray = @[].mutableCopy;
    
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
    
    [_mTableArr addObjectsFromArray:[WKHomeModel bg_findAll]];
    [mTableView reloadData];
    
    WKLoginViewController *vc = [[WKLoginViewController alloc] initWithNibName:@"WKLoginViewController" bundle:nil];
    
    [self presentViewController:vc animated:YES completion:nil];
    [self loadPrinter];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(printe)];

}

- (IBAction)mClearndata:(id)sender {
    if (_mTableArr.count<=0) {
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
        [WKHomeModel bg_clear];
        [_mTableArr removeAllObjects];
        [mTableView reloadData];
        [SVProgressHUD showSuccessWithStatus:@"数据清除成功!"];

        }
    
    
}
- (void)getPushMessage:(NSNotification *)notification{
    NSDictionary * infoDic = notification.object;
    WKJPushObj *mJpush = [WKJPushObj mj_objectWithKeyValues:[infoDic objectForKey:@"pushObj"]];
    
    mHome.mId = 1;
    mHome.mName = mJpush.aps.alert;
    mHome.mPrice = mJpush.price;
    mHome.mTime = mJpush.time;
    mHome.mNo=mJpush.num;
    mHome.mPrint = mJpush.print;
    [mHome bg_save];
    NSArray *mBGFArr = [WKHomeModel bg_findAll];
    if (mBGFArr.count >0) {
        [_mTableArr removeAllObjects];
    }
    [_mTableArr addObjectsFromArray:mBGFArr];
    
    [mTableView reloadData];
    
    [self palyVoice:mJpush.aps.alert];
    if (mHome.mPrint == 0) {
        
    }else{
        [self loadPrinter];
        [self print:mJpush.aps.alert];
    }
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
#pragma mark----****----打印机
- (void)loadPrinter{
    WeakSelf
    [manage beginScanPerpheralSuccess:^(NSArray<CBPeripheral *> *peripherals, NSArray<NSNumber *> *rssis) {
        weakSelf.dataSource = [NSMutableArray arrayWithArray:peripherals];
        weakSelf.rssisArray = [NSMutableArray arrayWithArray:rssis];
        if (self.dataSource.count>0) {
            for (CBPeripheral *peripheral in self.dataSource) {
                if ([peripheral.name isEqualToString:@"Printer001"]) {
                    [manage connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
                        if (!error) {
                            [ProgressShow alertView:self.view Message:@"打印机连接成功！" cb:nil];
                            dispatch_async(dispatch_get_main_queue(), ^{
                                //                            [tableView reloadData];
//                                [weakSelf printe];
                            });
                        }else{
                            [ProgressShow alertView:self.view Message:error.domain cb:nil];
                        }
                    }];
                }
            }
        }
    } failure:^(CBManagerState status) {
        [ProgressShow alertView:self.view Message:[ProgressShow getBluetoothErrorInfo:status] cb:nil];
    }];
//    manage.disConnectBlock = ^(CBPeripheral *perpheral, NSError *error) {
//        MLLog(@"设备已经断开连接！");
//        [SVProgressHUD showErrorWithStatus:@"打印机已经断开连接！"];
//
//    };
    
    
    
}
- (void)print:(id)task{
    if (manage.stage != JWScanStageCharacteristics) {
        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = @"=============银智付=============";
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    [printer appendTitle:@"商户名称：" value:@"永和大豆浆"];
    [printer appendTitle:@"商户编号：" value:@"1234567890"];
    [printer appendTitle:@"订单编号：" value:@"MS1234567890"];
    [printer appendTitle:@"交易类型：" value:@"微信支付"];
    [printer appendTitle:@"交易时间：" value:@"2017-06-14"];
    [printer appendTitle:@"金    额：" value:@"1000元"];
    [printer appendFooter:@"欢迎使用银智付!"];
    [printer appendNewLine];
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            MLLog(@"打印成功");
            [SVProgressHUD showSuccessWithStatus:@"打印成功！"];
        }else{
            MLLog(@"写入错误---:%@",error);
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"写入错误---:%@",error]];
            
            
        }
    }];
}
- (void)printe{
    if (manage.stage != JWScanStageCharacteristics) {
        [ProgressShow alertView:self.view Message:@"打印机正在准备中..." cb:nil];
        return;
    }
    JWPrinter *printer = [[JWPrinter alloc] init];
    NSString *str1 = @"=============银智付=============";
    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    [printer appendTitle:@"商户名称：" value:@"永和大豆浆"];
    [printer appendTitle:@"商户编号：" value:@"1234567890"];
    [printer appendTitle:@"订单编号：" value:@"MS1234567890"];
    [printer appendTitle:@"交易类型：" value:@"微信支付"];
    [printer appendTitle:@"交易时间：" value:@"2017-06-14"];
    [printer appendTitle:@"金    额：" value:@"1000元"];
    [printer appendFooter:@"欢迎使用银智付!"];
    [printer appendNewLine];
    NSData *mainData = [printer getFinalData];
    [[JWBluetoothManage sharedInstance] sendPrintData:mainData completion:^(BOOL completion, CBPeripheral *connectPerpheral,NSString *error) {
        if (completion) {
            MLLog(@"打印成功");
            [SVProgressHUD showSuccessWithStatus:@"打印成功！"];
        }else{
            MLLog(@"写入错误---:%@",error);
            [SVProgressHUD showErrorWithStatus:[NSString stringWithFormat:@"写入错误---:%@",error]];


        }
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _mTableArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"cell";
    
    WKHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    [cell setMHome:_mTableArr[indexPath.row]];
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
