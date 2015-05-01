//
//  RanchData.m
//  _sampledb
//
//  Created by Jennifer Tsau on 12/28/14.
//  Copyright (c) 2014 ___SummerTechnologies___. All rights reserved.
//


#import "RanchData.h"
#import "Ranch.h"
//#import "RanchViewController.h"

@interface RanchData()
{
    NSMutableData *_downloadedData;
}
@end

@implementation RanchData

- (void)downloadItems:(NSString *)animal_type
{
    // Download the json file
    NSString *urlString = [NSString stringWithFormat:@"http://farmtocloud.com/ranchservice.php?animal=%@", animal_type];
    
//    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://farmtocloud.com/ranchservice.php?animal=Steer"];
    
    NSURL *jsonFileUrl = [NSURL URLWithString:urlString];
    
    // Create the request
    NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:jsonFileUrl];
    
    // Create the NSURLConnection
    [NSURLConnection connectionWithRequest:urlRequest delegate:self];
}

#pragma mark NSURLConnectionDataProtocol Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // Initialize the data object
    _downloadedData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // Append the newly downloaded data
    [_downloadedData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // Create an array to store the locations
    NSMutableArray *_Ranches = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *ranch_jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        Ranch *newRanch = [[Ranch alloc] init];
        
        newRanch.ranch = ranch_jsonElement[@"ranch_name"];
        // ------ COUNT CODE STUFF ------
         newRanch.ranches_count = ranch_jsonElement[@"count"];
        
        // Add this question to the locations array
        [_Ranches addObject:newRanch];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        NSLog(@"ranchdata test: %@", _Ranches);
        [self.delegate itemsDownloaded:_Ranches];
    }
}

@end