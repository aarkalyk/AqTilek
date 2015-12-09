//
//  Offer.m
//  AkTilek
//
//  Created by Marat on 24.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import "Offer.h"

@implementation Offer

-(instancetype)initWithName:(NSString *)name andDescr:(NSString *)descr andImage:(UIImage *)image andURL:(NSString *)stringURL{
    self = [super init];
    
    if (self) {
        self.name = name;
        self.descr = descr;
        self.image = image;
        self.stringURL = stringURL;
    }
    
    return self;
}

@end
