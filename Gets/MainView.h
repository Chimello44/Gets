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
- (IBAction)refresh:(id)sender;
-(void)locationManagerStart;
-(void)findLocation;
-(void)foundLocation:(CLLocation *)location;
@end
