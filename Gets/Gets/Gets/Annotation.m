//
//  Annotation.m
//  Gets
//
//  Created by Rafael  Hieda on 03/03/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "Annotation.h"

@implementation Annotation

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord andTitle:(NSString *)t
{
    self = [super init];
    if(self)
    {
        _coordinate = coord;
        _title = t;
    }
    return self;
}

-(id)init
{
    return [self initWithCoordinate:CLLocationCoordinate2DMake(43.07, -89.32) andTitle:@"Hometown"];
}

-(id)initWithSite:(Site *)site
{
    self = [super init];
    if(self)
    {
        _coordinate = [site coordinates];
        _title = [site siteName];
    }
    return self;
}

@end
