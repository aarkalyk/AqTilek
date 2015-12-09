//
//  Tilek.m
//  AkTilek
//
//  Created by Marat on 10.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "Tilek.h"

@implementation Tilek

-(instancetype)initWithName:(NSString *)name andDescr:(NSString *)descr andisLiked:(BOOL)isLiked{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.descr = descr;
        self.isLiked = isLiked;
    }
    
    return self;
}

@end
