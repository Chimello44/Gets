//
//  CadastroView.h
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CadastroView : UIViewController
- (IBAction)addPhoto:(id)sender;
- (IBAction)takePhoto:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imageSign;

@end
