//
//  HCCheckButton.m
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import "HCCheckButton.h"

@implementation HCCheckButton

+(instancetype)checkButton
{
    HCCheckButton *btn = [HCCheckButton buttonWithType:UIButtonTypeCustom];
    btn.tintColor = [UIColor whiteColor];
    btn.choosed = NO;
    
    CGFloat radius = btn.frame.size.width / 2;
    btn.layer.cornerRadius = radius;
    
    UIImage *selectImage = [[UIImage imageNamed:@"AlbumCheckmark"] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    [btn setImage:selectImage forState:UIControlStateNormal];
    
    return btn;
}

-(void)setFrame:(CGRect)frame
{
    super.frame = frame;
    
    CGFloat radius = self.frame.size.width / 2;
    self.layer.cornerRadius = radius;
}

-(void)setChoosed:(BOOL)choosed
{
    _choosed = choosed;
    
    if (_choosed)
    {
        [self buttonSelected];
    }
    else
    {
        [self buttonUnselected];
    }
}

-(void)buttonSelected
{
    self.backgroundColor = [UIColor greenColor];
    self.layer.borderColor = [UIColor clearColor].CGColor;
    [self performAnimation];
}

-(void)buttonUnselected
{
    self.backgroundColor = [UIColor clearColor];
    self.layer.borderColor = [UIColor whiteColor].CGColor;
    self.layer.borderWidth = 0.5;
}

-(void)performAnimation
{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }];
        [UIView addKeyframeWithRelativeStartTime:0.5 relativeDuration:0.5 animations:^{
            self.transform = CGAffineTransformIdentity;
        }];
    } completion:^(BOOL finished) {
        
    }];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
