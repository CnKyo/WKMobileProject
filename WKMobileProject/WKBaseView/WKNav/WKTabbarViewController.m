//
//  WKTabbarViewController.m
//  WKMobileProject
//
//  Created by 王钶 on 2017/4/22.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKTabbarViewController.h"
#import "WKHeader.h"
@interface WKTabbarViewController ()

@end

@implementation WKTabbarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ///设置文字的属性
    [self setUpItemTitleTextAttrs];
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
- (void)setUpOneChildVc:(UIViewController *)childVc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    childVc.tabBarItem.title = title;
    if (image.length) childVc.tabBarItem.image = [UIImage imageNamed:image];
    if (selectedImage.length) childVc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    [self addChildViewController:childVc];
    
}


- (void)setUpItemTitleTextAttrs
{
    self.tabBar.tintColor = M_CO;
    self.tabBar.translucent = NO;
    
    //设置tabbar边缘线
    self.tabBar.layer.borderWidth = 0.50;
    self.tabBar.layer.borderColor = [UIColor colorWithRed:0.75 green:0.75 blue:0.75 alpha:0.3].CGColor;
    
    //设置normal状态下的文字属性
    NSMutableDictionary *normalAttrs = [NSMutableDictionary dictionary];
    normalAttrs[NSFontAttributeName] = [UIFont systemFontOfSize:13];
    normalAttrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    //设置selected状态下的文字属性
    NSMutableDictionary *selectedArrts= [NSMutableDictionary dictionary];
    selectedArrts[NSForegroundColorAttributeName] = M_CO;
    
    //利用Appearance对象同意设置文字属性
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:normalAttrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedArrts forState:UIControlStateSelected];
    
}
@end
