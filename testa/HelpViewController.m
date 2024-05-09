//
//  HelpViewController.m
//  real_price
//
//  Created by Koolapat Sirikamol on 1/21/56 BE.
//  Copyright (c) 2556 kilto2@hotmail.com. All rights reserved.
//

#import "HelpViewController.h"

@interface HelpViewController ()

@end
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation HelpViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) rePositionForIPHONE5{
    UIImageView *uiimgview = (UIImageView *)[self.view viewWithTag:50];
    [uiimgview setImage:[UIImage imageNamed:@"helpscreen_iphone5.png"]];
    uiimgview.frame = CGRectMake(uiimgview.frame.origin.x, 0, uiimgview.frame.size.width, uiimgview.frame.size.height+90);
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
