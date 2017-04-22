//
//  ViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/7.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "ViewController.h"
#import "WKHeader.h"
@interface ViewController ()<CTAPIManagerParamSource, CTAPIManagerCallBackDelegate>

    @property (nonatomic,strong) WKAPIManager *mAPIManager;
    
@end

@implementation ViewController

    - (void)viewWillAppear:(BOOL)animated{
        [super viewWillAppear:YES];
    }
    
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//   _mAPIManager.mAPIName =  @"/home/banner";
    [self.mAPIManager loadData];

}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - CTAPIManagerParamSource
- (NSDictionary *)paramsForApi:(CTAPIBaseManager *)manager{
    NSDictionary *params = @{};
    
    if (manager == self.mAPIManager) {
        params = nil;
    }
    
    return params;

}
#pragma mark - CTAPIManagerCallBackDelegate
- (void)managerCallAPIDidSuccess:(CTAPIBaseManager *)manager
    {
        if (manager == self.mAPIManager) {
            NSLog(@"%@", [manager fetchDataWithReformer:nil]);
        }
    }
    
- (void)managerCallAPIDidFailed:(CTAPIBaseManager *)manager
    {
        if (manager == self.mAPIManager) {
            NSLog(@"%@", [manager fetchDataWithReformer:nil]);
        }
    }
    
#pragma mark - getters and setters
- (WKAPIManager *)mAPIManager
    {
        if (_mAPIManager == nil) {
            _mAPIManager = [[WKAPIManager alloc] init];
            _mAPIManager.delegate = self;
            _mAPIManager.paramSource = self;
        }
        return _mAPIManager;
    }

@end
