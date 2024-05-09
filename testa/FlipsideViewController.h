//
//  FlipsideViewController.h
//  real_price
//
//  Created by Koolapat Sirikamol on 5/22/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@class FlipsideViewController;

@protocol FlipsideViewControllerDelegate
    - (void)flipsideViewControllerDidFinish:(FlipsideViewController *)controller;
@end

//@interface FlipsideViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>{
@interface FlipsideViewController : UIViewController {    

}

//@property (weak, nonatomic) id <FlipsideViewControllerDelegate> delegate;
@property (unsafe_unretained, nonatomic) id <FlipsideViewControllerDelegate> delegate;
- (IBAction)done:(id)sender;

@end
