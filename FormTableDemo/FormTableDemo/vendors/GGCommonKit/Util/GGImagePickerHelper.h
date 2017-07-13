//
//  GGImagePickerHelper.h
//  GGCommonKit
//
//  Created by Loong Lam on 15/4/15.
//
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

typedef void(^imagePickerBlock)(UIImage *image);


@interface GGImagePickerHelper : NSObject

@property (nonatomic, assign) BOOL shouldSavePhoto;//调用相机时是否保存拍摄的照片
@property (nonatomic, assign) BOOL allowsEditing;
@property (nonatomic, strong) imagePickerBlock finishPickingImageBlock;

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType allowsEditing:(BOOL)allowsEditing finishPickingImageBlock:(imagePickerBlock) block;

+ (GGImagePickerHelper *)sharedInstance;

@end
