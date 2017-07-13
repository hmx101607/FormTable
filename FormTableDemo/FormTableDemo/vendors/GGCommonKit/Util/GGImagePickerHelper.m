//
//  GGImagePickerHelper.m
//  GGCommonKit
//
//  Created by Loong Lam on 15/4/15.
//
//

#import "GGImagePickerHelper.h"

@interface GGImagePickerHelper ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) UIImagePickerController *imagePicker;

@end

@implementation GGImagePickerHelper

+ (GGImagePickerHelper *)sharedInstance {
    
    static id sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (id)init {
    self = [super init];
    if (self) {
        self.imagePicker = [[UIImagePickerController alloc]init];
        self.imagePicker.delegate = self;
    }
    return self;
}

- (void)showImagePickerWithSourceType:(UIImagePickerControllerSourceType)sourceType allowsEditing:(BOOL)allowsEditing finishPickingImageBlock:(imagePickerBlock) block {
    self.finishPickingImageBlock = block;
    self.allowsEditing = allowsEditing;
    self.imagePicker.allowsEditing = allowsEditing;
    self.imagePicker.delegate = self;
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        self.imagePicker.sourceType = sourceType;
        [[self presentedViewController] presentViewController:self.imagePicker animated:YES completion:^{
            
        }];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:nil message:@"您的设备不支持这个功能" delegate:self cancelButtonTitle:@"我知道了" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

- (UIViewController *)presentedViewController{
    UIViewController *rootVC = [[UIApplication sharedApplication].delegate window].rootViewController;
    return rootVC.presentedViewController ? rootVC.presentedViewController : rootVC;
}

- (UIImagePickerController *)imagePicker {
    if (!_imagePicker) {
        _imagePicker = [[UIImagePickerController alloc]init];
    }
    _imagePicker.delegate = self;
    return _imagePicker;
}

#pragma mark -
#pragma mark ------------------- UIImagePickerControllerDelegate -------------------
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    UIImage *image = nil;
    if (self.allowsEditing) {
        image = info[UIImagePickerControllerEditedImage];
    } else {
        image = info[UIImagePickerControllerOriginalImage];
    }
    if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
        if (self.shouldSavePhoto) {
            UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
        }
    }
    if (self.finishPickingImageBlock) {
        self.finishPickingImageBlock(image);
    }
    [self.imagePicker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [self.imagePicker dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    
}

@end
