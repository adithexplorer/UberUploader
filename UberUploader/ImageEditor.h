//
//  ImageEditor.h
//  UberUploader
//
//  Created by Aditya Matharu on 13/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ImageEditor : UIViewController
{
    UIImageView *editedImage;
    NSArray *builtInFilterList;
    UIPickerView *filterPicker;
}

@property (strong, nonatomic) IBOutlet UIImageView *editedImage;
@property (strong, nonatomic) IBOutlet  UIPickerView *filterPicker;
@end
