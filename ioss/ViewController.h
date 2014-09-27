//
//  ViewController.h
//  ioss
//
//  Created by Ramya Deva on 9/26/14.
//  Copyright (c) 2014 ios. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UINavigationControllerDelegate, UIImagePickerControllerDelegate>


@property (weak, nonatomic) IBOutlet UIImageView *imageview;




- (IBAction)upload:(id)sender;

- (IBAction)getimage:(id)sender;

@end
