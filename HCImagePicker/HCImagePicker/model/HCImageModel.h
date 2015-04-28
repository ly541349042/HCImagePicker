//
//  HCImageModel.h
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <MapKit/MapKit.h>

@class ALAsset;
@class ALAssetRepresentation;

@interface HCImageModel : NSObject

/**
 *  full resolution image, readonly
 */
@property (nonatomic, strong, readonly) UIImage *assetFullResolutionImage;

/**
 *  asset's thumbnail, readonly
 */
@property (nonatomic, strong, readonly) UIImage *assetThumbnail;
/**
 *  asset's full screen image, readonly
 */
@property (nonatomic, strong, readonly) UIImage *assetFullScreenImage;
/**
 *  is this image choosed
 */
@property (nonatomic, assign, getter = isChoosed) BOOL choosed;

/**
 *  the intance method to create a new `HCImageModel` object, this is the designated initializer
 *
 *  @param asset the `ALAsset` object where `HCImageModel` create from
 *
 *  @return a new `HCImageModel` object
 */
-(instancetype)initWithAsset:(ALAsset *)asset NS_DESIGNATED_INITIALIZER;

/**
 *  the class method to create a new `HCImageModel` object
 *
 *  @param asset asset the `ALAsset` object where `HCImageModel` create from
 *
 *  @return a new `HCImageModel` object
 */
+(instancetype)imageModelWithAsset:(ALAsset *)asset;

@end
