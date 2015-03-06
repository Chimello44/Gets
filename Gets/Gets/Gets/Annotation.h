//
//  Annotation.h
//  Gets
//
//  Created by Rafael  Hieda on 03/03/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "Site.h"
@interface Annotation : NSObject <MKAnnotation>


@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (copy, nonatomic) NSString *title;

-(id)initWithCoordinate:(CLLocationCoordinate2D)coord andTitle:(NSString *) t;
-(id) init;
-(id) initWithSite:(Site *)site;
@end
