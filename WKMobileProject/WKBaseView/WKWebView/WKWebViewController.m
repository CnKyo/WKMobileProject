//
//  WKWebViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/6/13.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKWebViewController.h"
#import "WKHeader.h"

#import <WebKit/WebKit.h>
#import <objc/runtime.h>
#import "WKWebViewConfigDelegate.h"
@interface WKWebViewController ()<WKScriptMessageHandler, WKNavigationDelegate, WKUIDelegate>
@property (nonatomic, strong) WKWebView *webView;
@property (nonatomic, strong) UIProgressView *progressView;
@end

@implementation WKWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = self.mTitle;
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.automaticallyAdjustsScrollViewInsets = NO;
    //    self.tabBarController.delegate = self;
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    
    // 设置偏好设置
    config.preferences = [[WKPreferences alloc] init];
    // 默认为0
    config.preferences.minimumFontSize = 10;
    // 默认认为YES
    config.preferences.javaScriptEnabled = YES;
    // 在iOS上默认为NO，表示不能自动通过窗口打开
    config.preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.websiteDataStore = [WKWebsiteDataStore defaultDataStore];
    // web内容处理池
    config.processPool = [[WKProcessPool alloc] init];
    
    // 通过JS与webview内容交互
    config.userContentController = [[WKUserContentController alloc]init];
    // 注入JS对象名称AppModel，当JS通过AppModel来调用时，
    // 我们可以在WKScriptMessageHandler代理中接收到
    [config.userContentController addScriptMessageHandler:[[WKWebViewConfigDelegate alloc] initWithDelegate:self] name:@"AppModel"];
    
    self.webView = [[WKWebView alloc] initWithFrame:self.view.bounds
                                      configuration:config];
    
    
    NSURL *path = [[NSBundle mainBundle] URLForResource:@"index3" withExtension:@"html"];
//    NSURL *path = [NSURL URLWithString:@"https://www.baidu.com"];

    //设置缓存请求策略时间
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:path cachePolicy:1 timeoutInterval:30.0f];
    
    [self.webView loadRequest:request];
    [self.view addSubview:self.webView];
    
    // 导航代理
    self.webView.navigationDelegate = self;
    // 与webview UI交互代理
    self.webView.UIDelegate = self;
    
    // 添加KVO监听
    [self.webView addObserver:self
                   forKeyPath:@"loading"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"title"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    [self.webView addObserver:self
                   forKeyPath:@"estimatedProgress"
                      options:NSKeyValueObservingOptionNew
                      context:nil];
    
    // 添加进入条
    self.progressView = [[UIProgressView alloc] init];
    self.progressView.frame = self.view.bounds;
    [self.view addSubview:self.progressView];
    self.progressView.backgroundColor = [UIColor redColor];
    
    //    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"后退" style:UIBarButtonItemStyleDone target:self action:@selector(goback)];
    //    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"前进" style:UIBarButtonItemStyleDone target:self action:@selector(gofarward)];
    
    
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    //    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
    [SVProgressHUD showWithStatus:@"加载中..."];
}
-(void)dealloc{
    [self.webView removeObserver:self forKeyPath:@"loading"];

    [self.webView removeObserver:self forKeyPath:@"estimatedProgress"];
    [self.webView removeObserver:self forKeyPath:@"title"];
//    [self deleteCacke];
    [SVProgressHUD dismiss];


}
/** 清理缓存的方法，这个方法会清除缓存类型为HTML类型的文件*/
- (void)clearCache {
    /* 取得Library文件夹的位置*/
    NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,NSUserDomainMask, YES)[0];
    /* 取得bundle id，用作文件拼接用*/
    NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]objectForKey:@"CFBundleIdentifier"];
    /*
     * 拼接缓存地址，具体目录为App/Library/Caches/你的APPBundleID/fsCachedData
     */
    NSString *webKitFolderInCachesfs = [NSString stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
    
    NSError *error;
    /* 取得目录下所有的文件，取得文件数组*/
    NSFileManager *fileManager = [NSFileManager defaultManager];
    //    NSArray *fileList = [[NSArray alloc] init];
    //fileList便是包含有该文件夹下所有文件的文件名及文件夹名的数组
    NSArray *fileList = [fileManager contentsOfDirectoryAtPath:webKitFolderInCachesfs error:&error];
    /* 遍历文件组成的数组*/
    for(NSString * fileName in fileList){
        /* 定位每个文件的位置*/
        NSString * path = [[NSBundle bundleWithPath:webKitFolderInCachesfs] pathForResource:fileName ofType:@""];
        /* 将文件转换为NSData类型的数据*/
        NSData * fileData = [NSData dataWithContentsOfFile:path];
        /* 如果FileData的长度大于2，说明FileData不为空*/
        if(fileData.length >2){
            /* 创建两个用于显示文件类型的变量*/
            int char1 =0;
            int char2 =0;
            
            [fileData getBytes:&char1 range:NSMakeRange(0,1)];
            [fileData getBytes:&char2 range:NSMakeRange(1,1)];
            /* 拼接两个变量*/
            NSString *numStr = [NSString stringWithFormat:@"%i%i",char1,char2];
            /* 如果该文件前四个字符是6033，说明是Html文件，删除掉本地的缓存*/
            if([numStr isEqualToString:@"6033"]){
                [[NSFileManager defaultManager] removeItemAtPath:[NSString stringWithFormat:@"%@/%@",webKitFolderInCachesfs,fileName]error:&error];
                continue;
            }
        }
    }
}
- (void)deleteCacke{
    if (SystemIsiOS9()) {
        //你可以选择性的删除一些你需要删除的文件 or 也可以直接全部删除所有缓存的type
//        NSSet *websiteDataTypes = [WKWebsiteDataStore allWebsiteDataTypes];
        NSSet *websiteDataTypes = [NSSet setWithArray:@[WKWebsiteDataTypeDiskCache,WKWebsiteDataTypeMemoryCache]];
//        NSDate *dateFrom = [NSDate dateWithTimeIntervalSince1970:0];
        NSDate *dateFrom = [NSDate date];

        [[WKWebsiteDataStore defaultDataStore] removeDataOfTypes:websiteDataTypes
                                                   modifiedSince:dateFrom completionHandler:^{
                                                       // code
                                                       MLLog(@"清除缓存后。。。。");
                                                   }];

    }else{
        NSString *libraryDir = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory,
                                                                   NSUserDomainMask, YES)[0];
//        NSString *bundleId  =  [[[NSBundle mainBundle] infoDictionary]
//                                objectForKey:@"CFBundleIdentifier"];
//        NSString *webkitFolderInLib = [NSString stringWithFormat:@"%@/WebKit",libraryDir];
//        NSString *webKitFolderInCachesfs = [NSString
//                                            stringWithFormat:@"%@/Caches/%@/fsCachedData",libraryDir,bundleId];
//        
//        NSError *error;
//        [[NSFileManager defaultManager] removeItemAtPath:webKitFolderInCachesfs error:&error];
//        [[NSFileManager defaultManager] removeItemAtPath:webkitFolderInLib error:nil];
        NSString *cookies = [libraryDir stringByAppendingString:@"/Cookies"];
        [[NSFileManager defaultManager] removeItemAtPath:cookies error:nil];
    }
   
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

-(void)keyboardWillHide:(NSNotification *)notification
{
    NSString *jsToTextFiled = @"document.getElementById('name').innerHTML = response";
    
    [self.webView evaluateJavaScript:jsToTextFiled completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        MLLog(@"result:%@----error:%@",result, error);
    }];
}
- (void)goback {
    if ([self.webView canGoBack]) {
        [self.webView goBack];
        
    }else{
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}

- (void)gofarward {
    if ([self.webView canGoForward]) {
        [self.webView goForward];
    }
}

#pragma mark - WKScriptMessageHandler----****----按钮参数获取
- (void)userContentController:(WKUserContentController *)userContentController
      didReceiveScriptMessage:(WKScriptMessage *)message {
    
    NSMutableDictionary *para = [NSMutableDictionary new];
    [para setObject:kMobTrainDemandKey forKey:@"key"];
    [para setObject:@"K688" forKey:@"trainno"];
    
    //    MLLog(@"name:%@\n ----****---- body:%@\n ----****---- frameInfo:%@\n",message.name,message.body,message.frameInfo);
    
    WKModel *model = [WKModel yy_modelWithJSON:message.body];
    MLLog(@"最后得到的对象是：%@",model.body);
    ///oc 反调js
    if ([model.body.id isEqualToString:@"2"]) {
        ///点击了确定按钮
        NSString *ocTojs = [NSString stringWithFormat:@"getInfo(%@)",para];

        [self.webView evaluateJavaScript:ocTojs completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            MLLog(@"%@----%@",result, error);
        }];
    }else if ([model.body.id isEqualToString:@"3"]){
        
        NSString *ocTojs = [NSString stringWithFormat:@"alert('%s')","this is alertview pop to "];
        [self.webView evaluateJavaScript:ocTojs completionHandler:^(id _Nullable result, NSError * _Nullable error) {
            MLLog(@"%@----%@",result, error);
        }];
        MLLog(@"3");
    }
    else{
        WKWebViewController *vc = [WKWebViewController new];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    //    if ([message.name isEqualToString:@"AppModel"]) {
    //        // 打印所传过来的参数，只支持NSNumber, NSString, NSDate, NSArray,
    //        // NSDictionary, and NSNull类型
    //        MLLog(@"%@", message.body);
    //    }
}

#pragma mark - KVO
- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary<NSString *,id> *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"loading"]) {
        MLLog(@"loading");
    } else if ([keyPath isEqualToString:@"title"]) {
        self.navigationItem.title = self.webView.title;
    } else if ([keyPath isEqualToString:@"estimatedProgress"]) {
        MLLog(@"progress: %f", self.webView.estimatedProgress);
        self.progressView.progress = self.webView.estimatedProgress;
    }
    
    // 加载完成
    if (!self.webView.loading) {
        // 手动调用JS代码
        // 每次页面完成都弹出来，大家可以在测试时再打开
        //        NSString *js = @"callJsAlert()";
        //        [self.webView evaluateJavaScript:js completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        //            MLLog(@"response: %@ error: %@", response, error);
        //            MLLog(@"call js alert by native");
        //        }];
        
        [UIView animateWithDuration:0.5 animations:^{
            self.progressView.alpha = 0;
        }];
    }
}

#pragma mark - WKNavigationDelegate
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    NSString *hostname = navigationAction.request.URL.host.lowercaseString;
    
    //    if (navigationAction.navigationType == WKNavigationTypeLinkActivated
    //        && ![hostname containsString:@".baidu.com"]) {
    //        // 对于跨域，需要手动跳转
    //        [[UIApplication sharedApplication] openURL:navigationAction.request.URL];
    //
    //        // 不允许web内跳转
    //        decisionHandler(WKNavigationActionPolicyCancel);
    //    } else {
    self.progressView.alpha = 1.0;
    decisionHandler(WKNavigationActionPolicyAllow);
    //    }
    
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView decidePolicyForNavigationResponse:(WKNavigationResponse *)navigationResponse decisionHandler:(void (^)(WKNavigationResponsePolicy))decisionHandler {
    decisionHandler(WKNavigationResponsePolicyAllow);
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(null_unspecified WKNavigation *)navigation {
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didFailProvisionalNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    MLLog(@"%s", __FUNCTION__);
}

- (void)webView:(WKWebView *)webView didCommitNavigation:(null_unspecified WKNavigation *)navigation {
    MLLog(@"%s", __FUNCTION__);
}
#pragma mark----****----web加载完成后调用
- (void)webView:(WKWebView *)webView didFinishNavigation:(null_unspecified WKNavigation *)navigation {
    MLLog(@"%s", __FUNCTION__);
    NSString *jsToTextFiled = @"name";
    [self.webView evaluateJavaScript:jsToTextFiled completionHandler:^(id _Nullable result, NSError * _Nullable error) {
        MLLog(@"%@----%@",result, error);
    }];
    [SVProgressHUD dismiss];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(null_unspecified WKNavigation *)navigation withError:(NSError *)error {
    
}

- (void)webView:(WKWebView *)webView didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition disposition, NSURLCredential *__nullable credential))completionHandler {
    MLLog(@"%s", __FUNCTION__);
    completionHandler(NSURLSessionAuthChallengePerformDefaultHandling, nil);
}

- (void)webViewWebContentProcessDidTerminate:(WKWebView *)webView {
    MLLog(@"%s", __FUNCTION__);
}

#pragma mark - WKUIDelegate
- (void)webViewDidClose:(WKWebView *)webView {
    MLLog(@"%s", __FUNCTION__);
}
#pragma mark----****----js调oc的alertview会先调用这个方法
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler {
    MLLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    MLLog(@"%@", message);
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL result))completionHandler {
    MLLog(@"%s", __FUNCTION__);
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"confirm" message:@"JS调用confirm" preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
    
    MLLog(@"%@", message);
}

#pragma mark----****----弹出输入框
- (void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(nullable NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * __nullable result))completionHandler {
    MLLog(@"%s", __FUNCTION__);
    
    MLLog(@"prompt的值是：%@", prompt);
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:@"JS调用输入框" preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

- (UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController) {
        resultVC = [self _topViewController:resultVC.presentedViewController];
    }
    return resultVC;
}
- (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}

@end
