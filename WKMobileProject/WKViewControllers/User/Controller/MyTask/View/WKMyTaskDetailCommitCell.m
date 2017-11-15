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
- (void)initPickView{
//    // 初始化
//   LLImagePickerView* mImagePickerView = [[LLImagePickerView alloc]initWithFrame:CGRectMake(0, 0, DEVICE_Width-20, self.mUpLoadView.ct_height)];
//    mImagePickerView.maxImageSelected = 4;
//
//    // 需要展示的媒体的资源类型，当前是仅本地图库
//    mImagePickerView.type = LLImageTypePhoto;
//
//    // 是否允许 同个图片或视频进行多次选择
//    mImagePickerView.allowMultipleSelection = NO;
//
//    __weak __typeof(self)weakSelf = self;
//
//    //视情况看是否需要改变高度，目前单独使用且作为tableview的header，实时监控高度的变化
//    [mImagePickerView observeViewHeight:^(CGFloat height) {
//        MLLog(@"更新的高度是：%f",height);
//        weakSelf.mUploadViewH.constant = 60+height;
//    }];
//
//
//    // 随时获取选择好媒体文件
//    [mImagePickerView observeSelectedMediaArray:^(NSArray<LLImagePickerModel *> *list) {
//
//        if (list.count>4) {
//            [SVProgressHUD showErrorWithStatus:@"选择的图片不能超过4张！"];
//            return;
//        }else{
//            if ([weakSelf.delegate respondsToSelector:@selector(WKMyTaskDetailCommitCellWithReturnImgs:)]) {
//                [weakSelf.delegate WKMyTaskDetailCommitCellWithReturnImgs:list];
//            }
//        }
//
//
//    }];
//    [self.mUpLoadView addSubview:mImagePickerView];
    _manager = [[HXPhotoManager alloc] initWithType:HXPhotoManagerSelectedTypePhotoAndVideo];
    _manager.openCamera = YES;
    _manager.cacheAlbum = YES;
    _manager.lookLivePhoto = YES;
    _manager.outerCamera = NO;
    _manager.cameraType = HXPhotoManagerCameraTypeFullScreen;
    _manager.photoMaxNum = 4;
    _manager.videoMaxNum = 4;
    _manager.maxNum = 8;
    _manager.videoMaxDuration = 500.f;
    _manager.saveSystemAblum = NO;
    _manager.style = HXPhotoAlbumStylesSystem;
    //        _manager.reverseDate = YES;
    _manager.showDateHeaderSection = NO;
    //        _manager.selectTogether = NO;
    //        _manager.rowCount = 3;
    
    _manager.UIManager.navBar = ^(UINavigationBar *navBar) {
        //            [navBar setBackgroundImage:[UIImage imageNamed:@"APPCityPlayer_bannerGame"] forBarMetrics:UIBarMetricsDefault];
    };
    HXPhotoView *photoView = [HXPhotoView photoManager:self.manager];
    photoView.frame = CGRectMake(0, 0, DEVICE_Width-20, self.mUpLoadView.ct_height);
    photoView.delegate = self;
    photoView.backgroundColor = [UIColor whiteColor];
    [self.mUpLoadView addSubview:photoView];
    self.photoView = photoView;
}
- (void)photoView:(HXPhotoView *)photoView changeComplete:(NSArray<HXPhotoModel *> *)allList photos:(NSArray<HXPhotoModel *> *)photos videos:(NSArray<HXPhotoModel *> *)videos original:(BOOL)isOriginal {
    NSSLog(@"所有:%ld - 照片:%ld - 视频:%ld",allList.count,photos.count,videos.count);
    NSSLog(@"所有:%@ - 照片:%@ - 视频:%@",allList,photos,videos);
    if (photos.count>4) {
        [SVProgressHUD showErrorWithStatus:@"选择的图片不能超过4张！"];
        return;
    }else{
        if ([self.delegate respondsToSelector:@selector(WKMyTaskDetailCommitCellWithReturnImgs:)]) {
            [self.delegate WKMyTaskDetailCommitCellWithReturnImgs:photos];
        }
    }
    //    [HXPhotoTools getImageForSelectedPhoto:photos type:HXPhotoToolsFetchHDImageType completion:^(NSArray<UIImage *> *images) {
    //        NSSLog(@"%@",images);
    //        for (UIImage *image in images) {
    //            if (image.images.count > 0) {
    //                // 到这里了说明这个image  是个gif图
    //            }
    //        }
    //    }];
    
    //    将HXPhotoModel模型数组转化成HXPhotoResultModel模型数组  - 已按选择顺序排序
    //    !!!!  必须是全部类型的那个数组 就是 allList 这个数组  !!!!
    /**  不推荐使用此方法,请使用一键写入临时目录的方法  */
    //    [HXPhotoTools getSelectedListResultModel:allList complete:^(NSArray<HXPhotoResultModel *> *alls, NSArray<HXPhotoResultModel *> *photos, NSArray<HXPhotoResultModel *> *videos) {
    //        NSSLog(@"\n全部类型:%@\n照片:%@\n视频:%@",alls,photos,videos);
    //    }];
    
    //    [HXPhotoTools getSelectedPhotosFullSizeImageUrl:photos complete:^(NSArray<NSURL *> *imageUrls) {
    //        NSSLog(@"%@",imageUrls);
    //    }];
    
    //    HXPhotoModel *model = allList.firstObject;
    //    if ([model.avAsset isKindOfClass:[AVURLAsset class]]) {
    //        AVURLAsset *urlAsset = (AVURLAsset *)model.avAsset;
    //        NSSLog(@"%@",urlAsset.URL);
    //    }
    //    // 获取相册里照片原图URL  如果是相机拍的照片且没有保存到系统相册时 此方法无效
    //    [HXPhotoTools getFullSizeImageUrlFor:model complete:^(NSURL *url) {
    //        NSSLog(@"%@",url);
    //    }];
    
    //    for (HXPhotoModel *model in allList) {
    //        NSLog(@"\n%@\n%@",model.thumbPhoto,model.previewPhoto);
    //    }
    
    /*
     // 获取image - PHImageManagerMaximumSize 是原图尺寸 - 通过相册获取时有用 / 通过相机拍摄的无效
     CGSize size = PHImageManagerMaximumSize; // 通过传入 size 的大小来控制图片的质量
     [HXPhotoTools FetchPhotoForPHAsset:model.asset Size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
     NSSLog(@"%@",image);
     }];
     
     // 这里的size 是普通图片的时候  想要更高质量的图片 可以把 1.5 换成 2 或者 3
     如果觉得内存消耗过大可以 调小一点
     
     CGSize size = CGSizeMake(model.endImageSize.width * 1.5, model.endImageSize.height * 1.5);
     
     // 这里是判断图片是否过长 因为图片如果长了 上面的size就显的有点小了获取出来的图片就变模糊了,所以这里把宽度 换成了屏幕的宽度,这个可以保证即不影响内存也不影响质量 如果觉得质量达不到你的要求,可以乘上 1.5 或者 2 . 当然你也可以不按我这样给size,自己测试怎么给都可以
     if (model.endImageSize.height > model.endImageSize.width / 9 * 20) {
     size = CGSizeMake([UIScreen mainScreen].bounds.size.width, model.endImageSize.height);
     }
     */
    
    /*
     
     // 获取图片资源
     [photos enumerateObjectsUsingBlock:^(HXPhotoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
     // 封面小图
     model.thumbPhoto;
     
     // 预览大图 - 只有在查看大图的时候选中之后才有值
     model.previewPhoto;
     
     // imageData  - 这个字段没有值 请根据指定方法获取
     model.imageData;
     
     // isCloseLivePhoto 判断当前图片是否关闭了 livePhoto 功能 YES-关闭 NO-开启
     model.isCloseLivePhoto;
     
     // 获取imageData - 通过相册获取时有用 / 通过相机拍摄的无效
     [HXPhotoTools FetchPhotoDataForPHAsset:model.asset completion:^(NSData *imageData, NSDictionary *info) {
     NSSLog(@"%@",imageData);
     }];
     
     // 获取image - PHImageManagerMaximumSize 是原图尺寸 - 通过相册获取时有用 / 通过相机拍摄的无效
     CGSize size = PHImageManagerMaximumSize; // 通过传入 size 的大小来控制图片的质量
     [HXPhotoTools FetchPhotoForPHAsset:model.asset Size:size resizeMode:PHImageRequestOptionsResizeModeFast completion:^(UIImage *image, NSDictionary *info) {
     NSSLog(@"%@",image);
     }];
     
     // 如果是通过相机拍摄的照片只有 thumbPhoto、previewPhoto和imageSize 这三个字段有用可以通过 type 这个字段判断是不是通过相机拍摄的
     if (model.type == HXPhotoModelMediaTypeCameraPhoto);
     }];
     
     // 如果是相册选取的视频 要获取视频URL 必须先将视频压缩写入文件,得到的文件路径就是视频的URL 如果是通过相机录制的视频那么 videoURL 这个字段就是视频的URL 可以看需求看要不要压缩
     [videos enumerateObjectsUsingBlock:^(HXPhotoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
     
     // 视频封面
     model.thumbPhoto;
     
     // 视频封面 大图 - 只有在查看大图的时候选中之后才有值
     model.previewPhoto;
     
     
     }];
     
     // 判断照片、视频 或 是否是通过相机拍摄的
     [allList enumerateObjectsUsingBlock:^(HXPhotoModel *model, NSUInteger idx, BOOL * _Nonnull stop) {
     if (model.type == HXPhotoModelMediaTypeCameraVideo) {
     // 通过相机录制的视频
     }else if (model.type == HXPhotoModelMediaTypeCameraPhoto) {
     // 通过相机拍摄的照片
     }else if (model.type == HXPhotoModelMediaTypePhoto) {
     // 相册里的照片
     }else if (model.type == HXPhotoModelMediaTypePhotoGif) {
     // 相册里的GIF图
     }else if (model.type == HXPhotoModelMediaTypeLivePhoto) {
     // 相册里的livePhoto
     }
     }];
     
     */
}
- (void)photoView:(HXPhotoView *)photoView deleteNetworkPhoto:(NSString *)networkPhotoUrl {
    NSSLog(@"%@",networkPhotoUrl);
}

- (void)photoView:(HXPhotoView *)photoView updateFrame:(CGRect)frame {
    NSSLog(@"%@",NSStringFromCGRect(frame));
    self.mUpLoadView.frame = CGRectMake(self.mUpLoadView.frame.origin.x,self.mUpLoadView.frame.origin.y,self.mUpLoadView.frame.size.width, CGRectGetMaxY(frame) + kPhotoViewMargin);
    
}

//
//// 压缩视频并写入沙盒文件
//- (void)compressedVideoWithURL:(id)url success:(void(^)(NSString *fileName))success failure:(void(^)())failure
//{
//    AVURLAsset *avAsset;
//    if ([url isKindOfClass:[NSURL class]]) {
//        avAsset = [AVURLAsset assetWithURL:url];
//    }else if ([url isKindOfClass:[AVAsset class]]) {
//        avAsset = (AVURLAsset *)url;
//    }
//
//    NSArray *compatiblePresets = [AVAssetExportSession exportPresetsCompatibleWithAsset:avAsset];
//
//    if ([compatiblePresets containsObject:AVAssetExportPresetHighestQuality]) {
//
//        AVAssetExportSession *exportSession = [[AVAssetExportSession alloc] initWithAsset:avAsset presetName:AVAssetExportPresetMediumQuality];
//
//        NSString *fileName = @""; // 这里是自己定义的文件路径
//
//        NSDate *nowDate = [NSDate date];
//        NSString *dateStr = [NSString stringWithFormat:@"%ld", (long)[nowDate timeIntervalSince1970]];
//
//        NSString *numStr = [NSString stringWithFormat:@"%d",arc4random()%10000];
//        fileName = [fileName stringByAppendingString:dateStr];
//        fileName = [fileName stringByAppendingString:numStr];
//
//        // ````` 这里取的是时间加上一些随机数  保证每次写入文件的路径不一样
//        fileName = [fileName stringByAppendingString:@".mp4"]; // 视频后缀
//        NSString *fileName1 = [NSTemporaryDirectory() stringByAppendingString:fileName]; //文件名称
//        exportSession.outputURL = [NSURL fileURLWithPath:fileName1];
//        exportSession.outputFileType = AVFileTypeMPEG4;
//        exportSession.shouldOptimizeForNetworkUse = YES;
//
//        [exportSession exportAsynchronouslyWithCompletionHandler:^{
//
//            switch (exportSession.status) {
//                case AVAssetExportSessionStatusCancelled:
//                    break;
//                case AVAssetExportSessionStatusCompleted:
//                {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (success) {
//                            success(fileName1);
//                        }
//                    });
//                }
//                    break;
//                case AVAssetExportSessionStatusExporting:
//                    break;
//                case AVAssetExportSessionStatusFailed:
//                {
//                    dispatch_async(dispatch_get_main_queue(), ^{
//                        if (failure) {
//                            failure();
//                        }
//                    });
//                }
//                    break;
//                case AVAssetExportSessionStatusUnknown:
//                    break;
//                case AVAssetExportSessionStatusWaiting:
//                    break;
//                default:
//                    break;
//            }
//        }];
//    }
//}
@end
