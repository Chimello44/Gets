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
//    CLLocationCoordinate2D loc=[[locations lastObject]coordinate];
//   
//    region = MKCoordinateRegionMakeWithDistance(loc,250,250);
//    [self.locationManager stopUpdatingLocation];
//    NSLog(@"%@", [locations lastObject]);
//    
    
}

-(void) locationManager:(CLLocationManager *)manager didfailWithError:(NSError *)locations{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark  - Implementacões do grupo

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

    
    //    _site = [[Site alloc]initWithSiteName:@"mySite" andSiteInfo:@"novo local na região" andCoordinates: coord];
    //    [_mainMap addAnnotation:_site];
    
    //define a porção do mapa para mostrar
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(coord, 250, 250);
    
    //muda a região visível e opcionalmente animação
    [_mainMap setRegion:region animated: YES];
    
    [locationManager stopUpdatingLocation];
    
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
    [self.locationManager startUpdatingLocation];
    [_mainMap setRegion:region animated:YES];
}
@end
