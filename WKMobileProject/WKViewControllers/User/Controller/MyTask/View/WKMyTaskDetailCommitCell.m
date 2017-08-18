//
//  WKMyTaskDetailCommitCell.m
//  WKMobileProject
//
//  Created by mwi01 on 2017/8/16.
//  Copyright © 2017年 com.xw. All rights reserved.
//

#import "WKMyTaskDetailCommitCell.h"

@implementation WKMyTaskDetailCommitCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    [self.mNoteTxView setPlaceholder:@"请输入备注信息"];
    self.mNoteTxView.delegate = self;
    
    self.mWriteDataView.layer.masksToBounds = YES;
    self.mWriteDataView.layer.cornerRadius = 4;
    self.mWriteDataView.layer.borderWidth = 1;
    self.mWriteDataView.layer.borderColor = [UIColor lightGrayColor].CGColor;
    
        
    // 初始化
    LLImagePickerView *mImgPicker = [[LLImagePickerView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_Width-20, self.mUpLoadView.ct_height)];
    mImgPicker.maxImageSelected = 4;
    
    // 需要展示的媒体的资源类型，当前是仅本地图库
    mImgPicker.type = LLImageTypePhoto;
    
    // 是否允许 同个图片或视频进行多次选择
    mImgPicker.allowMultipleSelection = NO;
    
    __weak __typeof(self)weakSelf = self;

    //视情况看是否需要改变高度，目前单独使用且作为tableview的header，实时监控高度的变化
    [mImgPicker observeViewHeight:^(CGFloat height) {
        MLLog(@"更新的高度是：%f",height);
        weakSelf.mUploadViewH.constant = 60+height;
    }];
    

    // 随时获取选择好媒体文件
    [mImgPicker observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {

        if (list.count>4) {
            [SVProgressHUD showErrorWithStatus:@"选择的图片不能超过4张！"];
            return;
        }else{
            if ([weakSelf.delegate respondsToSelector:@selector(WKMyTaskDetailCommitCellWithReturnImgs:)]) {
                [weakSelf.delegate WKMyTaskDetailCommitCellWithReturnImgs:list];
            }
        }
        
        
    }];
    [self.mUpLoadView addSubview:mImgPicker];


}

- (IBAction)mBtnAction:(UIButton *)sender {
    
    if ([self.delegate respondsToSelector:@selector(WKMyTaskDetailCommitCellWithBtnClicked:)]) {
        [self.delegate WKMyTaskDetailCommitCellWithBtnClicked:sender.tag];
    }
    
}
- (void)textViewDidEndEditing:(UITextView *)textView{
    if (textView.text.length>0) {
        if ([_delegate respondsToSelector:@selector(WKMyTaskDetailCommitCellWithTextViewEndEditing:)]) {
            [_delegate WKMyTaskDetailCommitCellWithTextViewEndEditing:textView.text];
        }
        
    }
}


@end
