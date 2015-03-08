//
//  TableViewController.m
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "TableViewController.h"
#import "FavoriteCell.h"


@interface TableViewController ()
{
    UILongPressGestureRecognizer *longPressRecognizer;
    NSNotificationCenter *notificationCenter;
}

-(void)manageGestureRecognizer:(UIGestureRecognizer *)sender;

@end


@implementation TableViewController
@synthesize row;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    notificationCenter = [NSNotificationCenter defaultCenter];
    
    appDeledate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Site *sampleSite1 = [[Site alloc]initWithSiteName:@"Shopping Paulista" andSiteInfo:@"Entretenimento" andCoordinates:CLLocationCoordinate2DMake(-23.570554, -46.643602)];
    
    Site *sampleSite2 = [[Site alloc]initWithSiteName:@"Parque Ibirapuera" andSiteInfo:@"Entretenimento" andCoordinates:CLLocationCoordinate2DMake(-23.587416, -46.657634)];
    
    [[[appDeledate user]favoriteSpots]addObject:sampleSite1];
    [[[appDeledate user]favoriteSpots]addObject:sampleSite2];
    
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
//#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return [appDeledate.user.favoriteSpots count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FavoriteCell *cell = (FavoriteCell *)[tableView dequeueReusableCellWithIdentifier:@"itemCell" forIndexPath:indexPath];
    
    //setting the gestures
    longPressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(manageGestureRecognizer:)];
    [longPressRecognizer setMinimumPressDuration:4.0];
    [cell addGestureRecognizer:longPressRecognizer];
    
    UITapGestureRecognizer *tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(manageGestureRecognizer:)];
    tapGestureRecognizer.numberOfTapsRequired = 1;
    tapGestureRecognizer.numberOfTouchesRequired = 1;
    [cell addGestureRecognizer:tapGestureRecognizer];
    
    //setting the gestures
    
    
    row = [indexPath row];

    ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
    {
        ALAssetRepresentation *rep = [myasset defaultRepresentation];
        CGImageRef iref = [rep fullResolutionImage];
        if (iref) {
            UIImage *largeimage = [UIImage imageWithCGImage:iref];
            cell.imagePhotoPlace.image = largeimage;
        }
    };
    
    ALAssetsLibraryAccessFailureBlock failureblock  = ^(NSError *myerror)
    {
        NSLog(@"Can't get image - %@",[myerror localizedDescription]);
    };
    
    NSURL *myURL = [[NSURL alloc] init];

    myURL = [[appDeledate.user.favoriteSpots objectAtIndex:row] sitePhoto];
    
    ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init];
     [assetslibrary assetForURL:myURL
                    resultBlock:resultblock
                   failureBlock:failureblock];
    
    NSString *title =  [[appDeledate.user.favoriteSpots objectAtIndex:row]siteName];
    cell.labelTitlePlace.text = title;
    
//    [cell.imagePhotoPlace setImage:[UIImage imageWithData:myURL]];
    
    
    
//    cell.imagePhotoPlace.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@", myURL]];
    
    NSLog(@"%@ ajkjljlksd", cell.imagePhotoPlace);

    // Configure the cell...
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [appDeledate.user.favoriteSpots removeObjectAtIndex:[indexPath row]];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;    
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showDetails"]) {
        VisualizarView *view = [[VisualizarView alloc] init];
        view = segue.destinationViewController;
        NSIndexPath *myPath = [self.tableView indexPathForSelectedRow];
        
        row = [myPath row];
        
        view.row = row;
        [self dismissViewControllerAnimated:YES completion:nil];
    }
    else if ([[segue identifier] isEqualToString:@"mainView"])
    {
        MainView *mainView = [[MainView alloc] init];
        mainView = segue.destinationViewController;
        NSIndexPath *myPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myPath row];
        
        mainView.row = row;
        [notificationCenter postNotificationName:@"drawRouteOnMap" object:self];
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
        
    
}


//manage the gestures
-(void)manageGestureRecognizer:(UIGestureRecognizer *)sender
{
    if([sender isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        if([sender state] == UIGestureRecognizerStateEnded)
        {
            NSLog(@"LONGPRESS!");
          [self performSegueWithIdentifier:@"mainView" sender:self];
            

//            MainView *main = [[MainView alloc] init];
//            
//            main = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
//            NSLog(@"%lu minha row", row);
//            main.row = row;
//                        Sai da tableViewController
//            [self presentViewController:main animated:YES completion:nil];
        }
        else if([sender isKindOfClass:[UITapGestureRecognizer class]])
        if([sender state] == UIGestureRecognizerStateEnded)
        {
            NSLog(@"TAPGESTURE!");
            [self performSegueWithIdentifier:@"showDetails" sender:self];
            
        }
    }
}


- (IBAction)goBack:(id)sender {
        [self dismissViewControllerAnimated:YES completion:nil];
}
@end
