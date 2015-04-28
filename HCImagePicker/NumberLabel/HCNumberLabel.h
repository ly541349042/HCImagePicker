//
//  HCNumberLabel.h
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCNumberLabel : UILabel

@property (nonatomic, assign) NSInteger number;

-(instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number;

@end
