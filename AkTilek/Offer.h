//
//  Offer.h
//  AkTilek
//
//  Created by Marat on 24.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Offer : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *descr;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSString *stringURL;

-(instancetype) initWithName:(NSString *)name andDescr:(NSString *)descr andImage:(UIImage *)image andURL:(NSString *)stringURL;

@end
