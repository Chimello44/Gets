//
//  MainView.m
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "MainView.h"

@implementation MainView
@synthesize locationManager, row, appDelegate, notificationCenter, myLocation;

- (void)viewDidLoad {
    
    [super viewDidLoad];
    notificationCenter = [NSNotificationCenter defaultCenter];
    //SharedApplication = "singleton" do appDelegate.
    appDelegate = (AppDelegate *) [[UIApplication sharedApplication]delegate];
    locationManager = [[CLLocationManager alloc]init];
    myLocation = [[CLLocation alloc]init];
    [locationManager setDelegate:self];
    [_mainMap setDelegate:self];
    [locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
    
    
    //permissão o selector aponta para essa função requestWhenInUseAuthorization que identifica a usagem em foreground.
    if([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]){
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    
    
    [locationManager startUpdatingLocation];
    
    self.mainMap.showsUserLocation = YES;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    NSLog(@"entrei no willAppear");
    [notificationCenter addObserver:self selector:@selector(drawRouteOnMap:) name:@"drawRouteOnMap" object:nil];
}

//metodo de inicialização da instancia de locationManager da classe CLLocationManager

//metodo que indica que uma nova location foi encontrada
-(void) locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{
    
    NSLog(@"entrei no didUpdateLocations");
    NSLog(@"coordenadas: %@", [locations lastObject]);
    myLocation = [locations lastObject];
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
    NSLog(@"entrei FindLocation");
    
    [locationManager startUpdatingLocation];
}


//método de adição da anotation no mapa
-(void) foundLocation:(CLLocation *)location
{
    NSLog(@"entrei foundLocation");
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
              
          }];
         
     }];
    
    [[self mainMap]addAnnotation:sourceAnnotation];
    [[self mainMap]addAnnotation:destinationAnnotation];
    
}


//só recebe o destino, traça a rota a partir do ponto atual.
-(void)drawRouteOnMap:(NSNotification *)sender
{
    if ([[sender name]isEqualToString:@"drawRouteOnMap"]);
    {
        NSLog(@"NOME: %@ ", [[[[appDelegate user]favoriteSpots]objectAtIndex:row]siteName]);
        CLLocationDegrees latitude = -23.6080276;
        CLLocationDegrees longitude = -46.7527555;
       
        
        //Setting annotations from the source and destination location
        CLLocationCoordinate2D myCoordinate = [myLocation coordinate];
        
        MKPointAnnotation *sourceAnnotation = [[MKPointAnnotation alloc]init];
        [sourceAnnotation setTitle:@"Localização atual"];
        [sourceAnnotation setCoordinate: myCoordinate ];
        
        MKPointAnnotation *destinationAnnotation = [[MKPointAnnotation alloc]init];
        [destinationAnnotation setTitle: [[[[appDelegate user]favoriteSpots]objectAtIndex:row]siteName]];
        [destinationAnnotation setCoordinate:[[[[appDelegate user]favoriteSpots]objectAtIndex:row]coordinates]];
        
        //setting placemark
        MKPlacemark *sourcePlacemark = [[MKPlacemark alloc]initWithCoordinate: myCoordinate addressDictionary:nil];
        MKPlacemark *destinationPlacemark = [[MKPlacemark alloc]initWithCoordinate: [[[[appDelegate user]favoriteSpots]objectAtIndex:row]coordinates] addressDictionary:nil];
        
        //setting MKMapItem objects.
        MKMapItem *source = [[MKMapItem alloc]initWithPlacemark:sourcePlacemark];
        [source setName:@"Local atual"];
        
        MKMapItem *destination = [[MKMapItem alloc]initWithPlacemark:destinationPlacemark];
        [destination setName:[[[[appDelegate user]favoriteSpots]objectAtIndex:row]siteName]];
        
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
             NSLog(@"deveria desenhar");
             [[directionsResponse routes] enumerateObjectsUsingBlock:^(id object, NSUInteger index, BOOL * stop)
              {
                  MKPolyline * partialDirectionLine = [(MKRoute *)object polyline];
                  [[self mainMap] addOverlay:partialDirectionLine];
                  
              }];
             
         }];
        
        [[self mainMap]addAnnotation:sourceAnnotation];
        [[self mainMap]addAnnotation:destinationAnnotation];
    }
}


- (IBAction)refresh:(id)sender {
    NSLog(@"apertei refresh");
    [self findLocation];
}

//- (IBAction)traceRoute:(id)sender {
//    //    Site *siteAux = [[Site alloc]initWithSiteName:@"Mackenzie" andCoordinates:CLLocationCoordinate2DMake(-23.547913, -46.650344)];
//    Site *siteAux = [[Site alloc]initWithSiteName:@"Local teste" andCoordinates:CLLocationCoordinate2DMake(-23.542657, -46.657519)];
//    
//    //_myLocation = sourceLocation;
//    [self drawRouteOnMap:siteAux];
//    //    CLLocationCoordinate2D coord = [sourceLocation coordinate];
//    //    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250,250);
//    //    [_mainMap setRegion:region animated:YES];
//    [self findLocation];
//}


-(void)viewDidAppear:(BOOL)animated
{    
    NSLog(@"sadasdasd %lu", self.row);
}

#pragma mark MKMapViewDelegate
////setting the line
-(MKOverlayView *)mapView:(MKMapView *)mapView viewForOverlay:(id<MKOverlay>)overlay
{
    if([overlay isKindOfClass:[MKPolyline class]])
    {
        NSLog(@"entrei");
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

-(void)passValueOfRow:(long)myRow
{
    self.row = myRow;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([[segue identifier]isEqualToString:@"signUp"])
    {
        //setting the location to coord
        CLLocationCoordinate2D coord = [myLocation coordinate];
        //setting the viewDestination
        CadastroView *signUpView = [segue destinationViewController];
        //setting the coordinate to the class coordinate
        signUpView.myLocation = coord;
        //dispatching to the CadastroView
    }
    if([[segue identifier]isEqualToString:@"viewFavorites"])
    {
        NSLog(@"aquiiiiii");
    }
}

@end

