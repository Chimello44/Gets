//
//  CadastroView.h
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Site.h"

@interface CadastroView : UIViewController
- (IBAction)addPhoto:(id)sender;
- (IBAction)takePhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageSign;
- (IBAction)buttonSingupPlace:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *fieldName;
@property (weak, nonatomic) IBOutlet UITextField *fieldDescription;


@end
