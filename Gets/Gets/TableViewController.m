//
//  TableViewController.m
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "TableViewController.h"


@interface TableViewController ()
{
    UILongPressGestureRecognizer *longPressRecognizer;
}

-(void)manageGestureRecognizer:(UIGestureRecognizer *)sender;

@end

@implementation TableViewController
@synthesize row;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    longPressRecognizer = [[UILongPressGestureRecognizer alloc]initWithTarget:self action:@selector(manageGestureRecognizer:)];
    [longPressRecognizer setMinimumPressDuration:2.0];
    
    appDeledate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
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
    [cell addGestureRecognizer:longPressRecognizer];
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
    }
    /***************************
     Não é necessário, eu uso o self.dismissViewControllerAnimated que retorna para a página incial.
//    else if ([[segue identifier] isEqualToString:@"mainView"])
//    {
//        MainView *mainView = [[MainView alloc] init];
//        mainView = segue.destinationViewController;
//        NSIndexPath *myPath = [self.tableView indexPathForSelectedRow];
//        
//        long row = [myPath row];
//        
//        mainView.row = row;
//    
//    }
     ****************************/
    
    
}


//manage the gestures
-(void)manageGestureRecognizer:(UIGestureRecognizer *)sender
{
    if([sender isKindOfClass:[UILongPressGestureRecognizer class]])
    {
        if([sender state] == UIGestureRecognizerStateEnded)
        {
//            [self performSegueWithIdentifier:@"mainView" sender:self];

            MainView *main = [[MainView alloc] init];
            
            main = [self.storyboard instantiateViewControllerWithIdentifier:@"mainView"];
            NSLog(@"%lu minha row", row);
            main.row = row;
//                        Sai da tableViewController
            [self presentViewController:main animated:YES completion:nil];
        }
    }
}

- (IBAction)goBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
