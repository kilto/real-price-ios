//
//  DDByteUnitConverter.h
//  DDUnitConverter
//
//  Created by Dave DeLong on 11/26/10.
//  Copyright 2010 Home. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DDUnitConverter.h"

@interface DDUnitConverter (DDByteUnitConverter)

+ (id) byteUnitConverter;

@end

//enum {
//	DDByteUnitBit = 0,
//	DDByteUnitCrumb,
//	DDByteUnitNibble,
//	DDByteUnitByte,
//	
//	DDByteUnitDecabit,
//	DDByteUnitHectobit,
//	DDByteUnitKilobit,
//	DDByteUnitMegabit,
//	DDByteUnitGigabit,
//	DDByteUnitTerabit,
//	DDByteUnitPetabit,
//	DDByteUnitExabit,
//	DDByteUnitZettabit,
//	DDByteUnitYottabit,
//	
//	DDByteUnitDecabyte,
//	DDByteUnitHectobyte,
//	DDByteUnitKilobyte,
//	DDByteUnitMegabyte,
//	DDByteUnitGigabyte,
//	DDByteUnitTerabyte,
//	DDByteUnitPetabyte,
//	DDByteUnitExabyte,
//	DDByteUnitZettabyte,
//	DDByteUnitYottabyte,
//	
//	DDByteUnitKibibit,
//	DDByteUnitMebibit,
//	DDByteUnitGibibit,
//	DDByteUnitTebibit,
//	DDByteUnitPebibit,
//	DDByteUnitExbibit,
////	DDByteUnitZebibit,
////	DDByteUnitYobibit,
//	
//	DDByteUnitKibibyte,
//	DDByteUnitMebibyte,
//	DDByteUnitGibibyte,
//	DDByteUnitTebibyte,
//	DDByteUnitPebibyte,
//	DDByteUnitExbibyte,
////	DDByteUnitZebibyte,
////	DDByteUnitYobibyte
//};

enum {
	DDByteUnitBit = 0,
    DDByteUnitByte,
	
	DDByteUnitKilobit,
	DDByteUnitMegabit,
	DDByteUnitGigabit,
	DDByteUnitTerabit,
	
	DDByteUnitKilobyte,
	DDByteUnitMegabyte,
	DDByteUnitGigabyte,
	DDByteUnitTerabyte,
    
	DDByteUnitNibble
};

/*
bit bit , b
byte byte , B

kilobit, kb
megabit, Mb
gigabit, Gb
terabit, Tb

kilobyte, kB
megabyte, MB
gigabyte, GB
terabyte, TB

nibble, nibble
*/











typedef NSUInteger DDByteUnit;

@interface DDByteUnitConverter : DDUnitConverter {

}

@end
