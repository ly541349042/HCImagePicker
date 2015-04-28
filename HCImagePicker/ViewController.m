//
//  ViewController.m
//  HCImagePicker
//
//  Created by Homway on 4/28/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import "ViewController.h"
#import "HCImageAlbumsViewController.h"

@interface ViewController () <HCImageAlbumsViewControllerProtocol>

- (IBAction)PresentImagePicker:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)PresentImagePicker:(id)sender
{
    HCImageAlbumsViewController *imgPicker = [[HCImageAlbumsViewController alloc] init];
    imgPicker.title = @"HCImagePicker";
    imgPicker.delegate = self;
    UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:imgPicker];
    
    [self presentViewController:navController animated:YES completion:^{
        
    }];
}

-(void)imageAlbumsViewController:(HCImageAlbumsViewController *)imageAlbumsViewController didFinishPickingImage:(NSArray *)images
{
//    CGFloat width = [UIScreen mainScreen].bounds.size.width;
//    CGFloat height = [UIScreen mainScreen].bounds.size.height;
//    
//    UIScrollView *scrollView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
//    scrollView.contentSize = CGSizeMake(images.count * width, height);
//    
//    
//    [images enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
//        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(idx * width, 0, width, height)];
//        imageView.image = obj;
//        
//        [scrollView addSubview:imageView];
//    }];
//    
//    [self.view addSubview:scrollView];
    NSLog(@"%@", images);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
