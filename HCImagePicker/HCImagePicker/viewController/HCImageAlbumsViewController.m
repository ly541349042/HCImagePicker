//
//  HCImageAlbumsViewController.m
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import "HCImageAlbumsViewController.h"
#import "HCMultiImagePickerController.h"
#import "HCImagePreviewViewController.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "HCImageGroupModel.h"

@interface HCImageAlbumsViewController () <UITableViewDataSource, UITableViewDelegate>

/**
 *  the `ALAssetsLibrary`
 */
@property (nonatomic, strong) ALAssetsLibrary *assetsLibray;

/**
 *  the `NSMutableArray` stores groups
 */
@property (nonatomic, strong) NSMutableArray *groupsArray;

/**
 *  the `UITableView` to display albums
 */
@property (nonatomic, strong) UITableView *albumsTableView;

@end

@implementation HCImageAlbumsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelAction)];
    
    [self initialTableView];
    [self fetchImageGroup];
    
    // add observer to the `NSNotificationCenter`
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishChooseImage:) name:HCMultiImagePickerControllerDidFinishChoosedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didFinishChooseImage:) name:HCImagePreviewViewControllerDidFinishChoosedNotification object:nil];
}

#pragma mark - Dealloc
-(void)dealloc
{
    // remove observer from `NSNotificationCenter`
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - initial
-(void)initialTableView
{
    self.albumsTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _albumsTableView.delegate = self;
    _albumsTableView.dataSource = self;
    _albumsTableView.tableFooterView = [[UIView alloc] init];
    _albumsTableView.rowHeight = 60;
    
    [self.view addSubview:_albumsTableView];
}

/**
 *  fetch all the `ALAssetsGroup` in the library
 */
-(void)fetchImageGroup
{
    if (!_assetsLibray)
    {
        self.assetsLibray = [[ALAssetsLibrary alloc] init];
    }
    
    if (!_groupsArray)
    {
        _groupsArray = [NSMutableArray array];
    }
    
    [_assetsLibray enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        HCImageGroupModel *groupModel = [HCImageGroupModel imageGroupModelWithAssetGroup:group];
        if (groupModel.assetsGroupName)
        {
            [_groupsArray addObject:groupModel];
            [_albumsTableView reloadData];
        }
        
    } failureBlock:^(NSError *error) {
        
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
 *  response when receive notification
 *
 *  @param noti `NSNotification` object
 */
-(void)didFinishChooseImage:(NSNotification *)noti
{
    NSArray *imagesArray = noti.object;
    
    if ([_delegate respondsToSelector:@selector(imageAlbumsViewController:didFinishPickingImage:)])
    {
        [_delegate imageAlbumsViewController:self didFinishPickingImage:imagesArray];
    }
}

#pragma mark - UITableViewDataSource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _groupsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HCImageGroupModel *groupModel = _groupsArray[indexPath.row];
    
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    cell.textLabel.attributedText = [groupModel groupNameWithAssetsNumber];
    cell.imageView.image = groupModel.assetsGroupThumbnail;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

#pragma mark - UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    HCImageGroupModel *groupModel = _groupsArray[indexPath.row];
    HCMultiImagePickerController *multiPicker = [[HCMultiImagePickerController alloc] init];
    multiPicker.title = groupModel.assetsGroupName;
    multiPicker.imageGroup = groupModel;
    
    [self.navigationController pushViewController:multiPicker animated:YES];
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
