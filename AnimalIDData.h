//
//  AnimalIDData.h
//  _sampledb
//
//  Created by Jennifer Tsau on 1/3/15.
//  Copyright (c) 2015 ___SummerTechnologies___. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AnimalIDDataProtocol <NSObject>

@optional - (void)itemsDownloaded:(NSArray *)animalItems;


@end

@interface AnimalIDData : NSObject <NSURLConnectionDataDelegate>

@property(nonatomic,weak) id<AnimalIDDataProtocol> delegate;

- (void)downloadItems:(NSString *)ranch :(NSString *)animal_type;

@end
