//
//  HCImageGroupModel.m
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import "HCImageGroupModel.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import <UIKit/UIKit.h>

@interface HCImageGroupModel()

@property (nonatomic, strong, readwrite) UIImage  *assetsGroupThumbnail;
@property (nonatomic, assign, readwrite) NSInteger assetsGroupNumberOfAssets;
@property (nonatomic, copy, readwrite) NSString *assetsGroupName;

@end

@implementation HCImageGroupModel

-(instancetype)initWithAssetGroup:(ALAssetsGroup *)assetsGroup
{
    if (self = [super init])
    {
        self.originalAssetsGroup = assetsGroup;
        
        self.assetsGroupThumbnail = [UIImage imageWithCGImage:[self.originalAssetsGroup posterImage]];
        self.assetsGroupNumberOfAssets = [self.originalAssetsGroup numberOfAssets];
        self.assetsGroupName = [self.originalAssetsGroup valueForProperty:ALAssetsGroupPropertyName];
    }
    
    return self;
}

+(instancetype)imageGroupModelWithAssetGroup:(ALAssetsGroup *)assetsGroup
{
    return [[self alloc] initWithAssetGroup:assetsGroup];
}

-(NSAttributedString *)groupNameWithAssetsNumber
{
    NSString *numberString = [NSString stringWithFormat:@" (%ld)", _assetsGroupNumberOfAssets];
    NSString *nameWithNumber = [NSString stringWithFormat:@"%@%@", _assetsGroupName, numberString];
    NSRange numberRange = [nameWithNumber rangeOfString:numberString];
    
    NSMutableAttributedString *nameWithNumberAttributedString = [[NSMutableAttributedString alloc] initWithString:nameWithNumber];
    
    [nameWithNumberAttributedString beginEditing];
    [nameWithNumberAttributedString addAttribute:NSForegroundColorAttributeName value:[UIColor grayColor] range:numberRange];
    [nameWithNumberAttributedString endEditing];
    
    return [nameWithNumberAttributedString copy];
}

@end
