//
//  MainView.m
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "MainView.h"

@interface MainView ()

@end

@implementation MainView
@synthesize locationManager;
MKCoordinateRegion region;

- (void)viewDidLoad {
    [super viewDidLoad];
   
    locationManager = [[CLLocationManager alloc]init];
    
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate:self];
    
    //permissão
    
    if([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [locationManager requestWhenInUseAuthorization];
    }
    
    [locationManager startUpdatingLocation];
    [locationManager stopUpdatingLocation];
    _mainMap.showsUserLocation = YES;
    
    
    
}

-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    CLLocationCoordinate2D loc=[[locations lastObject]coordinate];
    
    region = MKCoordinateRegionMakeWithDistance(loc,150,150);
    NSLog(@"%@", [locations lastObject]);
    
    
}

-(void) locationManager:(CLLocationManager *)manager didfailWithError:(NSError *)locations{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)refresh:(id)sender {
    [locationManager startUpdatingLocation];
    [_mainMap setRegion:region animated:YES];
}
@end
