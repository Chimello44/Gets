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

@interface MainView : UIViewController <CLLocationManagerDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet MKMapView *mainMap;
@property(retain) CLLocationManager *locationManager;
- (IBAction)refresh:(id)sender;


@end
