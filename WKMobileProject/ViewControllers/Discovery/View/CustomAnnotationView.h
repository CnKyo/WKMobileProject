//
//  CustomAnnotationView.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/11/21.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <MAMapKit/MAMapKit.h>
#import "CustomCalloutView.h"

@interface CustomAnnotationView : MAAnnotationView
@property (nonatomic, readonly) CustomCalloutView *calloutView;

@end