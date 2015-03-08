//
//  TableViewController.h
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AssetsLibrary/AssetsLibrary.h>

#import "UserData.h"
#import "AppDelegate.h"
#import "FavoriteCell.h"
#import "VisualizarView.h"
#import "MainView.h"

@interface TableViewController : UITableViewController
{
    AppDelegate *appDeledate;
}

- (IBAction)goBack:(id)sender;
@property long row;


@end
