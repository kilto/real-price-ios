//
//  MainViewController.m
//  real_price
//
//  Created by Koolapat Sirikamol on 5/22/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import "MainViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "ZKRevealingTableViewCell.h"
#import <math.h>

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )




@interface MainViewController ()

@end

@implementation UITextField (DisableCopyPaste)

- (BOOL)canPerformAction:(SEL)action withSender:(id)sender
{
    [UIMenuController sharedMenuController].menuVisible = NO;
    return NO;
}


@end




@implementation MainViewController

@synthesize dataList=_dataList;
@synthesize imgLabel;
@synthesize tableviewP;
@synthesize rightButtonBar;
@synthesize flexibleBar;
@synthesize toolBar;
@synthesize editCellList=_editCellList;
@synthesize tagCount;
@synthesize cancleButton;
@synthesize pickerUnit;

@synthesize areaUnit;
@synthesize byteUnit;
@synthesize cataUnit;
@synthesize compareManager;
@synthesize cellToFlip;
@synthesize showPercent;
@synthesize firstBackground;
@synthesize firstScreen;
@synthesize lengthUnit;
@synthesize massUnit;
@synthesize volumeUnit;
@synthesize itemUnit;
@synthesize unitMappingManager;

@synthesize firstAdd;
@synthesize isEdit;
@synthesize cellToEdit;

@synthesize soundFileURLRef;
@synthesize soundFileObject;
@synthesize clearAllButtonBar;

@synthesize cancleEditButton;
@synthesize doneEditButton;



-(void)changeRightButtonBarEdit{
    NSMutableArray *toolbarItems = [NSMutableArray arrayWithArray:[self.toolBar items]];
    [toolbarItems replaceObjectAtIndex:3 withObject:self.doneEditButton];
    [toolbarItems replaceObjectAtIndex:2 withObject:self.cancleEditButton];
    self.toolBar.items = toolbarItems;
}

-(void)changeRightButtonNormal{
    NSMutableArray *toolbarItems = [NSMutableArray arrayWithArray:[self.toolBar items]];
    [toolbarItems replaceObjectAtIndex:3 withObject:self.rightButtonBar];
    [toolbarItems replaceObjectAtIndex:2 withObject:self.clearAllButtonBar];
    self.toolBar.items = toolbarItems;
}

-(void)changeRightButtonBarToCancle{
    NSMutableArray *toolbarItems = [NSMutableArray arrayWithArray:[self.toolBar items]];
    [toolbarItems replaceObjectAtIndex:3 withObject:self.cancleButton];
    self.toolBar.items = toolbarItems;
}

-(void)changeRightButtonBarToAdd{
    NSMutableArray *toolbarItems = [NSMutableArray arrayWithArray:[self.toolBar items]];
    [toolbarItems replaceObjectAtIndex:3 withObject:self.rightButtonBar];
    self.toolBar.items = toolbarItems;        
}

-(void)cancleData{
    [self.dataList removeObjectAtIndex:0];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    ZKRevealingTableViewCell *cell= (ZKRevealingTableViewCell*)[self.tableviewP cellForRowAtIndexPath:indexPath];
    
    ZKRevealingTableViewCell *quantityTextField = (ZKRevealingTableViewCell *)[cell.backView viewWithTag:1];    
    ZKRevealingTableViewCell *sizeTextField = (ZKRevealingTableViewCell *)[cell.backView viewWithTag:2];
    ZKRevealingTableViewCell *unitTextField = (ZKRevealingTableViewCell *)[cell.backView viewWithTag:3];
    ZKRevealingTableViewCell *priceTextField = (ZKRevealingTableViewCell *)[cell.backView viewWithTag:4];
    [quantityTextField resignFirstResponder];
    [sizeTextField resignFirstResponder];
    [unitTextField resignFirstResponder];
    [priceTextField resignFirstResponder];
    
    [self.tableviewP deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self changeRightButtonBarToAdd];
}

-(void)initValue{
    
    NSURL *tapSound   = [[NSBundle mainBundle] URLForResource: @"tap"
                                                withExtension: @"aif"];
        
    // Store the URL as a CFURLRef instance
    self.soundFileURLRef = (__bridge CFURLRef) tapSound;
    
    // Create a system sound object representing the sound file.
    AudioServicesCreateSystemSoundID (soundFileURLRef,
                                      &soundFileObject);

    self.compareManager = [[CompareManager alloc] init];        
    self.unitMappingManager = [[UnitMappingManager alloc] initUnitMapping];

    self.cancleButton= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancleData)];
    [self.cancleButton setTintColor:[UIColor colorWithRed:0.878312 green:0.662122 blue:0.149506 alpha:1.0000]];
    
// Edit
    
    self.cancleEditButton= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancleEditData)];
    [self.cancleEditButton setTintColor:[UIColor colorWithRed:0.878312 green:0.662122 blue:0.149506 alpha:1.0000]];
    
    self.doneEditButton= [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneEditButtonTapped)];
    [self.doneEditButton setTintColor:[UIColor colorWithRed:0.878312 green:0.662122 blue:0.149506 alpha:1.0000]];
    
// End Edit
    
    self.pickerUnit = [[UIPickerView alloc] init];      
    self.pickerUnit.delegate = self;
    self.pickerUnit.dataSource = self;
    self.pickerUnit.showsSelectionIndicator = YES;
    
    [self initArrayUnit];
    self.showPercent = NO;
    self.firstAdd = NO;
    self.isEdit = NO;
    
    if (![@"1" isEqualToString:[[NSUserDefaults standardUserDefaults]
                                objectForKey:@"Avalue"]]) {
        
        [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"Avalue"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        //Action here
        if(IS_IPHONE_5){
            [self.firstScreen setImage:[UIImage imageNamed:@"helpscreen_iphone5"]];
        }else{
            [self.firstScreen setImage:[UIImage imageNamed:@"helpscreen"]];
        }
        
        [self.firstScreen setUserInteractionEnabled:YES];
        
    }else{
        self.firstScreen = nil;
    }
    
}

-(void)initArrayUnit{

    self.areaUnit = [NSArray arrayWithObjects:
                     @"square meter",
                     @"square centimeter",
                     @"square millimeter",	
                     @"square feet",
                     @"square inche",
                     @"square yard",
                 nil];
    
    self.byteUnit = [NSArray arrayWithObjects:
                     @"bit",
                     @"byte",                     
                     @"kilobit",
                     @"megabit",
                     @"gigabit",
                     @"terabit",
                     @"kilobyte",
                     @"megabyte",
                     @"gigabyte",
                     @"terabyte",
                     @"nibble",
                     nil];
    
    self.lengthUnit = [NSArray arrayWithObjects:
                       @"centimeter",
                       @"inche",
                       @"feet",
                       @"meter",
                       @"yard",
                       @"millimeter",
                     nil];

    self.massUnit = [NSArray arrayWithObjects:
                     @"grain",
                     @"gram",
                     @"kilogram",
                     @"milligram",
                     @"ounce",
                     @"pound",
                       nil];

    self.volumeUnit = [NSArray arrayWithObjects:
                       @"liter", 
                       @"centiliter", 
                       @"milliliter",  
                       @"gallon", 
                       @"gill (UK)", 
                       @"gill (US)", 
                       @"fluid ounce (UK)", 
                       @"fluid ounce (US)", 
                       @"pint (UK)", 
                       @"dry pint (US)" , 
                       @"fluid pint (US)", 
                       @"quart (UK)", 
                       @"dry quart (US)",
                       @"liquid quart (US)",  
                       nil];
    
    self.itemUnit = [NSArray arrayWithObjects:
                       @"items",
                     nil
                     ];
    
    self.cataUnit = [NSArray arrayWithObjects:
                @"Item",
                @"Area",
                @"Byte",
                @"Length",
                @"Mass",                     
                @"Volume",
                nil];
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component{
    if(component==0){
        return 110;
    }
    return 190;
}

-(void)textFieldNextResponse:(id)sender
{
    [self selectFirstResponse:sender];    
}

-(void)textFieldNextResponseAndPutValue:(id)sender{
    [self selectFirstResponse:sender];        
//    NSInteger num = [self.pickerUnit selectedRowInComponent:0];
//    UITextField *unitText= (UITextField *)[self.view viewWithTag:3];        
//    switch (num) {
//        case 0:
//            unitText.text = [self.areaUnit objectAtIndex:[self.pickerUnit selectedRowInComponent:1]];
//            break;
//        case 1:
//            unitText.text = [self.byteUnit objectAtIndex:[self.pickerUnit selectedRowInComponent:1]];
//            break;            
//        default:
//            break;
//    }
}

-(void)selectFirstResponse:(id)sender{
    UIBarButtonItem *buttonBar = (UIBarButtonItem*) sender;
    
    NSInteger nextTag = (buttonBar.tag - 10)+1;
    
    // Try to find next responder
    UIResponder* nextResponder = [self.view viewWithTag:nextTag];

    if (nextResponder) {
        
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
        
        if(nextTag == 3){
            [self updateTextFieldUnit];
        }
        
    } else {
        // Not found, so remove keyboard.
        UITextField *tmp =(UITextField*) [self.view viewWithTag:(buttonBar.tag-10)];        
        [tmp resignFirstResponder];
    }
    
    
    
}

-(UIToolbar *) getToolBarAndNextButton{
    UIToolbar *bar = [[UIToolbar alloc] initWithFrame:CGRectMake(20, 5, 15, 45)];    
    [bar setBarStyle:UIBarStyleBlackTranslucent];
    [bar setAlpha:0.001];        
    return bar;
}

-(BOOL)checkUnitIsValid:(UITextField *)_textView{
    if(_textView.text == nil || [_textView isEqual:@""] == YES ){
        [UIView animateWithDuration:0.5
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseOut 
                         animations:^{ _textView.backgroundColor = [UIColor colorWithRed:1.0 green:0.4 blue:0.4 alpha:1.0]; } 
                         completion:NULL];
        
        [_textView becomeFirstResponder];

        
        
        return NO;
    }
    return YES;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    UITouch *touch = [touches anyObject];
    
    if ([touch view] == self.imgLabel)
    {
        
        if(self.firstBackground.hidden == YES && [self.tableviewP numberOfRowsInSection:0] !=0 ){
            DataList *newDataList = [self.dataList objectAtIndex:0];
            if(newDataList.addMode == NO && self.isEdit==NO ){
                AudioServicesPlaySystemSound (soundFileObject);
                self.showPercent = (!self.showPercent);
                [self.tableviewP reloadData];
            }
        }
        
    }else if ([touch view] == self.firstScreen){
        
        [self.firstScreen setHidden:YES];
        [self.firstScreen setUserInteractionEnabled:NO];
        self.firstScreen = nil;
        
    }
    
}

-(BOOL)checkNumberIsValid:(UITextField *)_textView{
    
    NSNumberFormatter *numberChecker = [[NSNumberFormatter alloc] init];
    
    if ([numberChecker numberFromString:_textView.text] == nil){
        
        [UIView animateWithDuration:0.5
                              delay:0 
                            options:UIViewAnimationOptionCurveEaseOut 
                         animations:^{ _textView.backgroundColor = [UIColor colorWithRed:1.0 green:0.4 blue:0.4 alpha:1.0]; } 
                         completion:NULL];
        
        [_textView becomeFirstResponder];
        return NO;
    }
    return YES;
}

-(void)cancleEditData{
    
    ZKRevealingTableViewCell *quantityTextField = (ZKRevealingTableViewCell *)[self.cellToEdit.editView viewWithTag:1];
    ZKRevealingTableViewCell *sizeTextField = (ZKRevealingTableViewCell *)[self.cellToEdit.editView  viewWithTag:2];
    ZKRevealingTableViewCell *unitTextField = (ZKRevealingTableViewCell *)[self.cellToEdit.editView  viewWithTag:3];
    ZKRevealingTableViewCell *priceTextField = (ZKRevealingTableViewCell *)[self.cellToEdit.editView  viewWithTag:4];
    [quantityTextField resignFirstResponder];
    [sizeTextField resignFirstResponder];
    [unitTextField resignFirstResponder];
    [priceTextField resignFirstResponder];
    
    [self changeRightButtonNormal];
    
    [UIView animateWithDuration:0.5
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{ self.cellToEdit.editView.center = CGPointMake( -([self.cellToEdit getOriginalCenter]) , self.cellToEdit.editView.center.y); }
                     completion:^(BOOL finished){                         
                         [self.tableviewP reloadData];
                     }];
     self.isEdit = NO;
}

-(void)doneEditButtonTapped{
    
    // Add into DataList
    UITextField *quantityTextField = (UITextField *)[self.cellToEdit.editView viewWithTag:1];
    UITextField *sizeTextField = (UITextField *)[self.cellToEdit.editView viewWithTag:2];
    UITextField *unitTextField = (UITextField *)[self.cellToEdit.editView viewWithTag:3];
    UITextField *priceTextField = (UITextField *)[self.cellToEdit.editView viewWithTag:4];
        
    BOOL fourCheck = [self checkNumberIsValid:priceTextField];
    BOOL thirdCheck = [self checkUnitIsValid:unitTextField];
    BOOL secondCheck = YES;
    BOOL isPerItem = ([self.pickerUnit selectedRowInComponent:0] == 0) && ([self.pickerUnit selectedRowInComponent:1] == 0);
        
    if( !isPerItem ){
        secondCheck = [self checkNumberIsValid:sizeTextField];
    }else{
        if(![sizeTextField.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Items Unit"
                                                            message:[NSString stringWithFormat:@"Items unit will not include \"size\" to calculate the real price"]
                                                           delegate:nil
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
            [alert show];
            sizeTextField.text = @"";
        }
    }
    
    BOOL firstCheck = [self checkNumberIsValid:quantityTextField];
    
    if( firstCheck==NO || secondCheck == NO || thirdCheck == NO  || fourCheck == NO ){
        
    }else{
        
        [self changeRightButtonNormal];
        
        DataList *newDataList = [self.dataList objectAtIndex:self.cellToEdit.tag];
        newDataList.quantity = [quantityTextField.text doubleValue];
        newDataList.size = [sizeTextField.text doubleValue];
        newDataList.cata = [self.pickerUnit selectedRowInComponent:0];
        newDataList.unitEnum = [self.pickerUnit selectedRowInComponent:1];
        newDataList.price = [priceTextField.text doubleValue];
        newDataList.addMode = NO;
        newDataList.unit = unitTextField.text;
        
        [self updateDataListRealPrice];
        
        DataList *afterUpdateDataList = [self.dataList objectAtIndex:self.cellToEdit.tag];
        self.cellToEdit.realPriceLabel.text = [NSString stringWithFormat:@"%.3f/%@", [afterUpdateDataList.realPrice doubleValue],afterUpdateDataList.unitNew];
        self.cellToEdit.quantityLabel.text =  [NSString stringWithFormat:@"%.2f",afterUpdateDataList.quantity];
        
        if(!isPerItem){
            self.cellToEdit.sizeLabel.text = [NSString stringWithFormat:@"%.2f",afterUpdateDataList.size];
        }else{
            self.cellToEdit.sizeLabel.text = @"";
        }
        
        self.cellToEdit.unitLabel.text = afterUpdateDataList.unit;
        self.cellToEdit.priceLabel.text = [NSString stringWithFormat:@"%.2f",afterUpdateDataList.price];
        [self.cellToEdit setImageOrder:afterUpdateDataList.order];
        
        [priceTextField resignFirstResponder];
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut
                         animations:^{ self.cellToEdit.editView.center = CGPointMake( -([self.cellToEdit getOriginalCenter]) , self.cellToEdit.editView.center.y); }
                         completion:^(BOOL finished){
                             
                             [self.tableviewP reloadData];
                         }];
        
    }
    
    self.isEdit = NO;
    
}


-(void)doneButtonTapped{
    
// Add into DataList    
    UITextField *quantityTextField = (UITextField *)[self.cellToFlip.backView viewWithTag:1];    
    UITextField *sizeTextField = (UITextField *)[self.cellToFlip.backView viewWithTag:2];
    UITextField *unitTextField = (UITextField *)[self.cellToFlip.backView viewWithTag:3];
    UITextField *priceTextField = (UITextField *)[self.cellToFlip.backView viewWithTag:4];
    
    
    BOOL fourCheck = [self checkNumberIsValid:priceTextField];       
    BOOL thirdCheck = [self checkUnitIsValid:unitTextField];
    BOOL secondCheck = YES;             
    BOOL isPerItem = ([self.pickerUnit selectedRowInComponent:0] ==0) && ([self.pickerUnit selectedRowInComponent:1] ==0);
        
    if( !isPerItem ){        
        secondCheck = [self checkNumberIsValid:sizeTextField];             
    }else{
            if(![sizeTextField.text isEqualToString:@""]){
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Items Unit" 
                                                                message:[NSString stringWithFormat:@"Items unit will not include \"size\" to calculate the real price"]
                                                               delegate:nil
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];
                sizeTextField.text = @"";        
            }                    
    }

    BOOL firstCheck = [self checkNumberIsValid:quantityTextField];
    
    if( firstCheck==NO || secondCheck == NO || thirdCheck == NO  || fourCheck == NO ){
        
    }else{
        
        [self changeRightButtonBarToAdd];

        DataList *newDataList = [self.dataList objectAtIndex:0];
        newDataList.quantity = [quantityTextField.text doubleValue];
        newDataList.size = [sizeTextField.text doubleValue];
        newDataList.cata = [self.pickerUnit selectedRowInComponent:0];    
        newDataList.unitEnum = [self.pickerUnit selectedRowInComponent:1];
        newDataList.price = [priceTextField.text doubleValue];
        newDataList.addMode = NO;
        newDataList.unit = unitTextField.text;
        
        [self updateDataListRealPrice];
        
        DataList *afterUpdateDataList = [self.dataList objectAtIndex:0];        
        self.cellToFlip.realPriceLabel.text = [NSString stringWithFormat:@"%.3f/%@", [afterUpdateDataList.realPrice doubleValue],afterUpdateDataList.unitNew]; 
        self.cellToFlip.quantityLabel.text =  [NSString stringWithFormat:@"%.2f",afterUpdateDataList.quantity];
        
        if(!isPerItem){
            self.cellToFlip.sizeLabel.text = [NSString stringWithFormat:@"%.2f",afterUpdateDataList.size];
        }else{
            self.cellToFlip.sizeLabel.text = @"";
        }
        
        self.cellToFlip.unitLabel.text = afterUpdateDataList.unit;
        self.cellToFlip.priceLabel.text = [NSString stringWithFormat:@"%.2f",afterUpdateDataList.price];                
        [self.cellToFlip setImageOrder:afterUpdateDataList.order];
                                                
        [priceTextField resignFirstResponder]; 
        
        [UIView animateWithDuration:0.5
                              delay:0
                            options:UIViewAnimationOptionCurveEaseOut 
                         animations:^{ self.cellToFlip.backView.center = CGPointMake( -([self.cellToFlip getOriginalCenter]) , self.cellToFlip.backView.center.y); } 
                         completion:^(BOOL finished){
        
        [self.tableviewP reloadData];
                         }];
        
    }
    
}

-(void) updateDataListRealPrice{
    NSMutableArray *tmp;
    tmp=self.dataList;          
    [self.compareManager changeUnitAndCalculateRealPriceForDataList: &tmp ];        
    self.dataList = tmp;
    
    for(DataList *iList in self.dataList){
        iList.unitNew = [self.unitMappingManager mapUnitfromIndex:iList.cata indexrow:iList.unitEnumNew];
    }
    
}

-(UITextField *)getTextFieldInputForEdit:(double)_x Y:(double)_y width:(double)_width hight:(double)_hight hint:(NSString *)_hint tag:(NSInteger)_tag{
    UITextField *playerTextField = [[UITextField alloc] initWithFrame:CGRectMake(_x, _y, _width, _hight)];
    playerTextField.adjustsFontSizeToFitWidth = YES;
    playerTextField.textColor = [UIColor blackColor];
    playerTextField.placeholder = _hint;
    playerTextField.keyboardType = UIKeyboardTypeEmailAddress;
    playerTextField.returnKeyType = UIReturnKeyNext;
    playerTextField.backgroundColor = [UIColor whiteColor];
    playerTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    playerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
    playerTextField.tag = _tag;
    playerTextField.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18];
    playerTextField.textAlignment = UITextAlignmentCenter;
    [playerTextField setEnabled: YES];
    [playerTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    
    
    //[playerTextField setClearsOnBeginEditing:YES];
    playerTextField.delegate = self;
    
    return  playerTextField;
}

-(UITextField *)getTextFieldInput:(double)_x Y:(double)_y width:(double)_width hight:(double)_hight hint:(NSString *)_hint tag:(NSInteger)_tag function:(FunctionButton)_function{
    
    // X , Y ,width , hight
    UITextField *playerTextField = [[UITextField alloc] initWithFrame:CGRectMake(_x, _y, _width, _hight)];      
    playerTextField.adjustsFontSizeToFitWidth = YES;
    playerTextField.textColor = [UIColor blackColor];        
    playerTextField.placeholder = _hint;
    playerTextField.keyboardType = UIKeyboardTypeEmailAddress;
    playerTextField.returnKeyType = UIReturnKeyNext;        
    playerTextField.backgroundColor = [UIColor whiteColor];
    playerTextField.autocorrectionType = UITextAutocorrectionTypeNo; // no auto correction support
    playerTextField.autocapitalizationType = UITextAutocapitalizationTypeNone; // no auto capitalization support
    playerTextField.tag = _tag;
    playerTextField.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18];
    playerTextField.textAlignment = UITextAlignmentCenter;    
    [playerTextField setEnabled: YES];
    [playerTextField setKeyboardType:UIKeyboardTypeDecimalPad];
    
    UIToolbar *bar = [self getToolBarAndNextButton];
    UIBarButtonItem *button;
    if(_function == NextFunction){
        
        button = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:nil];    
        button.tag = _tag + 10;
        [button setAction:@selector(textFieldNextResponse:)];
        
    }else if(_function==NextAndPutUnitFunction) {
        
        
        button = [[UIBarButtonItem alloc] initWithTitle:@"Next" style:UIBarButtonItemStyleBordered target:self action:nil];    
        button.tag = _tag + 10;
        [button setAction:@selector(textFieldNextResponseAndPutValue:)];
                
    }else{
        button = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleBordered target:self action:nil];    
        button.tag = _tag + 10;
          [button setAction:@selector(doneButtonTapped)];                
    }
    
    UIBarButtonItem *spaceFlex = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];    
    [bar setItems:[NSArray arrayWithObjects:spaceFlex,button, nil]];            
    playerTextField.inputAccessoryView = bar;
        
//    playerTextField.delegate = self;
//    [playerTextField setClearButtonMode:UITextFieldViewModeAlways];

    return  playerTextField;
}

-(void)delData:(id)sender{
    
    UIButton *btnOnCell = (UIButton*)sender;
    NSInteger index = (btnOnCell.tag-20);
    [self.dataList removeObjectAtIndex: index ];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
        
    [self.tableviewP deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    [self updateDataListRealPrice];
    [self.tableviewP reloadData];
//    if(self.dataList.count==0){
//        [self.firstBackground setHidden:NO];
//        self.firstAdd = NO;
//    }
    
}

#pragma Picker view

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{

    switch (component) {
            
        case 0:
            return self.cataUnit.count;
            break;
            
        case 1:{            
            NSInteger componentCata = [self.pickerUnit selectedRowInComponent:0];
            switch (componentCata) {
                case 0:
                    return 1;
                    break;
                case 1:
                    return self.areaUnit.count;
                    break;
                case 2:
                    return self.byteUnit.count;
                    break;
                case 3:
                    return self.lengthUnit.count;
                    break;
                case 4:
                    return self.massUnit.count;
                    break;
                case 5:
                    return self.volumeUnit.count;
                    break;                    
                default:
                    break;
            }
            break;
        }
        default:
            break;
    }
    return 0;
    
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{

    switch (component) {
        case 0:
            return [self.cataUnit objectAtIndex:row];
            break;
        case 1:{
            NSInteger componentCata = [self.pickerUnit selectedRowInComponent:0];
            switch (componentCata) {
                case 0:
                    return @"items";
                    break;
                case 1:
                    return [self.areaUnit objectAtIndex:row];
                    break;
                case 2:
                    return [self.byteUnit objectAtIndex:row];
                    break;
                case 3:
                    return [self.lengthUnit objectAtIndex:row];
                    break;
                case 4:
                    return [self.massUnit objectAtIndex:row];
                    break;
                case 5:
                    return [self.volumeUnit objectAtIndex:row];
                    break;
                default:
                    break;
            }
            break;            
        }            
        default:
            break;
    }
    
    return @"";
    
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{

    if(component == 0){        
        if(self.dataList.count >= 2){
            DataList *iList = [self.dataList objectAtIndex:1];
            if(row != iList.cata){
                
                [self.pickerUnit selectRow:iList.cata inComponent:0 animated:YES];
                
                NSString *previousUnit = [self.cataUnit objectAtIndex:iList.cata];
                NSString *selectedUnit = [self.cataUnit objectAtIndex:row];
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Different Units" 
                                                                message:[NSString stringWithFormat:@"Can't compare between %@ and %@",previousUnit,selectedUnit]
                                                               delegate:nil 
                                                      cancelButtonTitle:@"OK"
                                                      otherButtonTitles:nil];
                [alert show];

            }else{
                [self.pickerUnit reloadComponent:1];  
            }
        }else{
            [self.pickerUnit reloadComponent:1];
        }
    }
    [self updateTextFieldUnit];
    [self updateTextFieldUnitEdit];
}

#pragma View

-(void) rePositionForIPHONE5{

    self.toolBar.frame = CGRectMake(self.toolBar.frame.origin.x, 0, self.toolBar.frame.size.width, self.toolBar.frame.size.height);
    UILabel *uilable = (UILabel *)[self.view viewWithTag:50];
    uilable.frame = CGRectMake(uilable.frame.origin.x-20, 5, uilable.frame.size.width, uilable.frame.size.height);
    self.imgLabel.frame = CGRectMake(self.imgLabel.frame.origin.x, self.imgLabel.frame.origin.y-10, self.imgLabel.frame.size.width, self.imgLabel.frame.size.height);
    self.firstBackground.frame = CGRectMake(self.firstBackground.frame.origin.x, self.firstBackground.frame.origin.y-90, self.firstBackground.frame.size.width, self.firstBackground.frame.size.height+90);
    self.tableviewP.frame = CGRectMake(self.tableviewP.frame.origin.x, self.tableviewP.frame.origin.y-90, self.tableviewP.frame.size.width, self.tableviewP.frame.size.height+90);
    self.firstScreen.frame = CGRectMake(self.firstScreen.frame.origin.x, self.firstScreen.frame.origin.y-45, self.firstScreen.frame.size.width, self.firstScreen.frame.size.height+90);
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if(IS_IPHONE_5)
       [self rePositionForIPHONE5];
    
    UIImage *img = [UIImage imageNamed:@"toolbar"];
    [self.toolBar setBackgroundImage:img forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    [tempImageView setFrame:self.tableviewP.frame];     
    self.tableviewP.backgroundView = tempImageView;
	self.tableviewP.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tagCount = 0;
    [self initValue];
        
}


-(NSMutableArray *)dataList{
    if(_dataList == nil){
        _dataList = [[NSMutableArray alloc] init];
    }
    return _dataList;
}


-(NSMutableArray *)editCellList{
    if(_editCellList == nil){
        _editCellList = [[NSMutableArray alloc] init];
    }
    return _editCellList;
}

- (void)viewDidUnload
{
    [self setTableviewP:nil];
    [self setRightButtonBar:nil];
    [self setToolBar:nil];
    [self setFlexibleBar:nil];
    [self setImgLabel:nil];
    [self setFirstBackground:nil];
    [self setFirstScreen:nil];
    [self setClearAllButtonBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Talbe View

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}


- (void)handleDoubleTap:(UITapGestureRecognizer *)recognizer
{
    NSLog(@"Handle Double Tapp");
    
//    [UIView animateWithDuration:0.5
//                          delay:0
//                        options:UIViewAnimationOptionCurveEaseIn
//                     animations:^{
//                         CGFloat x = self._originalCenter;
//                         self.backView.center = CGPointMake(x, self.backView.center.y);
//                     }
//                     completion:^(BOOL finished){
//                         //                         [self.tableviewP reloadData];
//                     }];
    
    
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *CellIdentifier = @"Cell";    
    ZKRevealingTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    DataList *dataTemp = [self.dataList objectAtIndex:indexPath.row];
    
    cell.tag = indexPath.row;
    
    if (cell == nil) {
        
        cell = [[ZKRevealingTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier ];
        cell.delegate = self ;
        
        UIButton *delBtn = cell.backDelButton;
        [delBtn addTarget:self action:@selector(delData:) forControlEvents:UIControlEventTouchUpInside];
                 
        if(dataTemp.addMode == YES ){
            
            UITextField *firstTextField = [self getTextFieldInput:90 Y:9 width:60 hight:25 hint:@"quantity" tag:1 function:NextFunction];
            [cell.backView addSubview:firstTextField]; // tag : 1
            
            [cell.backView addSubview:[self getTextFieldInput:150 Y:9 width:60 hight:25 hint:@"size" tag:2 function:NextFunction]]; // 2
            
            UITextField *unitTextField = [self getTextFieldInput:210 Y:9 width:60 hight:25 hint:@"unit" tag:3 function:NextAndPutUnitFunction];            
            unitTextField.inputView = self.pickerUnit;                                    
            [cell.backView addSubview:unitTextField]; // 3
            
            [cell.backView addSubview:[self getTextFieldInput:270 Y:9 width:50 hight:25 hint:@"price" tag:4 function:DoneFunction]];  // 4
            
            self.cellToFlip = cell;
            
// EditView
            
            UILabel *editLabel = [self getLableX:16 Y:5 width:75 hight:35];
            editLabel.text = @"edit";
            [editLabel setTextColor:[UIColor redColor]];
            [cell.editView addSubview:editLabel];
            
            UITextField *firstTextFieldEdit = [self getTextFieldInputForEdit:90 Y:9 width:60 hight:25 hint:@"quantity" tag:1];
//            firstTextFieldEdit.delegate = self;
            
            [cell.editView addSubview:firstTextFieldEdit]; // tag : 1
            [cell.editView addSubview:[self getTextFieldInputForEdit:150 Y:9 width:60 hight:25 hint:@"size" tag:2]]; // 2
            
            UITextField *unitTextFieldEdit = [self getTextFieldInputForEdit:210 Y:9 width:60 hight:25 hint:@"unit" tag:3];
            unitTextFieldEdit.inputView = self.pickerUnit;
            [cell.editView addSubview:unitTextFieldEdit]; // 3
            
            [cell.editView addSubview:[self getTextFieldInputForEdit:270 Y:9 width:50 hight:25 hint:@"price" tag:4]];  // 4
            
            [firstTextField becomeFirstResponder];
            
        }
        
    }else{
        
        if(dataTemp.addMode == YES){        
            
            cell.backViewOut=NO;
            UITextField *quantityTextField = (UITextField *)[cell.backView viewWithTag:1];
            quantityTextField.text = @"";
            quantityTextField.backgroundColor = [UIColor whiteColor];

            UITextField *sizeTextField = (UITextField *)[cell.backView viewWithTag:2];
            sizeTextField.text = @"";
            sizeTextField.tag = 2;  
            sizeTextField.backgroundColor = [UIColor whiteColor];

            UITextField *unitTextField = (UITextField *)[cell.backView viewWithTag:3];
            unitTextField.text = @"";
            unitTextField.tag = 3;   
            unitTextField.backgroundColor = [UIColor whiteColor];
            
            UITextField *priceTextField = (UITextField *)[cell.backView viewWithTag:4];
            priceTextField.text = @"";            
            priceTextField.tag = 4;    
            priceTextField.backgroundColor = [UIColor whiteColor];
            
            self.cellToFlip = cell;
            [quantityTextField becomeFirstResponder];
            
        }else if(dataTemp.editMode == YES){
            
//            UITextField *quantityTextField = (UITextField *)[cell.editView viewWithTag:1];
//            quantityTextField.text = @"";
//            quantityTextField.backgroundColor = [UIColor whiteColor];
//
//            self.cellToEdit = cell;
//            [quantityTextField becomeFirstResponder];
                        
        }else{
            
            DataList *dataListAtPosition = [self.dataList objectAtIndex:indexPath.row];        
            
            if(self.showPercent){
                cell.realPriceLabel.text = [NSString stringWithFormat:@"+%.0f%%", dataListAtPosition.percentPrice];
            }else{
                cell.realPriceLabel.text = [NSString stringWithFormat:@"%.3f/%@", [dataListAtPosition.realPrice doubleValue],dataListAtPosition.unitNew];
            }
            
            cell.quantityLabel.text = [NSString stringWithFormat:@"%.2f", dataListAtPosition.quantity];
                        
            if( dataListAtPosition.unitEnum != 0 || dataListAtPosition.cata != 0 ){
                cell.sizeLabel.text = [NSString stringWithFormat:@"%.2f", dataListAtPosition.size];
            }else{
                cell.sizeLabel.text = @"";
            }
            
            cell.unitLabel.text = dataListAtPosition.unit;
            cell.priceLabel.text = [NSString stringWithFormat:@"%.2f", dataListAtPosition.price];
            [cell setImageOrder:dataListAtPosition.order];
            cell.backViewOut=YES;            
            UIButton *delButton = cell.backDelButton;
            delButton.tag = indexPath.row+20;

        }
        
    }
    
    cell.direction = (ZKRevealingTableViewCellDirection)1;
//    cell.shouldBounce = NO;
//  [self.editCellList addObject:cell];
    return cell;
}


-(void)moveAllCellDelBack{
    int numberOfCell = [self.tableviewP numberOfRowsInSection:0];
    
    for(int i=0;i<numberOfCell;i++){
        ZKRevealingTableViewCell *cell= (ZKRevealingTableViewCell *)[self.tableviewP cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]];
        [cell cellDelRevealBack];
    }

}


#pragma Outlet Action

- (IBAction)addTapped:(id)sender {    
    [self moveAllCellDelBack];
    
    if(self.firstAdd == NO ){
        [self.firstBackground setHidden:YES];
        self.firstAdd = YES;     
    }
       
    DataList *dataTemp = [[DataList alloc] initWithValue];
    [self.dataList insertObject:dataTemp atIndex:0];    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    [self.tableviewP insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    UITextField *quantityTextField = (UITextField *)[self.cellToFlip.backView viewWithTag:1];
    [quantityTextField becomeFirstResponder];

    [self changeRightButtonBarToCancle];
}

- (IBAction)clearTapped:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Clear all data" 
                          message:@"Do you want to clear all data?" 
                          delegate:self 
                          cancelButtonTitle:@"NO"
                          otherButtonTitles:@"YES",nil];
    
    alert.tag = 1;    
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(alertView.tag == 1){
        if(buttonIndex == 1){
            [self.dataList removeAllObjects];
            [self changeRightButtonBarToAdd];
            [self.tableviewP reloadData];
            [self.firstBackground setHidden:NO];            
            self.firstAdd = NO;     
        }
    }
    
}

-(void)updateTextFieldUnit{
    UITextField *unitTextField = (UITextField *)[self.cellToFlip.backView viewWithTag:3]; 
    unitTextField.text = [self.unitMappingManager mapUnitfromIndex:[self.pickerUnit selectedRowInComponent:0] indexrow:[self.pickerUnit selectedRowInComponent:1]];            
}

-(void)updateTextFieldUnitEdit{
    
    if( self.cellToEdit != nil ){
        UITextField *unitTextField = (UITextField *)[self.cellToEdit.editView viewWithTag:3];
        unitTextField.text = [self.unitMappingManager mapUnitfromIndex:[self.pickerUnit selectedRowInComponent:0] indexrow:[self.pickerUnit selectedRowInComponent:1]];
    }
    
}

- (void) dealloc {    
    AudioServicesDisposeSystemSoundID (soundFileObject);
    CFRelease (soundFileURLRef);
}

-(void)cellBeforeReverse:(ZKRevealingTableViewCell *)cell{
    
    [self moveAllCellDelBack];
    
//    NSLog(@"Handle Double Tapp");
    UITextField *quantityTextField = (UITextField *)[cell.editView viewWithTag:1];
    quantityTextField.text = cell.quantityLabel.text;
    quantityTextField.backgroundColor = [UIColor whiteColor];
    
    UITextField *sizeTextField = (UITextField *)[cell.editView viewWithTag:2];
    sizeTextField.text = cell.sizeLabel.text;
    sizeTextField.backgroundColor = [UIColor whiteColor];
    
    UITextField *unitTextField = (UITextField *)[cell.editView viewWithTag:3];
    unitTextField.text = cell.unitLabel.text;
    unitTextField.backgroundColor = [UIColor whiteColor];
    
    UITextField *priceTextField = (UITextField *)[cell.editView viewWithTag:4];
    priceTextField.text = cell.priceLabel.text;
    priceTextField.backgroundColor = [UIColor whiteColor];
    
    [quantityTextField becomeFirstResponder];
    self.isEdit = YES;
}

-(UILabel *)getLableX:(CGFloat)_x Y:(CGFloat)_y width:(CGFloat)_width hight:(CGFloat)_hight{
    UILabel *result = [[UILabel alloc] initWithFrame:CGRectMake(_x, _y, _width, _hight)];
    result.font = [UIFont fontWithName:@"Futura-CondensedMedium" size:18];
    result.textAlignment = UITextAlignmentCenter;
    return result;
}

-(void)cellDidReverse:(ZKRevealingTableViewCell *)cell{
    [self changeRightButtonBarEdit];
    self.cellToEdit = cell;
    DataList *newDataList = [self.dataList objectAtIndex:self.cellToEdit.tag];
    [self.pickerUnit selectRow:newDataList.unitEnum inComponent:1 animated:NO];
    [self.pickerUnit reloadComponent:1];
}

-(BOOL)cellEditShouldReveal:(ZKRevealingTableViewCell *)cell{
    DataList *newDataList = [self.dataList objectAtIndex:0];
    return !self.isEdit && !newDataList.addMode;
}

-(BOOL)cellShouldReveal:(ZKRevealingTableViewCell *)cell{
    DataList *newDataList = [self.dataList objectAtIndex:0];
    return !self.isEdit && !newDataList.addMode;
}

@end

