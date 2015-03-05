//
//  MainView.h
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "Site.h"
#import "Annotation.h"

@interface MainView : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate>
{
    
}
@property Annotation* myAnnotation;
@property (weak, nonatomic) IBOutlet MKMapView *mainMap;
@property(strong, nonatomic) CLLocationManager *locationManager;
//- (IBAction)traceRoute:(id)sender;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *refresh;
-(void)findLocation;
-(void)foundLocation:(CLLocation *)location;
-(void)drawRouteOnMap:(CLLocation *)sourceSite destination:(Site *)destinationSite;
@end
