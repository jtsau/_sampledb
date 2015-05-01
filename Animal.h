//
//  Cattle.h
//  _sampledb
//
//  Created by Jennifer Tsau on 12/27/14.
//  Copyright (c) 2014 ___SummerTechnologies___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Animal : NSObject

@property(nonatomic,strong) NSString *ranch;
@property(nonatomic,strong) NSString *animal;
@property(nonatomic,strong) NSString *breed;
@property(nonatomic,strong) NSString *ID_Number;
@property(nonatomic,strong) NSString *birthdate;
@property(nonatomic,strong) NSString *target_sell_date;
@property(nonatomic,strong) NSString *notes;
@property(nonatomic,strong) NSString *UID;

@end
