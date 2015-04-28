//
//  HCImageModel.m
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import "HCImageModel.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface HCImageModel()

@property (nonatomic, strong) ALAsset *originalAsset;

/**
 *  make `assetFullResolutionImage`, `assetThumbnail`, `assetFullScreenImage` readable
 */
@property (nonatomic, strong, readwrite) UIImage *assetFullResolutionImage;
@property (nonatomic, strong, readwrite) UIImage *assetThumbnail;
@property (nonatomic, strong, readwrite) UIImage *assetFullScreenImage;

@end

@implementation HCImageModel

-(instancetype)initWithAsset:(ALAsset *)asset
{
    if (self = [super init])
    {
        self.originalAsset = asset;
        
        self.assetFullResolutionImage = [UIImage imageWithCGImage:_originalAsset.defaultRepresentation.fullResolutionImage];
        self.assetThumbnail = [UIImage imageWithCGImage:[_originalAsset thumbnail]];
        self.assetFullScreenImage = [UIImage imageWithCGImage:_originalAsset.defaultRepresentation.fullScreenImage];
        self.choosed = NO;
    }
    
    return self;
}

+(instancetype)imageModelWithAsset:(ALAsset *)asset
{
    return [[self alloc] initWithAsset:asset];
}

@end
