//
//  HCImageGroupModel.h
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ALAssetsGroup;

@interface HCImageGroupModel : NSObject

@property (nonatomic, strong) ALAssetsGroup *originalAssetsGroup;

/**
 *  the group's thumbnail, readonly
 */
@property (nonatomic, strong, readonly) UIImage  *assetsGroupThumbnail;

/**
 *  the group's assets number, readonly
 */
@property (nonatomic, assign, readonly) NSInteger assetsGroupNumberOfAssets;

/**
 *  the group's name, readonly
 */
@property (nonatomic, copy, readonly) NSString *assetsGroupName;

/**
 *  the intance method to create a new `HCImageGroupModel` object, this is the designated initializer
 *
 *  @param assetsGroup the `ALAssetsGroup` object where `HCImageGroupModel` create from
 *
 *  @return a new `HCImageGroupModel` object
 */
-(instancetype)initWithAssetGroup:(ALAssetsGroup *)assetsGroup NS_DESIGNATED_INITIALIZER;

/**
 *  the class method to create a new `HCImageGroupModel` object
 *
 *  @param assetsGroup the `ALAssetsGroup` object where `HCImageGroupModel` create from
 *
 *  @return a new `HCImageGroupModel` object
 */
+(instancetype)imageGroupModelWithAssetGroup:(ALAssetsGroup *)assetsGroup;

/**
 *  create `NSAttributedString` with group name and number
 *
 *  @return the new name with assets number
 */
-(NSAttributedString *)groupNameWithAssetsNumber;

@end
