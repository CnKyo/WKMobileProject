//
//  WKNearByViewController.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/10/12.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKNearByViewController.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
@interface WKNearByViewController ()<AMapSearchDelegate>

@property (strong,nonatomic)    AMapSearchAPI *mPOISearch;

@property (strong,nonatomic)    MAMapView *mapView;

@end

@implementation WKNearByViewController
{
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"附近的蜂农";
    
 
}
- (void)loadView{
    
    [super loadView];
    UIView *vc = [UIView new];
    vc.backgroundColor = [UIColor whiteColor];
    vc.frame = self.view.bounds;
    [self.view addSubview:vc];
    
//    UIImageView *mimg = [UIImageView new];
//    mimg.frame = vc.frame;
//    mimg.image = [UIImage imageNamed:@"icon_nearby"];
//    [vc addSubview:mimg];
    
    [AMapServices sharedServices].apiKey = @"5b5bc2a34bc93348a801c807ae2aca03";

    [AMapServices sharedServices].enableHTTPS = YES;
    ///初始化地图
     _mapView = [[MAMapView alloc] initWithFrame:self.view.bounds];
    
    ///把地图添加至view
    [self.view addSubview:_mapView];
    
    ///如果您需要进入地图就显示定位小蓝点，则需要下面两行代码
    _mapView.showsUserLocation = YES;
    _mapView.userTrackingMode = MAUserTrackingModeFollow;
    
    
    self.mPOISearch = [[AMapSearchAPI alloc] init];
    self.mPOISearch.delegate = self;
    AMapPOIKeywordsSearchRequest *request = [[AMapPOIKeywordsSearchRequest alloc] init];
    
    request.keywords            = @"乡村基";
    request.city                = @"重庆";
    request.types               = @"餐饮";
    request.requireExtension    = YES;
    request.cityLimit           = YES;
    request.requireSubPOIs      = YES;
    [self.mPOISearch AMapPOIKeywordsSearch:request];
}
/* POI 搜索回调. */
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if (response.pois.count == 0)
        {
        return;
        }else{
            for (AMapPOI *mPoi in response.pois) {
                MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
                pointAnnotation.coordinate = CLLocationCoordinate2DMake(mPoi.location.latitude, mPoi.location.longitude);
                pointAnnotation.title = mPoi.name;
                pointAnnotation.subtitle = mPoi.address;
                
                [_mapView addAnnotation:pointAnnotation];
            }
          
        }
    
    //解析response获取POI信息，具体解析见 Demo
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
        {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
            {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        return annotationView;
        }
    return nil;
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

@end
