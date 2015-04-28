//
//  HCMultiImagePickerController.m
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import "HCMultiImagePickerController.h"
#import "HCImagePickerCollectionViewCell.h"
#import "HCImagePreviewViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "HCImageModel.h"
#import "HCImageGroupModel.h"
#import "HCNumberLabel.h"

#define kScreenRect [UIScreen mainScreen].bounds

NSString *const HCMultiImagePickerControllerDidFinishChoosedNotification = @"HCMultiImagePickerControllerDidChoosedNotification";

@interface HCMultiImagePickerController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
/**
 *  the `UICollectionView` 4 display all the images' thumbnails
 */
@property (nonatomic, strong) UICollectionView *imageCollectiobView;

/**
 *  the `UICollectionView`'s data source
 */
@property (nonatomic, strong) NSMutableArray *imageModelArray;

/**
 *  the `NSMutableArray` to store choosed `HCImageModel`
 */
@property (nonatomic, strong) NSMutableArray *choosedImagesArray;

@end

@implementation HCMultiImagePickerController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initialCollectionView];
    [self initialToolBarItem];
    [self initailNavigation];
    [self fetchImages];
    
    _choosedImagesArray = [NSMutableArray array];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:NO];
    
    [self.imageCollectiobView reloadData];
    [self toolbarRefresh];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:NO];
}

#pragma mark - initial

-(void)initialCollectionView
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    
    self.imageCollectiobView = [[UICollectionView alloc] initWithFrame:self.view.bounds collectionViewLayout:flowLayout];
    _imageCollectiobView.delegate = self;
    _imageCollectiobView.dataSource = self;
    [_imageCollectiobView registerClass:[HCImagePickerCollectionViewCell class] forCellWithReuseIdentifier:HCImagePickerCollectionViewCellIdentifier];
    
    [self.view addSubview:_imageCollectiobView];
}

-(void)initialToolBarItem
{
    UIBarButtonItem *leftToolBarItem = [[UIBarButtonItem alloc] initWithTitle:@"Preview" style:UIBarButtonItemStylePlain target:self action:@selector(previewAction)];
    UIBarButtonItem *rightToolBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    UIBarButtonItem *flexibelToolBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    HCNumberLabel *numberLabel = [[HCNumberLabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20) number:0];
    UIBarButtonItem *numberToolBarItem = [[UIBarButtonItem alloc] initWithCustomView:numberLabel];
    
    leftToolBarItem.enabled = NO;
    rightToolBarItem.enabled = NO;
    
    self.toolbarItems = @[leftToolBarItem, flexibelToolBarItem, numberToolBarItem, rightToolBarItem];
}

-(void)initailNavigation
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
}

#pragma mark - Private

/**
 *  fetch all the images in the group
 */
-(void)fetchImages
{
    if (!_imageModelArray)
    {
        self.imageModelArray = [NSMutableArray array];
    }
    
    [_imageGroup.originalAssetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        
        if (result)
        {
            HCImageModel *imgModel = [HCImageModel imageModelWithAsset:result];
            [self.imageModelArray addObject:imgModel];
            [_imageCollectiobView reloadData];
        }
    }];
}

/**
 *  cancel to choose images
 */
-(void)cancelAction
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

/**
 *  preview these choosed images
 */
-(void)previewAction
{
    HCImagePreviewViewController *previewViewController = [[HCImagePreviewViewController alloc] init];
    previewViewController.previewImageArray = _choosedImagesArray;
    previewViewController.choosedImages = _choosedImagesArray;
    
    [self.navigationController pushViewController:previewViewController animated:YES];
}

/**
 *  finish choosing images
 */
-(void)doneAction
{
    NSMutableArray *imagesArray = [NSMutableArray array];
    [_choosedImagesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [imagesArray addObject:[(HCImageModel *)obj assetFullScreenImage]];
    }];
    
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:HCMultiImagePickerControllerDidFinishChoosedNotification object:imagesArray];
    }];
}

/**
 *  refresh the toolbar when any changes happened
 */
-(void)toolbarRefresh
{
    [_choosedImagesArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![(HCImageModel *)obj isChoosed])
        {
            [_choosedImagesArray removeObject:obj];
        }
    }];
    
    [self.toolbarItems[0] setEnabled:_choosedImagesArray.count > 0];
    HCNumberLabel *numberLabel = (HCNumberLabel *)[self.toolbarItems[2] customView];
    numberLabel.number = _choosedImagesArray.count;
    [self.toolbarItems[3] setEnabled:_choosedImagesArray.count > 0];
}

#pragma mark - UICollectionViewDataSource
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _imageModelArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HCImageModel *imgModel = _imageModelArray[indexPath.item];

    HCImagePickerCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:HCImagePickerCollectionViewCellIdentifier forIndexPath:indexPath];
    
    [cell cellConfigurationWith:imgModel];
    [cell cellDidChoosed:^(HCImagePickerCollectionViewCell *cell, BOOL isChoosed) {
        if (isChoosed)
        {
            [_choosedImagesArray addObject:imgModel];
        }
        else
        {
            [_choosedImagesArray removeObject:imgModel];
        }
        
        [self toolbarRefresh];
    }];
    
    return cell;
}

#pragma mark - UICollectionViewDelegateFlowLayout
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = kScreenRect.size.width;
    CGFloat imageHW = (width - 40) / 4;
    
    return CGSizeMake(imageHW, imageHW);
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsMake(5, 5, 5, 5);
}

#pragma mark - UICollectionViewDelegate
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:NO];
    
    HCImagePreviewViewController *previewViewController = [[HCImagePreviewViewController alloc] init];
    previewViewController.previewImageArray = @[_imageModelArray[indexPath.row]];
    previewViewController.choosedImages = self.choosedImagesArray;
    
    [self.navigationController pushViewController:previewViewController animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
