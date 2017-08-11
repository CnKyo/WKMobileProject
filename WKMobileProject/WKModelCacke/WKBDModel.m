//
//  WKBDModel.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/11.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKBDModel.h"
#import <objc/runtime.h>

@implementation WKBDModel

- (instancetype)initWithCoder:(NSCoder *)mCoder{
    
    if (self = [super init]) {
        u_int count;
        objc_property_t *properties = class_copyPropertyList([self class], &count);
        
        for (int i = 0; i<count; i++) {
            const char *propertyName = property_getName(properties[i]);
            NSString *key = [NSString stringWithUTF8String:propertyName];
            [self setValue:[mCoder decodeObjectForKey:key] forKey:key];
        }
        
        free(properties);
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)mCoder{
    u_int count;
    objc_property_t *properties = class_copyPropertyList([self class], &count);
    for ( int i = 0; i<count; i++) {
        const char *propertyName = property_getName(properties[i]);
        NSString *key = [NSString stringWithUTF8String:propertyName];
        [mCoder encodeObject:[self valueForKey:key] forKey:key];
    }
    free(properties);
}

@end
