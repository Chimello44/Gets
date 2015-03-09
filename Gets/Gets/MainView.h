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
#import <iAd/iAd.h>

#import "Site.h"    
#import "Annotation.h"
#import "AppDelegate.h"
#import "CadastroView.h"

@interface MainView : UIViewController <CLLocationManagerDelegate, MKMapViewDelegate, ADBannerViewDelegate>
{
    BOOL bannerIsVisible;
}
@property AppDelegate *appDelegate;
@property long row;
@property Annotation* myAnnotation;
@property NSNotificationCenter *notificationCenter;
@property (weak, nonatomic) IBOutlet MKMapView *mainMap;
@property(strong, nonatomic) CLLocationManager *locationManager;
@property(readonly,nonatomic) CLLocation *myLocation;
- (IBAction)refresh:(id)sender;
-(void)findLocation;
-(void)foundLocation:(CLLocation *)location;
@property (weak, nonatomic) IBOutlet ADBannerView *ads;

-(void)drawRouteOnMap:(CLLocation *)sourceSite destination:(Site *)destinationSite;

-(void)drawRouteOnMap;

@end
