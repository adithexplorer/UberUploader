//
//  DetailViewController.m
//  UberUploader
//
//  Created by Aditya Matharu on 07/08/2011.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"
#import <QuartzCore/QuartzCore.h>
#import <CoreImage/CoreImage.h>
#import "ImageEditor.h"

@interface DetailViewController ()
@property (strong, nonatomic) UIPopoverController *popoverController;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize detailItem = _detailItem;
@synthesize detailDescriptionLabel = _detailDescriptionLabel;
@synthesize popoverController = _myPopoverController;
@synthesize selectedImageView;
@synthesize ViewforImageView;
@synthesize BackgroundView;
@synthesize share;
@synthesize masterView;

- (id)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
    }
    return self;
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.popoverController != nil) {
        [self.popoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.frame = self.view.bounds;
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
    
    //UIColor *WoodBackground = [UIColor colorWithPatternImage:[UIImage imageNamed:@"WoodFloorwithNoebook.png"]];
    //self.view.backgroundColor = WoodBackground;
    share.layer.shadowOffset = CGSizeMake(-2,0);
    share.layer.shadowRadius = 5;
    share.layer.shadowOpacity = 0.5;
    
    share.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width/2, self.view.frame.size.height);
    share.hidden = YES;
    BackgroundView.frame = self.view.frame;
    BackgroundView.image = [UIImage imageNamed:@"WoodFloorwithNoebook.png"];
    
        //These 3 lines cause the uiimageview to have a rotation
    self.view.autoresizesSubviews = NO;
    
    selectedImageView.backgroundColor = [UIColor blueColor];
    
    ViewforImageView.transform = CGAffineTransformMakeRotation(0.24);
    ViewforImageView.layer.shadowOffset = CGSizeMake(-2,2);
    ViewforImageView.layer.shadowRadius = 2;
    ViewforImageView.layer.shadowOpacity = 0.8;
    
    selectedImageView.image = [UIImage imageNamed:@"WoodFloor.png"];
    
    if(selectedImageView.image ==nil)
    {
        ViewforImageView.hidden = YES;
    }
    else
    {
        BackgroundView.image = [self convertImageToGrayScale:BackgroundView.image];
    
    }
    
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation{
    for(UIView *subview in [self.view subviews]){
    ViewforImageView.center = self.view.center;
        BackgroundView.center = self.view.center;
        
        if (share.hidden == YES) {
        share.frame = CGRectMake(self.view.frame.size.width, 0, self.view.frame.size.width/2, self.view.frame.size.height);
        }
        else
        {
            share.frame = CGRectMake(self.view.frame.size.width/2, 0, self.view.frame.size.width/2, self.view.frame.size.height);

        }

}
}

//have converted to CIIMage Check what happns
- (UIImage *)convertImageToGrayScale:(UIImage *)image {
    
 //I Think this Works
    CIImage *input = [CIImage imageWithCGImage:image.CGImage];
    CIFilter *filter = [CIFilter filterWithName:@"CIColorMonochrome"];
   
    [filter setValue:input forKey:kCIInputImageKey];
    [filter setValue:[CIColor colorWithRed:0.5 green:0.5 blue:0.5] forKey:@"inputColor"];
    
    CIContext *context = [CIContext contextWithOptions:nil];
       
    CIImage *newImageCI = [filter valueForKey:kCIOutputImageKey];
    
    CGImageRef cgImage = [context createCGImage:newImageCI fromRect:[newImageCI extent]];
    // Return the new grayscale image
    UIImage *newImage = [UIImage imageWithCGImage:cgImage];
    return newImage; 
}

-(IBAction)ShareView:(id)sender
{
    //Shows the share view and disables all other views underneath it
    share.hidden = NO;
    
    CATransition *shareViewSlide;
    shareViewSlide = [CATransition animation];
    shareViewSlide.duration = 0.35;
    shareViewSlide.type = kCATransitionPush;
    shareViewSlide.subtype = kCATransitionFromRight;
    
    [share.layer addAnimation:shareViewSlide forKey:nil];
    
    share.center = CGPointMake(self.view.frame.size.width*0.75, share.center.y);
    
      
}

-(IBAction)ShareViewCancel:(id)sender
{
    //Cancels and hides the share View and enables views underneath it
    
    CATransition *shareViewSlide;
    shareViewSlide = [CATransition animation];
    shareViewSlide.duration = 0.35;
    shareViewSlide.type = kCATransitionPush;
    shareViewSlide.subtype = kCATransitionFromLeft;
    
    [share.layer addAnimation:shareViewSlide forKey:nil];
    
    share.center = CGPointMake(self.view.frame.size.width*1.25, share.center.y);
    
    share.hidden = YES;
}

-(void)HideShareView
{
    CATransition *shareViewSlide;
    shareViewSlide = [CATransition animation];
    shareViewSlide.duration = 0.35;
    shareViewSlide.type = kCATransitionPush;
    shareViewSlide.subtype = kCATransitionFromLeft;
    
    
    [share.layer addAnimation:shareViewSlide forKey:nil];
    
    share.center = CGPointMake(self.view.frame.size.width*1.25, share.center.y);
    
    share.hidden = YES;
}

-(IBAction)ShareNow:(id)sender
{
    //This code submits all info and queues photo(s) for upload + it animates the photo(s) away
    [self HideShareView];
    
    

    
    CATransition *shareNowAnimation;
    shareNowAnimation = [CATransition animation];
    shareNowAnimation.duration = 0.5;
    shareNowAnimation.type = kCATransitionPush;
    shareNowAnimation.subtype = kCATransitionFromLeft;
    
        [ViewforImageView.layer addAnimation:shareNowAnimation forKey:@"transform"];
    
    ViewforImageView.center = CGPointMake(self.view.frame.size.width*1.5, ViewforImageView.center.y);
    
    
    
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
   // ViewforImageView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);

}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)awakeFromNib
{
    self.splitViewController.delegate = self;
}
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
    } else {
        return YES;
    }
}

#pragma mark - Split view

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.popoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.popoverController = nil;
}

//??
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender 
{
    if ([[segue identifier] isEqualToString:@"ImageEditor"]) {
        // I'm using Core Data here, so I'll ask the fetched results controller.
        // Perform whatever model object lookup you're performing in -tableView:cellForRowAtIndexPath:,
        //   if you're not using Core Data.
       
        ImageEditor *editor = [segue destinationViewController];
        editor.editedImage = self.selectedImageView;
    }
}

@end
