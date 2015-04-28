//
//  HCMultiImagePickerController.h
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  notification when `HCMultiImagePickerController` did finish choosing images
 */
UIKIT_EXTERN NSString *const HCMultiImagePickerControllerDidFinishChoosedNotification;

@class HCImageGroupModel;

@interface HCMultiImagePickerController : UIViewController

/**
 *  the data model 4 `ALAssetsGroup`
 */
@property (nonatomic, strong) HCImageGroupModel *imageGroup;

@end
