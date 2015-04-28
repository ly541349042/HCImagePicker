//
//  HCImageAlbumsViewController.h
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HCImageAlbumsViewControllerProtocol;

@interface HCImageAlbumsViewController : UIViewController

/**
 *  the delegate to response when did finish choosing images
 */
@property (nonatomic, weak) id<HCImageAlbumsViewControllerProtocol> delegate;

@end

/**
 *  the HCImageAlbumsViewControllerProtocol
 */
@protocol HCImageAlbumsViewControllerProtocol <NSObject>

@optional
/**
 *  perform when `HCImageAlbumsViewController` did finish choosing images
 *
 *  @param imageAlbumsViewController the `HCImageAlbumsViewController`
 *  @param images                    choosed images
 */
-(void)imageAlbumsViewController:(HCImageAlbumsViewController *)imageAlbumsViewController didFinishPickingImage:(NSArray *)images;

@end
