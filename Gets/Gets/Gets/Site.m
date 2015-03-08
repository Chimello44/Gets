//
//  Local.m
//  Gets
//
//  Created by Rafael  Hieda on 02/03/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "Site.h"


@implementation Site

@synthesize siteName, coordinates, sitePhoto, siteInfo;

-(id) initWithSiteName:(NSString *)nameSite andCoordinates:(CLLocationCoordinate2D)myCoordinate
{
    if(self = [super init])
    {
        siteName = nameSite;
        coordinates = myCoordinate;
    }
    return self;
}

-(id)initWithSiteName:(NSString *)nameSite andSiteInfo:(NSString *)infoSite
{
    if(self = [super init])
    {
        siteName = nameSite;
        siteInfo = infoSite;
    }
    return self;
}

-(id)initWithSiteName:(NSString *)nameSite andSiteInfo:(NSString *)infoSite andPhotoSite:(NSURL *)photoSite
{
    if(self = [super init])
    {
        siteName = nameSite;
        siteInfo = infoSite;
        sitePhoto = photoSite;
    }
    return self;
}


-(id)initWithSiteName:(NSString *)nameSite andSiteInfo:(NSString *)infoSite andPhotoSite:(NSURL *)photoSite andCoordinates:(CLLocationCoordinate2D )myCoordinate
{
    if(self = [super init])
    {
        siteName = nameSite;
        siteInfo = infoSite;
        sitePhoto = photoSite;
        coordinates = myCoordinate;
    }
    return self;
}

-(id)initWithSiteName:(NSString *)nameSite andSiteInfo:(NSString *)infoSite andCoordinates:(CLLocationCoordinate2D)myCoordinate

{
    if(self = [super init])
    {
        siteName = nameSite;
        siteInfo = infoSite;
        coordinates = myCoordinate;
    }
    return self;
}

@end
