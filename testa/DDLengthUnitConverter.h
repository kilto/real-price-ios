//
//  DDLengthUnitConverter.h
//  DDUnitConverter
//
//  Created by Dave DeLong on 11/25/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDUnitConverter.h"

@interface DDUnitConverter (DDLengthUnitConverter)

+ (id) lengthUnitConverter;

@end

//enum {
//	DDLengthUnitAstronomicUnits = 0,
//	DDLengthUnitCentimeters,
//	DDLengthUnitChains,
//	DDLengthUnitInches,
//	DDLengthUnitFathoms,
//	DDLengthUnitFeet,
//	DDLengthUnitFurlongs,
//	DDLengthUnitKilometers,
//	DDLengthUnitLightyears,
//	DDLengthUnitMeters,
//	DDLengthUnitMillimeters,
//	DDLengthUnitMiles,
//	DDLengthUnitInternationalNauticalMiles,
//	DDLengthUnitUKNauticalMiles,
//	DDLengthUnitParsecs,
//	DDLengthUnitYards,
//	DDLengthUnitAngstroms
//};

enum {
	DDLengthUnitCentimeters=0,
	DDLengthUnitInches,
	DDLengthUnitFeet,
	DDLengthUnitMeters,
    DDLengthUnitYards,
	DDLengthUnitMillimeters,
};

/*
 centimeter , cm
 inche, in
 feet, ft
 meter, m
 yard, yd
 millimeter, mm
*/









typedef NSUInteger DDLengthUnit;

@interface DDLengthUnitConverter : DDUnitConverter {

}

@end
