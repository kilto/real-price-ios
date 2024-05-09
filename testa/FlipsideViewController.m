//
//  FlipsideViewController.m
//  real_price
//
//  Created by Koolapat Sirikamol on 5/22/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import "FlipsideViewController.h"
#import <MessageUI/MFMailComposeViewController.h>

@interface FlipsideViewController ()

@end
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation FlipsideViewController
@synthesize delegate = _delegate;


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    switch (section) {
        case 0:
            return 1;
            break;
        case 1:
            return 1;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                cell.textLabel.text = @"Help Screen";                
            }
            
            break;
            
        case 1:
            if(indexPath.row == 0){
                cell.textLabel.text = @"Contact Support / Suggestion";                
            }
            break;
            
        case 2:
            if(indexPath.row == 0){
                cell.textLabel.text = @"Review on iTunes";
            }else{
                cell.textLabel.text = @"Visit our website";
            }
            break;
            
        case 3:
            cell.textLabel.text = @"Credits";
            break;
            
        default:
            break;
    }

    return cell;    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 4;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return @"Help";
            break;
        case 1:
            return @"Contact";
            break;
        case 2:
            return @"Review";
            break;
        case 3:
            return @"Credits";
            break;
            
        default:
            break;
    }
    return nil;
}

- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section{
    if(section == 3){
        return @"Real Price v.1.4";
    }
    return nil;
}

///////////////////////////
-(void)rePositionForIPHONE5{
    UITableView *tableView=(UITableView*)[self.view viewWithTag:50];
    tableView.frame = CGRectMake(tableView.frame.origin.x,tableView.frame.origin.y-90,tableView.frame.size.width,tableView.frame.size.height+90);

}


- (void)viewDidLoad
{
    [super viewDidLoad];
    if(IS_IPHONE_5)
        [self rePositionForIPHONE5];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    [self.parentViewController dismissModalViewControllerAnimated: YES];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (indexPath.section) {
        case 0:
            if(indexPath.row == 0){
                [self performSegueWithIdentifier: @"helpview" sender: self];
            }else{
                [self performSegueWithIdentifier: @"aboutview" sender: self];
            }
            break;
        case 1:
            if(indexPath.row == 0){                
                MFMailComposeViewController* controller = [[MFMailComposeViewController alloc] init];
                controller.mailComposeDelegate = (id)self;
                [controller setSubject:@"Real Price [Contact Support / Suggestion]"];
                [controller setToRecipients:[NSArray arrayWithObject:@"gearbizz@gmail.com"]];
                [self presentModalViewController:controller animated:YES];
            }
            break;
        case 2:
            if(indexPath.row == 0){
        NSString *str = @"itms-apps://ax.itunes.apple.com/WebObjects/MZStore.woa/wa/viewContentsUserReviews?type=Purple+Software&id=541895087"; //replace the id param's value with your App's id
                //NSString *str = @"https://userpub.itunes.apple.com/WebObjects/MZUserPublishing.woa/wa/addUserReview?id=541895087&type=Purple+Software"; //replace the id param's value with your App's id
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];
            }else{
                NSString *str = @"http://www.gearbizz.com"; //replace the id param's value with your App's id
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:str]];

            }
            break;
            
        case 3:
            [self performSegueWithIdentifier: @"copyview" sender: self];
            break;
            
        default:
            break;
    }
}


- (void)mailComposeController:(MFMailComposeViewController*)controller  
          didFinishWithResult:(MFMailComposeResult)result 
                        error:(NSError*)error;
{
    if (result == MFMailComposeResultSent) {
    }
    [self dismissModalViewControllerAnimated:YES];
}





@end
