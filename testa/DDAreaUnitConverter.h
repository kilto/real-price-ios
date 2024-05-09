//
//  DDAreaUnitConverter.h
//  DDUnitConverter
//
//  Created by Dave DeLong on 11/25/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDUnitConverter.h"

@interface DDUnitConverter (DDAreaUnitConverter)

+ (id) areaUnitConverter;

@end

//enum {
//	DDAreaUnitAcres = 0,
//	DDAreaUnitBarns,
//	DDAreaUnitHectares,
//	DDAreaUnitRoods,
//	DDAreaUnitSquareCentimeters,
//	DDAreaUnitSquareDecimeters,
//	DDAreaUnitSquareFeet,
//	DDAreaUnitSquareInches,
//	DDAreaUnitSquareKilometers,
//	DDAreaUnitSquareMeters,
//	DDAreaUnitSquareMiles,
//	DDAreaUnitSquareMillimeters,
//	DDAreaUntiSquareRods,
//	DDAreaUnitSquareYards,
//};

enum {
    DDAreaUnitSquareMeters,
	DDAreaUnitSquareCentimeters,
    DDAreaUnitSquareMillimeters,
	DDAreaUnitSquareFeet,
	DDAreaUnitSquareInches,
	DDAreaUnitSquareYards,
};

/* 
 square centimeter cm2 , sq.cm
 square feet ft2 , sq ft
 square inche in2 , sq in
 square meter m2 , sq m
 square millimeter mm2 , sq mm
 square yard yd2 , sq yd
*/

typedef NSUInteger DDAreaUnit;

@interface DDAreaUnitConverter : DDUnitConverter {

}

@end
