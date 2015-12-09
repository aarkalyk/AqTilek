//
//  Tilek.h
//  AkTilek
//
//  Created by Marat on 10.11.15.
//  Copyright © 2015 GrownApps. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tilek : NSObject

@property (nonatomic) NSString *name;
@property (nonatomic) NSString *descr;
@property (nonatomic) BOOL isLiked;

-(instancetype) initWithName:(NSString *)name andDescr:(NSString *)descr andisLiked:(BOOL) isLiked;

@end
