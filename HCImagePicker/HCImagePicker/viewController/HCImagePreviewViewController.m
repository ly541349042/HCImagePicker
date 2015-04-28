//
//  HCImagePreviewViewController.m
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import "HCImagePreviewViewController.h"
#import "HCNumberLabel.h"
#import "HCCheckButton.h"
#import "HCImageModel.h"

#define kScreenRect [UIScreen mainScreen].bounds
NSString *const HCImagePreviewViewControllerDidFinishChoosedNotification = @"HCImagePreviewViewControllerDidFinishChoosedNotification";

@interface HCImagePreviewViewController () <UIScrollViewDelegate>

@property (nonatomic, strong) UIScrollView *imagesScrollView;

@end

@implementation HCImagePreviewViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initialScrollView];
    [self initialToolBarItem];
    [self initialNavigation];
    [self displayImages];
    
    [self refreshToolbarAndNavigation];
}

-(void)viewDidAppear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:NO animated:NO];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [self.navigationController setToolbarHidden:YES animated:NO];
}

#pragma mark - initial
-(void)initialScrollView
{
    _imagesScrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    _imagesScrollView.pagingEnabled = YES;
    _imagesScrollView.bounces = NO;
    _imagesScrollView.backgroundColor = [UIColor blackColor];
    _imagesScrollView.delegate = self;
    
    [self.view addSubview:_imagesScrollView];
}

-(void)initialToolBarItem
{
    UIBarButtonItem *rightToolBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction)];
    UIBarButtonItem *flexibelToolBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    HCNumberLabel *numberLabel = [[HCNumberLabel alloc] initWithFrame:CGRectMake(0, 0, 20, 20) number:_previewImageArray.count];
    UIBarButtonItem *numberToolBarItem = [[UIBarButtonItem alloc] initWithCustomView:numberLabel];
    
    self.toolbarItems = @[flexibelToolBarItem, numberToolBarItem, rightToolBarItem];
}

-(void)initialNavigation
{
    HCCheckButton *checkButton = [HCCheckButton checkButton];
    checkButton.frame = CGRectMake(0, 0, 30, 30);
    checkButton.choosed = YES;
    [checkButton addTarget:self action:@selector(imageChoosedStateChange:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:checkButton];
}

/**
 *  to display all the images on scroll view
 */
-(void)displayImages
{
    CGFloat width = kScreenRect.size.width;
    CGFloat height  = kScreenRect.size.height - 44 - 20 - 49;
    _imagesScrollView.contentSize = CGSizeMake(width * _previewImageArray.count, height);
    
    [_previewImageArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(width * idx + 5, 0, width - 10, height)];
        
        imageView.image = [(HCImageModel *)obj assetFullScreenImage];
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        imageView.backgroundColor = [UIColor blackColor];
        
        [_imagesScrollView addSubview:imageView];
    }];
}

/**
 *  finish choosing images
 */
-(void)doneAction
{
    NSMutableArray *imagesArray = [NSMutableArray array];
    [_choosedImages enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        [imagesArray addObject:[(HCImageModel *)obj assetFullScreenImage]];
    }];
    
    [self dismissViewControllerAnimated:YES completion:^{
        
        if (imagesArray.count > 0)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:HCImagePreviewViewControllerDidFinishChoosedNotification object:imagesArray];
        }
    }];
}

/**
 *  response the image's choosing state changed
 *
 *  @param sender
 */
-(void)imageChoosedStateChange:(HCCheckButton *)sender
{
    sender.choosed = !sender.choosed;
    
    HCImageModel *currentImageModel = [self currentDisplayImageModel];
    currentImageModel.choosed = sender.choosed;
    
    if (sender.choosed)
    {
        [_choosedImages addObject:currentImageModel];
    }
    else
    {
        [_choosedImages removeObject:currentImageModel];
    }
    
    [self refreshToolbarAndNavigation];
}

-(void)refreshToolbarAndNavigation
{
    HCNumberLabel *numberLabel = (HCNumberLabel *)[self.toolbarItems[1] customView];
    numberLabel.number = _choosedImages.count;
    
    [self scrollViewDidEndDecelerating:_imagesScrollView];
}

/**
 *  the current displaying image
 *
 *  @return the current displaying image
 */
-(HCImageModel *)currentDisplayImageModel
{
    NSInteger index = _imagesScrollView.contentOffset.x / kScreenRect.size.width;
    
    return _previewImageArray[index];
}

#pragma mark - UIScrollViewDelegate
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    HCImageModel *currentImageModel = [self currentDisplayImageModel];
    
    HCCheckButton *checkButton = (HCCheckButton *)[self.navigationItem.rightBarButtonItem customView];
    
    if ([_choosedImages containsObject:currentImageModel])
    {
        checkButton.choosed = YES;
    }
    else
    {
        checkButton.choosed = NO;
    }
}

- (void)didReceiveMemoryWarning {
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
