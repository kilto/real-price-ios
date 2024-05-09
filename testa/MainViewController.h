//
//  MainViewController.h
//  real_price
//
//  Created by Koolapat Sirikamol on 5/22/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import "FlipsideViewController.h"
#import "DataList.h"
#import "ZKRevealingTableViewCell.h"
#import "CompareManager.h"
#import "UnitMappingManager.h"
#include <AudioToolbox/AudioToolbox.h>

@interface MainViewController : UIViewController <UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource,UIPickerViewDataSource,UIPickerViewDelegate,ZKRevealingTableViewCellDelegate,UITextFieldDelegate>{
    
    NSMutableArray *dataList;
    NSMutableArray *editCellList;
    
    NSInteger tagCount;
    UIBarButtonItem *cancleButton;
    UIPickerView *pickerUnit;

    NSArray *areaUnit;   
    NSArray *byteUnit;    
    NSArray *lengthUnit;    
    NSArray *massUnit;    
    NSArray *volumeUnit;    
    NSArray *itemUnit;    
    NSArray *cataUnit;    
        
    ZKRevealingTableViewCell *cellToFlip;
    ZKRevealingTableViewCell *cellToEdit;
        
    CompareManager *compareManager;    
    UnitMappingManager *unitMappingManager;
    BOOL firstAdd;
    BOOL isEdit;
    
    CFURLRef		soundFileURLRef;
	SystemSoundID	soundFileObject;
    
}

typedef enum {
	NextFunction = 0,
	NextAndPutUnitFunction,
	DoneFunction
}FunctionButton;

// Contain all data in the list
@property (strong, nonatomic) NSMutableArray *dataList;

@property (weak, nonatomic) IBOutlet UIImageView *imgLabel;
@property (strong, nonatomic) ZKRevealingTableViewCell *cellToFlip;
@property (strong, nonatomic) ZKRevealingTableViewCell *cellToEdit;


@property (strong, nonatomic) NSArray *areaUnit;
@property (strong, nonatomic) NSArray *byteUnit;
@property (strong, nonatomic) NSArray *lengthUnit;
@property (strong, nonatomic) NSArray *massUnit;
@property (strong, nonatomic) NSArray *volumeUnit;
@property (strong, nonatomic) NSArray *itemUnit;
//- (IBAction)aboutTapped:(id)sender;

@property (strong, nonatomic) NSArray *cataUnit;

@property (strong, nonatomic) UIPickerView *pickerUnit;
// Contain all edit cell by order
@property (strong, nonatomic) NSMutableArray *editCellList;
@property (strong, nonatomic) CompareManager *compareManager;
@property (strong, nonatomic) UnitMappingManager *unitMappingManager;
// Count of edit button running number , 5 (per row) + 5 + 5 
@property (assign, nonatomic) NSInteger tagCount;
@property (assign, nonatomic) BOOL firstAdd;
@property (assign, nonatomic) BOOL isEdit;

// Table View
@property (weak, nonatomic) IBOutlet UITableView *tableviewP;

@property (weak, nonatomic) IBOutlet UIToolbar *toolBar;

@property (strong, nonatomic) UIBarButtonItem *cancleButton;
@property (strong, nonatomic) UIBarButtonItem *cancleEditButton;
@property (strong, nonatomic) UIBarButtonItem *doneEditButton;



@property (strong, nonatomic) IBOutlet UIBarButtonItem *rightButtonBar;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *flexibleBar;
@property (nonatomic, assign) BOOL showPercent;

@property (strong, nonatomic) IBOutlet UIImageView *firstBackground;

@property (weak, nonatomic) IBOutlet UIImageView *firstScreen;

@property (readwrite)	CFURLRef		soundFileURLRef;
@property (readonly)	SystemSoundID	soundFileObject;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *clearAllButtonBar;

- (IBAction)addTapped:(id)sender;
- (IBAction)clearTapped:(id)sender;



//TODO try to also add realprice lable at the top table view cell 

@end
