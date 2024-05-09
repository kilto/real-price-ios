//
//  CompareManager.m
//  real_price
//
//  Created by Koolapat Sirikamol on 5/22/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import "CompareManager.h"
#import "DataList.h"
#import "DDUnitConversion.h"



@implementation CompareManager

-(NSNumber*)pricePerUnit :(NSNumber*)quantity size:(NSNumber *)size price:(NSNumber *)price{          
    return [NSNumber numberWithDouble:price.doubleValue/(quantity.doubleValue*size.doubleValue)];
}

-(double)pricePercentage :(double)baseValue compareValue:(double)compareValue{        
    return ((compareValue - baseValue) * 100) / baseValue; 
}

-(void) findMostFrequencyUnit : (NSMutableArray *) dataListArray cataOut:(NSInteger *) _cataOut  unit: (NSInteger *) _unit{

    // Use Dictionary to Total count frequency of each unit;    
    // Key = cata + unitEnum
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];    
    
    for( DataList *i in dataListArray){
        
        NSString *key = [NSString stringWithFormat:@"%d%d",i.cata,i.unitEnum];
        NSNumber *num = [dic valueForKey:key];
        
        if(num == nil){
            num = [NSNumber numberWithInt:1];
            [dic setValue:num forKey:key];
        }else{
            NSNumber *numTmp = [NSNumber numberWithInt:[num intValue]+1];
            [dic setValue:numTmp forKey:key];
        }
        
    }
    
    NSInteger frequency=0;    
    NSString *topKey=@"00";

    NSArray *allKey = [dic allKeys]; 
    for( NSString *key in allKey){
        NSNumber *numTmp = [dic valueForKey:key];
            if([numTmp intValue] > frequency){
                frequency = [numTmp intValue];
                topKey = key;
            }
    }
    
//    NSLog(@"%@",topKey);
    
    NSString *cataOutString = [NSString stringWithFormat:@"%C",[topKey characterAtIndex:0]];
    
    NSString *unitOutString;
    
    if( [topKey length] <= 2){
        unitOutString = [NSString stringWithFormat:@"%C",[topKey characterAtIndex:1]];
    }else{
        unitOutString = [NSString stringWithFormat:@"%C%C",[topKey characterAtIndex:1] , [topKey characterAtIndex:2] ];
    }
    
    *_cataOut = [cataOutString intValue];
    *_unit = [unitOutString intValue];
}

// Function to Add realPrice and Order

-(void) changeUnitAndCalculateRealPriceForDataList:(NSMutableArray **) dataListArray{
    
    NSInteger cataOut,unitOut;
    [self findMostFrequencyUnit : *dataListArray cataOut:&cataOut  unit:&unitOut];
    
    DDUnitConverter *c;
    
    for(DataList *i in *dataListArray){
        switch (i.cata) {
            case 0:{
                
            }                
            break;
                
            case 1:{                
                c = [DDUnitConverter areaUnitConverter];                
            }
            break;
                
            case 2:{
                c = [DDUnitConverter byteUnitConverter];                
            }
            break;
                
            case 3:{
                c = [DDUnitConverter lengthUnitConverter];                
            }
            break;
                
            case 4:{
                c = [DDUnitConverter massUnitConverter];                
            }
            break;
                
            case 5:{
                c = [DDUnitConverter volumeUnitConverter];                
            }
            break;

            default:
            break;   
        }
        
        if(i.cata != 0 ){            
            NSNumber *value = [c convertNumber:[NSNumber numberWithDouble: ( i.quantity * i.size )  ]
                                  fromUnit:i.unitEnum
                                    toUnit:unitOut];                
            i.realPrice = [NSNumber numberWithDouble: (i.price/[value doubleValue])  ];
        }else{
            i.realPrice = [NSNumber numberWithDouble: (i.price / (i.quantity)) ];         
        } 
        
        i.unitEnumNew = unitOut;
//        NSLog(@"%d",unitOut);        
    }
    
//Find Top Three    
//    NSSortDescriptor *sorter = [[NSSortDescriptor alloc] initWithKey:@"realPrice" ascending:YES];
    
    double topOne=-1,topTwo=-1,topThree=-1;
    int index1=-1,index2=-1,index3=-1,runningNumber=0;        
    
    for(DataList *iList in *dataListArray){
        iList.order=3;
        iList.percentPrice = -1.0;
    }
    
    if( [*dataListArray  count] > 1){                        
                
        for(DataList *iList in *dataListArray){
            if(topOne == -1 ){
                topOne = [iList.realPrice doubleValue];
                index1 = runningNumber;
            }
            
            if( [iList.realPrice doubleValue] < topOne ){
                topOne = [iList.realPrice doubleValue];
                index1 = runningNumber;
            }
            runningNumber++;
        }
    
        if(index1 != -1){
            DataList *list = [*dataListArray objectAtIndex:index1];
            list.order = 0;
            list.percentPrice = 0.0;
            
            for(DataList *iList in *dataListArray){
                if( [iList.realPrice doubleValue] == topOne ){
                    iList.order =0;
                    iList.percentPrice=0.0;
                }
            }            
        }
                
        runningNumber = 0;

        if( [*dataListArray  count] >= 2){
            for(DataList *iList in *dataListArray){
                
                if(topTwo==-1 && (runningNumber != index1) && ([iList.realPrice doubleValue] != topOne)){
                    topTwo = [iList.realPrice doubleValue];
                    index2 = runningNumber;

                }
                
                if( ([iList.realPrice doubleValue] < topTwo) && (runningNumber != index1) && ([iList.realPrice doubleValue] != topOne) ){
                    
                    topTwo = [iList.realPrice doubleValue];
                    index2 = runningNumber;
                }
                runningNumber++;
            }
        
            runningNumber = 0;

            if(index2 != -1){
                DataList *list = [*dataListArray objectAtIndex:index2];
                list.order = 1;
                
                for(DataList *iList in *dataListArray){
                    if( [iList.realPrice doubleValue] == topTwo ){
                        iList.order = 1;
                    }
                }
                
            }
            
            if( [*dataListArray  count] >= 3){
            
                for(DataList *iList in *dataListArray){
                    
                    if(topThree==-1 && (runningNumber != index1) && (runningNumber != index2) && ([iList.realPrice doubleValue] != topOne) && ([iList.realPrice doubleValue] != topTwo) ){
                        topThree = [iList.realPrice doubleValue];
                        index3 = runningNumber;                        
                    }

                    if( ([iList.realPrice doubleValue] < topThree) && (runningNumber != index1) && (runningNumber != index2) && ([iList.realPrice doubleValue] != topOne) && ([iList.realPrice doubleValue] != topTwo)){
                        topThree = [iList.realPrice doubleValue];
                        index3 = runningNumber;
                    }
                    runningNumber++;
                }
             
                if(index3 != -1){
                    DataList *list = [*dataListArray objectAtIndex:index3];
                    list.order = 2;
                    
                    for(DataList *iList in *dataListArray){
                        if( [iList.realPrice doubleValue] == topThree ){
                            iList.order = 2;
                        }
                    }

                }
            }
            
    
        }
        
    }else{
        
        if([*dataListArray count] == 1){
            DataList *list = [*dataListArray objectAtIndex:0];
            list.order = 0;
            topOne = [list.realPrice doubleValue];
        }
        
    }
    
    if( [*dataListArray  count] >= 1){   
        for(DataList *iList in *dataListArray){
            iList.percentPrice = [self pricePercentage:topOne compareValue:[iList.realPrice doubleValue]];
        }
    }
    
}

@end







