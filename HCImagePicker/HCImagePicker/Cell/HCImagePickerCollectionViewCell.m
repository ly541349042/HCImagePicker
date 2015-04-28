//
//  HCImagePickerCollectionViewCell.m
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import "HCImagePickerCollectionViewCell.h"
#import "HCCheckButton.h"
#import "HCImageModel.h"

NSString *const HCImagePickerCollectionViewCellIdentifier = @"HCImagePickerCollectionViewCell";


@interface HCImagePickerCollectionViewCell()

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) HCCheckButton *selectButton;
@property (nonatomic, strong) HCImagePickerCollectionViewCellBlock pickerCellBlock;
@property (nonatomic, strong) HCImageModel *imageModel;

@end

@implementation HCImagePickerCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame])
    {
        _imageView = [[UIImageView alloc] initWithFrame:self.bounds];
        
        CGFloat selectBtnHW = frame.size.width / 5;
        CGFloat selectBtnY = 2;
        CGFloat selectBtnX = frame.size.width - selectBtnHW - 2;
        _selectButton = [HCCheckButton checkButton];
        _selectButton.frame  = CGRectMake(selectBtnX, selectBtnY, selectBtnHW, selectBtnHW);
        [_selectButton addTarget:self action:@selector(clickedAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.contentView addSubview:_imageView];
        [self.contentView addSubview:_selectButton];
    }
    
    return self;
}

-(void)cellDidChoosed:(HCImagePickerCollectionViewCellBlock)cellBlock
{
    if (cellBlock)
    {
        _pickerCellBlock = cellBlock;
    }
}

-(void)cellConfigurationWith:(HCImageModel *)imageModel
{
    _imageModel = imageModel;
    
    self.image = imageModel.assetThumbnail;
    self.choosed = imageModel.choosed;
}

/**
 *  the image's setter access
 *
 *  @param image the new `UIImage` object
 */
-(void)setImage:(UIImage *)image
{
    _image = image;
    _imageView.image = _image;
}

/**
 *  the choosed's setter access
 *
 *  @param choosesd if this cell choosed
 */
-(void)setChoosed:(BOOL)choosed
{
    _choosed = choosed;
    _selectButton.choosed = choosed;
}

/**
 *  response to the button's event `UIControlEventTouchUpInside`
 *
 *  @param sender 
 */
-(void)clickedAction:(HCCheckButton *)sender
{
    self.choosed = !self.isChoosed;
    _imageModel.choosed = self.isChoosed;
    
    if (_pickerCellBlock)
    {
        _pickerCellBlock(self, self.isChoosed);
    }
}

@end
