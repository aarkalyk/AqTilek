//
//  CategoryCollectionViewCell.m
//  AkTilek
//
//  Created by Marat on 10.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "CategoryCollectionViewCell.h"

@implementation CategoryCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        self.name = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame)-CGRectGetWidth(frame)/6, 70)];
        self.imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame)-CGRectGetWidth(frame)/6, 70)];
        
        [self.contentView addSubview:self.imageView];
        [self.contentView addSubview:self.name];
    }
    
    return self;
}

@end
