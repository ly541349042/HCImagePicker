//
//  HCImagePreviewViewController.h
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  the notification when the `HCImagePreviewViewController` did finish choosing images
 */
UIKIT_EXTERN NSString *const HCImagePreviewViewControllerDidFinishChoosedNotification;

@interface HCImagePreviewViewController : UIViewController

/**
 *  the images array to display on the sroll view
 */
@property (nonatomic, copy) NSArray *previewImageArray;

/**
 *  the images array to store choosed images
 */
@property (nonatomic, strong) NSMutableArray *choosedImages;

@end