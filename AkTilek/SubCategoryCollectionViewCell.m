//
//  SubCategoryCollectionViewCell.m
//  AkTilek
//
//  Created by Marat on 10.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "SubCategoryCollectionViewCell.h"

@implementation SubCategoryCollectionViewCell


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(35, 10, CGRectGetWidth(frame)-CGRectGetWidth(frame)/3.5, 39)];
        [self.nameLabel setFont:[UIFont fontWithName:@"HelveticaNeue-Light" size:18]];
        self.starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 17, 20, 20)];
        
        self.line = [[UIView alloc] initWithFrame:CGRectMake(0, 59, CGRectGetWidth(frame)-CGRectGetWidth(frame)/5, 1)];
        self.line.backgroundColor = [UIColor colorWithRed:208/255.0 green:208/255.0 blue:208/255.0 alpha:0.2f];
        self.purpleLight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame)-CGRectGetWidth(frame)/5, 59)];
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.starImageView];
        [self.contentView addSubview:self.line];
        [self.contentView addSubview:self.purpleLight];
    }
    
    return self;
}
@end
