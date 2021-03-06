//
//  VisualizarView.m
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "VisualizarView.h"
#import "TableViewController.h"

@interface VisualizarView ()

@end

@implementation VisualizarView

@synthesize row, imageView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    Instacia o AppDelegate como um tipo de singleton e um delegate para manter os dados atualizados em uma só instancia, pois, o objeto UserData que funciona como uma sessão contém o nsmutablearray com os lugares favoritos.
    
    _appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

    self.titleLabel.text = [[_appDelegate.user.favoriteSpots objectAtIndex:row] siteName];
     self.descriptionLabel.text = [[_appDelegate.user.favoriteSpots objectAtIndex:row] siteInfo];
    
    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            UIImage *largeimage = [UIImage imageWithCGImage:iref];
            self.imageView.image = largeimage;
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
    };
    
    NSURL *myURL = [[NSURL alloc] init];
    
    myURL = [[_appDelegate.user.favoriteSpots objectAtIndex:row] sitePhoto];
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
    [assetslibrary assetForURL:myURL
                   resultBlock:resultblock
                  failureBlock:failureblock];
    
    NSLog(@"OLHA AQUI %f", [[_appDelegate.user.favoriteSpots objectAtIndex:row] coordinates].latitude);
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
/*****************************
//    if ([[segue identifier] isEqualToString:@"traceRoute"]) {
////        MainView *gotoMain = [[MainView alloc] init];
////        
////        gotoMain.row = self.row;
////        gotoMain = segue.destinationViewController;
//
//    }
 *****************************/
}

@end
