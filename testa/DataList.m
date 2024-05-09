//
//  dataList.m
//  real_price
//
//  Created by Koolapat Sirikamol on 5/25/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import "DataList.h"

@implementation DataList

@synthesize editMode;
@synthesize addMode;
@synthesize cata;
@synthesize unitEnum;
@synthesize quantity;
@synthesize size;
@synthesize realPrice;
@synthesize price;
@synthesize order;
@synthesize unit;
@synthesize percentPrice;
@synthesize unitEnumNew;
@synthesize unitNew;



-(DataList *)initWithValue{    
    self = [super init];    
    if(self){
        self.editMode=NO;
        self.addMode=YES;
        self.cata=0;
        self.unitEnum=0;
        self.quantity=0;
        self.size=0;
        self.price=0;
        unit=@"";
        realPrice=[NSNumber numberWithDouble:0];
        self.order = 3;
    }
    return self;        
}

@end
