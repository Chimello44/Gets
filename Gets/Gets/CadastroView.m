//
//  CadastroView.m
//  Gets
//
//  Created by Hugo Luiz Chimello on 3/2/15.
//  Copyright (c) 2015 Hugo Luiz Chimello. All rights reserved.
//

#import "CadastroView.h"

@interface CadastroView ()

@end

@implementation CadastroView

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%f asasdsad", self.myLocation.latitude);
    // Do any additional setup after loading the view.
    [_imageSign.layer setBorderColor: [[UIColor blackColor] CGColor]];
    [_imageSign.layer setBorderWidth: 2.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)addPhoto:(id)sender {
    
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (IBAction)takePhoto:(id)sender {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

#pragma mark - Image Picker Controller delegate methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageSign.image = chosenImage;
    
    imageSource = [info objectForKey:UIImagePickerControllerReferenceURL];
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:NULL];
}



- (IBAction)buttonSingupPlace:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSLog(@"%@ UHUUU", imageSource);

//    Site *newSite = [[Site alloc] initWithSiteName:self.fieldName.text andSiteInfo:self.fieldDescription.text];
//    Site *newSite = [[Site alloc]initWithSiteName:[self.fieldName text] andSiteInfo:[self.fieldDescription text] andCoordinates:self.myLocation];

    Site *newSite = [[Site alloc] initWithSiteName:[self.fieldName text] andSiteInfo:[self.fieldDescription text] andPhotoSite:imageSource andCoordinates:self.myLocation];

//    NSLog(@"%@ uuuuu", newSite.sitePhotoSource);

    [appDelegate.user insertSite:newSite];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.fieldName resignFirstResponder];
    [self.fieldDescription resignFirstResponder];
}

- (IBAction)buttonGoBack:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
