//
//  CompareManager.h
//  real_price
//
//  Created by Koolapat Sirikamol on 5/22/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CompareManager : NSObject{
    
}

-(void) findMostFrequencyUnit : (NSMutableArray *) dataListArray cataOut:(NSInteger *) _cataOut  unit: (NSInteger *) _unit;

-(void) changeUnitAndCalculateRealPriceForDataList:(NSMutableArray **) dataListArray;


-(NSNumber*)pricePerUnit :(NSNumber*)quantity size:(NSNumber *)size price:(NSNumber *)price;

// TODO
// Function to tranfrom double value to scientific number (or readble value ) if value more than 4 digit

-(double)pricePercentage :(double)baseValue compareValue:(double)compareValue;

@end
