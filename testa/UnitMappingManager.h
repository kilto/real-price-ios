//
//  UnitMappingManager.h
//  real_price
//
//  Created by Koolapat Sirikamol on 6/11/55 BE.
//  Copyright (c) 2555 kilto2@hotmail.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UnitMappingManager : NSObject{
    NSArray *areaUnitMapping;
    NSArray *byteUnitMapping;
    NSArray *leghtUnitMapping;
    NSArray *massUnitMapping;
    NSArray *volumeUnitMapping;    
}

@property(nonatomic,strong) NSArray *areaMapping;
@property(nonatomic,strong) NSArray *byteUnitMapping;
@property(nonatomic,strong) NSArray *leghtUnitMapping;
@property(nonatomic,strong) NSArray *massUnitMapping;
@property(nonatomic,strong) NSArray *volumeUnitMapping;

-(UnitMappingManager *)initUnitMapping;
-(NSString *)mapUnitfromIndex:(NSInteger)component indexrow:(NSInteger)indexrow;


@end
