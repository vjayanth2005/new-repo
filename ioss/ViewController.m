//
//  ViewController.m
//  ioss
//
//  Created by Ramya Deva on 9/26/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property(nonatomic, strong) UIDocumentInteractionController* docController;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesBegan");
    
    CGPoint locationPoint = [[touches anyObject] locationInView:self.scr];
    
    NSLog(@"position %@", NSStringFromCGPoint(locationPoint));
    
    CGPoint supPoint = [self.scr convertPoint:locationPoint toView:self.view];
    
    NSLog(@"position sup %@", NSStringFromCGPoint(supPoint));
    
    isTouched = NO;
    
    
    
}

-(void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesMoved");
    
    CGPoint locationPoint = [[touches anyObject] locationInView:self.scr];
    
    NSLog(@"position %@", NSStringFromCGPoint(locationPoint));
    
    CGPoint supPoint = [self.scr convertPoint:locationPoint toView:self.view];
    
    NSLog(@"position sup %@", NSStringFromCGPoint(supPoint));
    
    if(!isTouched) {
        
        for (UIView *vw in viewObjectsArray) {
            if(CGRectContainsPoint(vw.frame, locationPoint)) {
                
                NSLog(@"view %ld touched",(long)vw.tag);
                
                tempView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, vw.frame.size.width, vw.frame.size.height)];
                tempView.backgroundColor = [UIColor redColor];
                tempView.center = supPoint;
                [self.view addSubview:tempView];
                //vw.hidden = YES;
                //selectedIndex = vw.tag;
                tempView.hidden = NO;
                isTouched = YES;
                self.scr.scrollEnabled = NO;
                
            }
            
        }
        //tempView.center = supPoint;
    }
    else
    {
        tempView.center = supPoint;
    }
    
}

-(void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    
    NSLog(@"touchesEnded");
    
    CGPoint locationPoint = [[touches anyObject] locationInView:self.scr];
    
    CGPoint dropPoint = [self.scr convertPoint:locationPoint toView:self.view];
    
    if(CGRectContainsPoint(_mainVw.frame, dropPoint)) {
        
        int i = arc4random() % 255;
        _mainVw.backgroundColor = [UIColor colorWithRed:120/255.0 green:i/255.0 blue:255.0/255.0 alpha:1.0];
        
    }
    
    [tempView removeFromSuperview];
    
    self.scr.scrollEnabled = YES;
    isTouched = NO;
}
- (IBAction)upload:(id)sender {
    
    NSString* imagePath = [NSString stringWithFormat:@"/image.igo", [NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES) lastObject]];
    [[NSFileManager defaultManager] removeItemAtPath:imagePath error:nil];
    [UIImagePNGRepresentation(_imageview.image) writeToFile:imagePath atomically:YES];
    NSLog(@"image size: @", NSStringFromCGSize(_imageview.image.size));
    
    _docController = [UIDocumentInteractionController interactionControllerWithURL:[NSURL fileURLWithPath:imagePath]];
    _docController.delegate=self;
    _docController.UTI = @"com.instagram.exclusivegram";
    //UIDocumentInteractionController _docController = [UIDocumentInteractionController interactionControllerWithURL:@"com.instagram.exclusivegram"];
                                                      
[_docController presentOpenInMenuFromRect:self.view.frame inView:self.view animated:YES];
                                                      
}

- (IBAction)getimage:(id)sender {
    
    UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.allowsEditing = YES;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:imagePicker animated:YES completion:nil];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    [self dismissViewControllerAnimated:YES completion:nil];
    _imageview.image = [info valueForKey:UIImagePickerControllerEditedImage];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
