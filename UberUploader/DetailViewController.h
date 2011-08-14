//
//  DetailViewController.h
//  UberUploader
//
//  Created by Aditya Matharu on 07/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController <UISplitViewControllerDelegate>
{
    UIImageView *selectedImageView;
    UIView *ViewforImageView;
    UIImageView *BackgroundView;
    UIView *share;
    UIView *masterView;
}

@property (strong, nonatomic) IBOutlet UIImageView *selectedImageView;
@property (strong, nonatomic) IBOutlet UIView *ViewforImageView;
@property (strong, nonatomic) IBOutlet UIImageView *BackgroundView;
@property (strong, nonatomic) IBOutlet UIView *share;

@property (strong, nonatomic) IBOutlet UIView *masterView;


@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

-(IBAction)ShareView:(id)sender;
-(IBAction)ShareViewCancel:(id)sender;
-(IBAction)ShareNow:(id)sender;
-(void)HideShareView;
- (UIImage *)convertImageToGrayScale:(UIImage *)image;



@end
