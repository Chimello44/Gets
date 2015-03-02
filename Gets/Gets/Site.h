//
//  Local.h
//  Gets
//
//  Created by Rafael  Hieda on 02/03/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>


@interface Site : NSObject
{
    NSString *siteName;
    NSString *infoSite;
    NSString *photoSite;
    CLLocationCoordinate2D coordinates;
    
}


@property NSString *siteName;

@property NSString *infoSite;

@property NSString *photoSite;

@property CLLocationCoordinate2D coordinates;
@end
