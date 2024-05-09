//
//  UnitMappingManager.m
//  real_price
//
//  Created by Koolapat Sirikamol on 6/11/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import "UnitMappingManager.h"

@implementation UnitMappingManager

@synthesize areaMapping;
@synthesize byteUnitMapping;
@synthesize leghtUnitMapping;
@synthesize massUnitMapping;
@synthesize volumeUnitMapping;

-(UnitMappingManager *)initUnitMapping{
    
    self = [super init];
    
    if(self){
        areaUnitMapping = [NSArray arrayWithObjects:
                           @"sq.m",
                           @"sq.cm",
                           @"sq.mm",
                           @"sq.ft",
                           @"sq.in",
                           @"sq.yd"
                           , nil];

        byteUnitMapping = [NSArray arrayWithObjects:
                            @"b",
                            @"B",                           
                            @"Kb",                           
                            @"Mb",
                            @"Gb",                           
                            @"Tb",
                            @"KB",                           
                            @"MB",                           
                            @"GB",                           
                            @"TB",                                                      
                            @"nibble",                                                      
                           nil];
        
        leghtUnitMapping = [NSArray arrayWithObjects:
                            @"cm",                                                                                  
                            @"in",                                                                                  
                            @"ft",                                                                                  
                            @"m",                                                                                  
                            @"yd",                                                                                  
                            @"mm",                                                                                                              
                            nil];
        
        massUnitMapping = [NSArray arrayWithObjects:
                            @"gn",                                                                                  
                            @"g",                                                                                  
                            @"kg",                                                                                  
                            @"mg",                                                                                  
                            @"oz",                                                                                  
                            @"lb",                                                                                                              
                            nil];
        
        volumeUnitMapping = [NSArray arrayWithObjects:
                           @"L",                                                                                  
                           @"cL",                                                                                  
                           @"mL",                                                                                  
                           @"gal",                                                                                  
                           @"gill",                                                                                  
                           @"gill",                                                                                                               
                           @"fl.oz",                                                                                  
                           @"fl.oz",                                                                                                              
                           @"pt",                                                                                                              
                           @"pt.dry",                                                                                                                                         
                           @"pt",                                                                                                                                         
                           @"qt",                                                                                                                                                                    
                           @"qt.dry",                                                                                                                                                                    
                           @"qt",                                                                                                                                                                                               
                           nil];
    }
    
    return self;
}


-(NSString *)mapUnitfromIndex:(NSInteger)component indexrow:(NSInteger)indexrow{
    switch (component) {
        case 0:
            return @"items";
            break;
         case 1:
            return [areaUnitMapping objectAtIndex:indexrow];
            break;            
        case 2:
            return [byteUnitMapping objectAtIndex:indexrow];
            break;            
        case 3:
            return [leghtUnitMapping objectAtIndex:indexrow];
            break;            
        case 4:
            return [massUnitMapping objectAtIndex:indexrow];
            break;            
        case 5:
            return [volumeUnitMapping objectAtIndex:indexrow];
            break;            
        default:
            break;
    }
    
    return @"items";    
}












@end
