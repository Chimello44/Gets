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
   
    
    //permissão o selector aponta para essa função requestWhenInUseAuthorization que identifica a usagem em foreground.
        if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"World_Map_1689"]];
    
    [locationManager startUpdatingLocation];
    [self.mainMap setDelegate:self];
    self.mainMap.showsUserLocation = YES;
    
}

//metodo de inicialização da instancia de locationManager da classe CLLocationManager

//metodo que indica que uma nova location foi encontrada
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    
    NSLog(@"coordenadas: %@", [locations lastObject]);
    [self foundLocation:[locations lastObject]];
    
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

    
    _myAnnotation = [[Annotation alloc] initWithCoordinate:coord andTitle: @"teste"];
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
                  [[directionsResponse routes] enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL * stop)
                   {
                       MKPolyline * partialDirectionLine = [(MKRoute *)object polyline];
                       [[self mainMap] addOverlay:partialDirectionLine];
                       
//                       MKRoute *route = object;
//                       MKPolyline *line = [route polyline];
//                       [_mainMap addOverlay:line];
//                       
                       
                   }];
              
          }];
    
    [[self mainMap]addAnnotation:sourceAnnotation];
    [[self mainMap]addAnnotation:destinationAnnotation];
    
     }




#pragma mark MKMapViewDelegate
////setting the line
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    NSLog(@"entrei");
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
    NSLog(@"sai!");
    return nil;
}

//-(MKOverlayRenderer *)mapView:(MKMapView *)mapView rendererForOverlay:(id<MKOverlay>)overlay{
//    MKPolylineRenderer *polylineRender = [[MKPolylineRenderer alloc] initWithOverlay:overlay];
//    polylineRender.lineWidth = 3.0f;
//    polylineRender.strokeColor = [UIColor blueColor];
//    return polylineRender;
//}

     


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)traceRoute:(id)sender {
//    NSLog(@"Apertei o traceRoute");
//    Site *siteAux = [[Site alloc]initWithSiteName:@"Local teste" andCoordinates:CLLocationCoordinate2DMake(-23.547913, -46.650344)];
//    CLLocation *sourceLocation = [[CLLocation alloc]initWithLatitude:-23.542657 longitude:-46.657519];
//    CLLocationCoordinate2D coord = [sourceLocation coordinate];
//    [self drawRouteOnMap: sourceLocation destination:siteAux];
//    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250,250);
//    [_mainMap setRegion:region animated:YES];
//    
//    NSLog(@"final do traceRoute");
    
    MKPointAnnotation * sourceAnnotation = [[MKPointAnnotation alloc] init];
    [sourceAnnotation setTitle:@"Mackenzie"];
    [sourceAnnotation setCoordinate:CLLocationCoordinate2DMake(-23.547913,-46.650344)];
    MKPointAnnotation * destinationAnnotation = [[MKPointAnnotation alloc] init];
    [destinationAnnotation setTitle:@"Shopping Higienopolis"];
    [destinationAnnotation setCoordinate:CLLocationCoordinate2DMake(-23.542657,-46.657519)];
    
        MKMapItem * source = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(-23.547913,-46.650344) addressDictionary:nil]];
        [source setName:@"Mackenzie"];
        MKMapItem * destination = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(-23.542657,-46.657519) addressDictionary:nil]];
        [destination setName:@"Shopping Higienopolis"];
        MKDirectionsRequest * directionsRequest = [[MKDirectionsRequest alloc] init];
        [directionsRequest setSource:source];
        [directionsRequest setDestination:destination];
        [directionsRequest setTransportType:MKDirectionsTransportTypeAny];
        MKDirections * directions = [[MKDirections alloc] initWithRequest:directionsRequest];
        [directions calculateDirectionsWithCompletionHandler:^(MKDirectionsResponse * directionsResponse, NSError * error)
         {
             NSLog(@"teste");
                 [[directionsResponse routes] enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL * stop)
                  {
                      MKPolyline * partialDirectionLine = [(MKRoute *)object polyline];
                      [[self mainMap] addOverlay:partialDirectionLine];
                      NSLog(@"deveria ter desenhado");
                  }];
             
         }];
    
    [self.mainMap addAnnotation:sourceAnnotation];
    [self.mainMap addAnnotation:destinationAnnotation];
    
    
}

- (IBAction)refresh:(id)sender {
    [self.locationManager startUpdatingLocation];
    [_mainMap setRegion:region animated:YES];
}
@end
