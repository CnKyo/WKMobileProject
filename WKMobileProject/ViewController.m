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

#import "SEPrinterManager.h"

#define WeakSelf __block __weak typeof(self)weakSelf = self;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,AVSpeechSynthesizerDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mTableView;
@property (strong, nonatomic) NSMutableArray *mTableArr;

@property (strong, nonatomic)   NSMutableArray              *deviceArray;  /**< 蓝牙设备个数 */
@end

@implementation ViewController
{
    AVSpeechSynthesizer *AVOice;
    HDAlertView *alertView;
    
    
    WKHomeModel *mHome;
    
}
@synthesize mTableView;
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:YES];

}
-(void)viewWillDisappear:(BOOL)animated{
    MLLog(@"viewWillDisappear");
    
    
    [SVProgressHUD dismiss];
    
    for (CBPeripheral *peripheral in self.deviceArray) {
        if ([peripheral.name isEqualToString:@"Printer001"]) {
            [[SEPrinterManager sharedInstance] cancelPeripheral:peripheral];
        }
    }
    
    
}
- (void)initBlueToothe{
    
    [SVProgressHUD showWithStatus:@"正在链接设备..."];
    
    for (CBPeripheral *peripheral in self.deviceArray) {
        if ([peripheral.name isEqualToString:@"Printer001"]) {
            [[SEPrinterManager sharedInstance] connectPeripheral:peripheral completion:^(CBPeripheral *perpheral, NSError *error) {
                if (error) {
                    [SVProgressHUD showErrorWithStatus:@"连接失败"];
                } else {
                    [SVProgressHUD showSuccessWithStatus:@"连接成功"];
                    [self performSelector:@selector(printTask) withObject:self afterDelay:1.0];

                }
                [self performSelector:@selector(XPSVPDissmiss) withObject:self afterDelay:1.0];
            }];
        }
    }
    
    
    
}
- (void)printTask{
    [self printe];

    
}
- (void)XPSVPDissmiss{
    [SVProgressHUD dismiss];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"首页";

    mHome = [WKHomeModel new];
    _mTableArr = [NSMutableArray new];
    
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
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"打印" style:UIBarButtonItemStylePlain target:self action:@selector(printe)];

}
- (void)printe{
    //方式一：
    HLPrinter *printer = [self getPrinter];
    
    NSData *mainData = [printer getFinalData];
    [[SEPrinterManager sharedInstance] sendPrintData:mainData completion:^(CBPeripheral *connectPerpheral, BOOL completion, NSString *error) {
        MLLog(@"写入结：%d---返回消息:%@",completion,error);
    }];
    
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
        [self initBlueToothe];
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
    SEPrinterManager *mManager = [SEPrinterManager sharedInstance];
    [mManager startScanPerpheralTimeout:10 Success:^(NSArray<CBPeripheral *> *perpherals,BOOL isTimeout) {
        MLLog(@"perpherals:%@",perpherals);
        _deviceArray = [NSMutableArray new];
        [_deviceArray addObjectsFromArray:perpherals];
    } failure:^(SEScanError error) {
        MLLog(@"error:%ld",(long)error);
    }];
}

#pragma mark----****----xprinter打印任务
- (HLPrinter *)getPrinter
{
    HLPrinter *printer = [[HLPrinter alloc] init];
    NSString *title = @"测试电商";
    //    NSString *str1 = @"测试电商服务中心(销售单)";
    [printer appendText:title alignment:HLTextAlignmentCenter fontSize:HLFontSizeTitleBig];
    //    [printer appendText:str1 alignment:HLTextAlignmentCenter];
    //    [printer appendBarCodeWithInfo:@"RN3456789012"];
    [printer appendSeperatorLine];
    
    [printer appendTitle:@"时间:" value:@"2016-04-27 10:01:50" valueOffset:150];
    [printer appendTitle:@"订单:" value:@"4000020160427100150" valueOffset:150];
    [printer appendText:@"地址:深圳市南山区学府路东深大店" alignment:HLTextAlignmentLeft];
    
    [printer appendSeperatorLine];
    [printer appendLeftText:@"商品" middleText:@"数量" rightText:@"单价" isTitle:YES];
    CGFloat total = 0.0;
    NSDictionary *dict1 = @{@"name":@"铅笔测试一下哈哈",@"amount":@"5",@"price":@"2.0"};
    NSDictionary *dict2 = @{@"name":@"abcdefghijfdf",@"amount":@"1",@"price":@"1.0"};
    NSDictionary *dict3 = @{@"name":@"abcde笔记本啊啊",@"amount":@"3",@"price":@"3.0"};
    NSArray *goodsArray = @[dict1, dict2, dict3];
    for (NSDictionary *dict in goodsArray) {
        [printer appendLeftText:dict[@"name"] middleText:dict[@"amount"] rightText:dict[@"price"] isTitle:NO];
        total += [dict[@"price"] floatValue] * [dict[@"amount"] intValue];
    }
    
    [printer appendSeperatorLine];
    NSString *totalStr = [NSString stringWithFormat:@"%.2f",total];
    [printer appendTitle:@"总计:" value:totalStr];
    [printer appendTitle:@"实收:" value:@"100.00"];
    NSString *leftStr = [NSString stringWithFormat:@"%.2f",100.00 - total];
    [printer appendTitle:@"找零:" value:leftStr];
    
    [printer appendSeperatorLine];
    
//    [printer appendText:@"位图方式二维码" alignment:HLTextAlignmentCenter];
//    [printer appendQRCodeWithInfo:@"www.baidu.com"];
    
    //    [printer appendSeperatorLine];
    //    [printer appendSeperatorLine];
    //    [printer appendText:@" " alignment:HLTextAlignmentCenter];
    //    [printer appendText:@" " alignment:HLTextAlignmentCenter];
    
    [printer appendFooter:nil];
    //    [printer appendSeperatorLine];
    //    [printer appendSeperatorLine];
    //    [printer appendSeperatorLine];
    
    [printer appendText:@" " alignment:HLTextAlignmentCenter];
    [printer appendText:@" " alignment:HLTextAlignmentCenter];
    //    [printer appendText:@" " alignment:HLTextAlignmentCenter];
    //    [printer appendText:@" " alignment:HLTextAlignmentCenter];
    
    //    [printer appendImage:[UIImage imageNamed:@"ico180"] alignment:HLTextAlignmentCenter maxWidth:300];
    
    // 你也可以利用UIWebView加载HTML小票的方式，这样可以在远程修改小票的样式和布局。
    // 注意点：需要等UIWebView加载完成后，再截取UIWebView的屏幕快照，然后利用添加图片的方法，加进printer
    // 截取屏幕快照，可以用UIWebView+UIImage中的catogery方法 - (UIImage *)imageForWebView
    
    return printer;
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
