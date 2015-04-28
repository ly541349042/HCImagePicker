//
//  HCNumberLabel.m
//  CustomControl
//
//  Created by Homway on 4/27/15.
//  Copyright (c) 2015 HC. All rights reserved.
//

#import "HCNumberLabel.h"

@implementation HCNumberLabel

-(instancetype)initWithFrame:(CGRect)frame number:(NSInteger)number
{
    if (self = [super initWithFrame:frame])
    {
        self.number = number;
        self.backgroundColor = [UIColor greenColor];
        self.layer.cornerRadius = frame.size.width / 2;
        self.clipsToBounds = YES;
        
        self.textAlignment = NSTextAlignmentCenter;
        self.textColor = [UIColor whiteColor];
    }
    
    return self;
}

-(void)setNumber:(NSInteger)number
{
    _number = number;
    
    if (0 == _number)
    {
        self.hidden = YES;
    }
    else
    {
        self.hidden = NO;
        self.text = [NSString stringWithFormat:@"%ld", _number];
        [self performAnimation];
    }
}

-(void)performAnimation
{
    [UIView animateKeyframesWithDuration:0.3 delay:0 options:UIViewKeyframeAnimationOptionCalculationModeLinear animations:^{
        [UIView addKeyframeWithRelativeStartTime:0 relativeDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeScale(0.8, 0.8);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.3 relativeDuration:0.3 animations:^{
            self.transform = CGAffineTransformMakeScale(1.1, 1.1);
        }];
        
        [UIView addKeyframeWithRelativeStartTime:0.6 relativeDuration:0.4 animations:^{
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
