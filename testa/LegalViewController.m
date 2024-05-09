//
//  LegalViewController.m
//  real_price
//
//  Created by Koolapat Sirikamol on 1/21/56 BE.
//  Copyright (c) 2556 kilto2@hotmail.com. All rights reserved.
//

#import "LegalViewController.h"

@interface LegalViewController ()

@end
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation LegalViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) rePositionForIPHONE5{
    UITextView *repositionUI = (UITextView *)[self.view viewWithTag:50];
    repositionUI.frame = CGRectMake(repositionUI.frame.origin.x, 0, repositionUI.frame.size.width, repositionUI.frame.size.height+90);


}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if(IS_IPHONE_5)
        [self rePositionForIPHONE5];

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
