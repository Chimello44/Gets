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
    
   
    [self locationManagerStart];
    
    //permissão o selector aponta para essa função requestWhenInUseAuthorization que identifica a usagem em foreground.
        if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"World_Map_1689.jpg"]];
    
    [locationManager startUpdatingLocation];
    self.mainMap.showsUserLocation = YES;
    [super viewDidLoad];
}

//metodo de inicialização da instancia de locationManager da classe CLLocationManager
-(void) locationManagerStart
{
    locationManager = [[CLLocationManager alloc]init];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    [locationManager setDelegate: self];
}


//metodo que indica que uma nova location foi encontrada
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    
    NSLog(@"coordenadas: %@", [locations lastObject]);
    [self foundLocation:[locations lastObject]];
    
    Site *siteAux = [[Site alloc]initWithSiteName:@"Local teste" andCoordinates:CLLocationCoordinate2DMake(-23.547913, -46.650344)];
    [self drawRouteOnMap:[locations lastObject] destination:siteAux];
    
    
    
}

-(void) locationManager:(CLLocationManager *)manager didfailWithError:(NSError *)locations{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - Implementacões do grupo

//gera a locaização atual do usuário
-(void) findLocation
{
    [self.locationManager startUpdatingLocation];
    
}


//método de adição da anotation no mapa
-(void) foundLocation:(CLLocation *)location
{
    //recebo a localização e passo a nova instancia de coordinate2d
    CLLocationCoordinate2D coord = [location coordinate];
    
    //adiciona os dados no objeto site que implementa o protocolo <MKAnnotation> e adiciona a annotation no mapa

    
//    _myAnnotation = [[Annotation alloc] initWithCoordinate:coord andTitle: @"teste"];
//    [_mainMap addAnnotation:_myAnnotation];
//    
    //define a porção do mapa para mostrar
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    
    //muda a região visível e opcionalmente animação
    [_mainMap setRegion:region animated: YES];
    
    [locationManager stopUpdatingLocation];
    
}

-(void)drawRouteOnMap:(CLLocation *)sourceSite destination:(Site *)destinationSite
{
    //Setting annotations from the source and destination locations
    MKPointAnnotation *sourceAnnotation = [[MKPointAnnotation alloc]init];
    [sourceAnnotation setTitle:@"Onde estou"];
    [sourceAnnotation setCoordinate:[sourceSite coordinate]];
    
    MKPointAnnotation *destinationAnnotation = [[MKPointAnnotation alloc]init];
    [destinationAnnotation setTitle:[destinationSite siteName]];
    [destinationAnnotation setCoordinate:[destinationSite coordinates]];
    
    //setting placemark
    MKPlacemark *sourcePlacemark = [[MKPlacemark alloc]initWithCoordinate: [sourceSite coordinate] addressDictionary:nil];
    MKPlacemark *destinationPlacemark = [[MKPlacemark alloc]initWithCoordinate: [destinationSite coordinates] addressDictionary: nil];
    
    //setting MKMapItem objects.
    MKMapItem *source = [[MKMapItem alloc]initWithPlacemark:sourcePlacemark];
    [source setName:@"Local atual"];
    MKMapItem *destination = [[MKMapItem alloc]initWithPlacemark:destinationPlacemark];
    [destination setName:[destinationSite siteName]];
    
    //setting MKDirectionsRequest
    MKDirectionsRequest *directionsRequest = [[MKDirectionsRequest alloc]init];
    [directionsRequest setSource:source];
    [directionsRequest setDestination:destination];
    [directionsRequest setTransportType: MKDirectionsTransportTypeAny];
    
    // setting MKDirections
    MKDirections *directions = [[MKDirections alloc]initWithRequest:directionsRequest];
    
    // Draw the lines.
    [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * directionsResponse, NSError * error)
          {
              if(error)
              {
                  NSLog(@"\n ERROR: \n\n%@\n",[error description]);
              }
              else
              {
                  [[directionsResponse routes] enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL * stop)
                   {
                       MKPolyline * partialDirectionLine = [(MKRoute *)object polyline];
                       [[self mainMap] addOverlay:partialDirectionLine];
                   }];
              }
          }];
     }

#pragma mark MKMapViewDelegate
//setting the line
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKPolyline class]])
    {
        UIColor *routeLineColor;
        CGFloat routeLineWidth;
        MKPolylineView *partialRoutePolylineView = [[MKPolylineView alloc]initWithPolyline:(MKPolyline *) overlay];
        
        routeLineColor = [UIColor colorWithRed:0.000 green:0.000 blue:1.000 alpha:0.700];
        routeLineWidth = 8;
        [partialRoutePolylineView setStrokeColor:routeLineColor];
        [partialRoutePolylineView setLineWidth:routeLineWidth];
        return partialRoutePolylineView;
    }
    return nil;
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
//    [self.locationManager startUpdatingLocation];
//    [_mainMap setRegion:region animated:YES];
    
    
    Site *siteAux = [[Site alloc]initWithSiteName:@"Local teste" andCoordinates:CLLocationCoordinate2DMake(-23.547913, -46.650344)];
    CLLocation *localTest = [[CLLocation alloc]initWithLatitude:-23.547913 longitude:-46.650344];
    [self drawRouteOnMap:localTest destination:siteAux];
    
}
@end
