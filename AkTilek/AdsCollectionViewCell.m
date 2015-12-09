//
//  AdsCollectionViewCell.m
//  AkTilek
//
//  Created by Marat on 24.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "AdsCollectionViewCell.h"

@implementation AdsCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, CGRectGetWidth(frame)/3, 30)];
        self.descrTextView = [[UITextView alloc] initWithFrame:CGRectMake(10, 50, CGRectGetWidth(frame), CGRectGetHeight(frame)-50)];
        self.descrTextView.backgroundColor = [UIColor clearColor];
        self.descrTextView.editable = NO;
        self.descrTextView.selectable = NO;
        self.descrTextView.textColor = [UIColor whiteColor];
        [self.descrTextView setFont:[UIFont fontWithName:@"Helvetica-Light" size:15]];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.darkView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.darkView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.5]];
        self.transparentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        [self.transparentView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0]];
        
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.darkView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.descrTextView];
        [self.contentView addSubview:self.transparentView];
    }
    
    return self;
}

@end
