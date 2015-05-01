//
//  HomeModel.h
//  _sampledb
//
//  Created by Jennifer Tsau on 8/4/14.
//  Copyright (c) 2014 ___SummerTechnologies___. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol HomeModelProtocol <NSObject>

- (void)itemsDownloaded:(NSArray *)items;


@end

@interface HomeModel : NSObject <NSURLConnectionDataDelegate>

@property(nonatomic,weak) id<HomeModelProtocol> delegate;

- (void)downloadItems;

@end
