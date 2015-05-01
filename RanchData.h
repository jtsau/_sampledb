//
//  RanchData.h
//  _sampledb
//
//  Created by Jennifer Tsau on 12/28/14.
//  Copyright (c) 2014 ___SummerTechnologies___. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol RanchDataProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)ranchItems;

@end

@interface RanchData : NSObject <NSURLConnectionDataDelegate>

@property(nonatomic,weak) id<RanchDataProtocol> delegate;

- (void)downloadItems:(NSString *)animal_type;

@end
