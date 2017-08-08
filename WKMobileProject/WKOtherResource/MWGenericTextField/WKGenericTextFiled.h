//
//  WKGenericTextFiled.h
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/7.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum WKTextFieldType {
    WKTextFieldIdCard,
    WKTextFieldPhone,
    WKTextFieldCode,
    WKTextFieldPWD,
    WKTextFieldDefault
} WKTextFieldType;
@interface WKGenericTextFiled : UIView<UITextFieldDelegate>

- (instancetype)initWithFrame:(CGRect)mFrame andFont:(CGFloat)mFont andKeyboardType:(UIKeyboardType)mKeyboardType andPlaceholder:(NSString *)mPlaceholder andTextFieldType:(WKTextFieldType)mType;

@property (strong, nonatomic) UITextField *textField;

@property (copy, nonatomic) NSString *text;

@property (assign, nonatomic) WKTextFieldType mType;

- (void)setText:(NSString *) text;

@end
