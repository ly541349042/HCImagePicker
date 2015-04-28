//
//  HCCheckButton.h
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HCCheckButton : UIButton

@property (nonatomic, assign, getter = isChoosed) BOOL choosed;

+(instancetype)checkButton;

@end
