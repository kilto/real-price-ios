//
//  DDVolumeUnitConverter.h
//  DDUnitConverter
//
//  Created by Dave DeLong on 11/26/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDUnitConverter.h"

@interface DDUnitConverter (DDVolumeUnitConverter)

+ (id) volumeUnitConverter;

@end

//enum {
//	DDVolumeUnitDryBarrels = 0,
//	DDVolumeUnitLiquidBarrels,
//	DDVolumeUnitUKBushels,
//	DDVolumeUnitUSBushels,
//	DDVolumeUnitCentiliters,
//	DDVolumeUnitCoffeeSpoons,
//	DDVolumeUnitCubicCentimeters,
//	DDVolumeUnitCubicDecimeters,
//	DDVolumeUnitCubicFeet,
//	DDVolumeUnitCubicInches,
//	DDVolumeUnitCubicKilometers,
//	DDVolumeUnitCubicMeters,
//	DDVolumeUnitCubicMiles,
//	DDVolumeUnitCubicMillimeters,
//	DDVolumeUnitCubicYards,
//	DDVolumeUnitCups,
//	DDVolumeUnitDashes,
//	DDVolumeUnitDeciliters,
//	DDVolumeUnitDrachms,
//	DDVolumeUnitDrams,
//	DDVolumeUnitDrops,
//	DDVolumeUnitGallons,
//	DDVolumeUnitUKGills,
//	DDVolumeUnitUSGills,
//	DDVolumeUnitLiters,
//	DDVolumeUnitMilliliters,
//	DDVolumeUnitUKMinims,
//	DDVolumeUnitUSMinims,
//	DDVolumeUnitUKFluidOunces,
//	DDVolumeUnitUSFluidOunces,
//	DDVolumeUnitUKPecks,
//	DDVolumeUnitUSPecks,
//	DDVolumeUnitPinches,
//	DDVolumeUnitUKPints,
//	DDVolumeUnitUSDryPints,
//	DDVolumeUnitUSFluidPints,
//	DDVolumeUnitUKQuarts,
//	DDVolumeUnitUSDryQuarts,
//	DDVolumeUnitUSLiquidQuarts,
//	DDVolumeUnitTablespoons,
//	DDVolumeUnitTeaspons,
//	DDVolumeUnitNumber2Point5Cans,
//	DDVolumeUnitNumber10Cans
//};

enum {
    DDVolumeUnitLiters,
    DDVolumeUnitCentiliters,
    DDVolumeUnitMilliliters,
	DDVolumeUnitGallons,
	DDVolumeUnitUKGills,
	DDVolumeUnitUSGills,
	DDVolumeUnitUKFluidOunces,
	DDVolumeUnitUSFluidOunces,
	DDVolumeUnitUKPints,
	DDVolumeUnitUSDryPints,
	DDVolumeUnitUSFluidPints,
	DDVolumeUnitUKQuarts,
	DDVolumeUnitUSDryQuarts,
	DDVolumeUnitUSLiquidQuarts,
};

/*
 liter, L
 centiliter, cL
 milliliter, mL 
 gallon, gal
 gill (UK), gill
 gill (US), gill
 fluid ounce (UK), fl oz
 fluid ounce (US), fl oz
 pint (UK), pt
 dry pint (US) , pt dry
 fluid pint (US), pt
 quart (UK), qt 
 dry quart (US), qt dry
 liquid quart (US), qt  
*/







typedef NSUInteger DDVolumeUnit;

@interface DDVolumeUnitConverter : DDUnitConverter {

}

@end
