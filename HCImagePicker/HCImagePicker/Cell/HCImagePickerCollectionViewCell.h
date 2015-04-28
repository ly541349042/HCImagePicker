//
//  HCImagePickerCollectionViewCell.h
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

UIKIT_EXTERN NSString *const HCImagePickerCollectionViewCellIdentifier;

@class HCImagePickerCollectionViewCell;
@class HCImageModel;

typedef void (^HCImagePickerCollectionViewCellBlock)(HCImagePickerCollectionViewCell *cell, BOOL isChoosed);

@interface HCImagePickerCollectionViewCell : UICollectionViewCell

/**
 *  the `UIImage` display on the cell
 */
@property (nonatomic, strong) UIImage *image;
/**
 *  if this cell is choosed
 */
@property (nonatomic, assign, getter=isChoosed) BOOL choosed;

/**
 *  the block excuted when the cell choosed
 *
 *  @param cellBlock
 */
-(void)cellDidChoosed:(HCImagePickerCollectionViewCellBlock)cellBlock;

/**
 *  configuration the cell with `HCImageModel`
 *
 *  @param imageModel
 */
-(void)cellConfigurationWith:(HCImageModel *)imageModel;

@end