//
//  Local.h
//  Gets
//
//  Created by Rafael  Hieda on 02/03/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface Site : NSObject <MKAnnotation>
{
    NSString *siteName;
    NSString *siteInfo;
    NSString *sitePhoto;
    CLLocationCoordinate2D coordinates;
    
}

-(id)initWithSiteName:(NSString *)nameSite andSiteInfo:(NSString *)infoSite;
-(id)initWithSiteName:(NSString *)nameSite andSiteInfo:(NSString *)infoSite andPhotoSite:(NSString *)photoSite;
-(id)initWithSiteName:(NSString *)nameSite andSiteInfo:(NSString *)infoSite andPhotoSite:(NSString *)photoSite andCoordinates:(CLLocationCoordinate2D)myCoordinate;
-(id)initWithSiteName:(NSString *)nameSite andSiteInfo:(NSString *)infoSite andCoordinates:(CLLocationCoordinate2D )myCoordinate;


@end
