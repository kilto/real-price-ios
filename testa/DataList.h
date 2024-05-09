//
//  dataList.h
//  real_price
//
//  Created by Koolapat Sirikamol on 5/25/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataList : NSObject{
    
//Calculate Value
    NSNumber *realPrice;
    double percentPrice;    
    int order;    
    
    NSInteger unitEnumNew;
    NSString *unitNew;
    
// User Input    
    double quantity;
    double size;
    double price;
    
    NSString *unit;
    NSInteger cata,unitEnum;
    BOOL editMode;
    BOOL addMode;
    
}

-(DataList *)initWithValue;

@property(readwrite,assign)  BOOL editMode;
@property(readwrite,assign)  BOOL addMode;

@property(readwrite,assign)  NSInteger cata;
@property(readwrite,assign)  NSInteger unitEnum;
@property(readwrite,assign)  NSInteger unitEnumNew;

@property(readwrite,assign)  double quantity;
@property(readwrite,assign)  double size;
@property(readwrite,assign)  double price;

@property(nonatomic,strong)  NSString *unit;
@property(nonatomic,strong)  NSString *unitNew;

@property(nonatomic,strong)  NSNumber *realPrice;
@property(readwrite,assign)  int order;
@property(readwrite,assign)  double percentPrice;




@end
