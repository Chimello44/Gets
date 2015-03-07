//
//  VisualizarView.h
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MainView.h"

@interface VisualizarView : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property long row;


@property (nonatomic, strong) AppDelegate *appDelegate;

@end
