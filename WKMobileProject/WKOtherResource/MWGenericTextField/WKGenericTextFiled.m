//
//  WKGenericTextFiled.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/7.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKGenericTextFiled.h"

@implementation WKGenericTextFiled

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
- (instancetype)initWithFrame:(CGRect)mFrame andFont:(CGFloat)mFont andKeyboardType:(UIKeyboardType)mKeyboardType andPlaceholder:(NSString *)mPlaceholder andTextFieldType:(WKTextFieldType)mType{

    if (self = [super initWithFrame:mFrame]) {
        [self addSubview:self.textField];
        self.textField.frame = CGRectMake(0, 0, mFrame.size.width, mFrame.size.height);
        self.textField.font = [UIFont systemFontOfSize:mFont];
        self.textField.keyboardType = mKeyboardType;
        self.textField.placeholder = mPlaceholder;
        self.mType = mType;
    }
    return self;
 
}
- (UITextField *)textField {
    if (!_textField) {
        _textField = [[UITextField alloc] init];
        _textField.clearButtonMode = UITextFieldViewModeWhileEditing;
        _textField.borderStyle = UITextBorderStyleNone;
        _textField.backgroundColor = [UIColor whiteColor];
        _textField.returnKeyType = UIReturnKeyDone;
        _textField.textColor = [UIColor blackColor];
        _textField.delegate = self;
        [_textField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];    }
    return _textField;
}

- (void)textFieldDidChange:(UITextField *)textField {
    NSString *toBeString = textField.text;
    toBeString = [self filterCharactor:textField.text withRegex:@"[^a-zA-Z0-9\u4e00-\u9fa5]"];
    NSString *lang = [[UITextInputMode currentInputMode] primaryLanguage];
    if([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *selectedRange = [textField markedTextRange];
        UITextPosition *position = [textField positionFromPosition:selectedRange.start offset:0];
        if(!position) {
            textField.text = [self lengthLimit:toBeString];
        }
        else{
        }
    }
    else{
        textField.text = [self lengthLimit:toBeString];
    }
}

- (NSString *)lengthLimit:(NSString *)toBeString {
    switch (self.mType) {
        case WKTextFieldIdCard:
        {
        if(toBeString.length > 18) {
            return [toBeString substringToIndex:18];
        }
        }
            break;
        case WKTextFieldPhone: {
            if(toBeString.length > 11) {
                return [toBeString substringToIndex:11];
            }
        }
            break;
        case WKTextFieldPWD: {
            if(toBeString.length > 20) {
                return [toBeString substringToIndex:20];
            }
        }
            break;
        case WKTextFieldCode: {
            if(toBeString.length > 6) {
                return [toBeString substringToIndex:6];
            }
        }
            break;
        case WKTextFieldDefault: {
            if(toBeString.length > 50) {
                return [toBeString substringToIndex:50];
            }
        }
        default:
            break;
    }
    return toBeString;
}

- (NSString *)text {
    return self.textField.text;
}

- (void)setText:(NSString *)text {
    self.textField.text = text;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (NSString *)filterCharactor:(NSString *)string withRegex:(NSString *)regexStr{
    NSString *filterText = string;
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:regexStr options:NSRegularExpressionCaseInsensitive error:&error];
    NSString *result = [regex stringByReplacingMatchesInString:filterText options:NSMatchingReportCompletion range:NSMakeRange(0, filterText.length) withTemplate:@""];
    return result;
}

@end
