//
//  WKBDModel.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 使用方法：所有基于nsobject新建对象全部继承WKBDModel。 
 例：
 --- 归档
    CacheModel *model = [CacheModel new];
    model.name = @"moses";
    model.ID = @"10086";
    model.age = 18;
    model.gender = 1;
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"cache001"];
    [NSKeyedArchiver archiveRootObject:model toFile:filePath];
 
 --- 解档
    NSString *documentPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    NSString *filePath = [documentPath stringByAppendingPathComponent:@"cache001"];
    CacheModel *model = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
    NSLog(@"%@--%@--%d--%d", model.name, model.ID, model.age, model.gender);
 
 */
@interface WKBDModel : NSObject

@end
