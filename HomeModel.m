//
//  HomeModel.m
//  _sampledb
//
//  Created by Jennifer Tsau on 8/4/14.
//  Copyright (c) 2014 ___SummerTechnologies___. All rights reserved.
//


#import "HomeModel.h"
#import "AnimalType.h"

@interface HomeModel()
{
    NSMutableData *_downloadedData;
}
@end

@implementation HomeModel

- (void)downloadItems
{
    // Download the json file
    NSURL *jsonFileUrl = [NSURL URLWithString:@"http://farmtocloud.com/service.php?"];
    
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
    NSMutableArray *_AnimalTypes = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        AnimalType *newAnimalType = [[AnimalType alloc] init];
        //newCattle.ranch = jsonElement[@"Ranch"];
        newAnimalType.animal = jsonElement[@"type_name"];
        newAnimalType.count = jsonElement[@"count"];
        
        // added 12/24/2014:
        //newCattle.imageFile = jsonElement[@"Image"];
        if ([newAnimalType.animal  isEqual: @"Cow"])
        {
              newAnimalType.imageFile = @"cow1.jpg";
        }
        else if ([newAnimalType.animal  isEqual: @"Goat"])
        {
            newAnimalType.imageFile = @"goat.png";
        }
        else if ([newAnimalType.animal  isEqual: @"Sheep"])
        {
            newAnimalType.imageFile = @"sheep.jpg";
        }
        else if ([newAnimalType.animal  isEqual: @"Pig"])
        {
            newAnimalType.imageFile = @"pig.jpg";
        }
        else
        {
            newAnimalType.imageFile = @"other.jpg";
        }
        // Add this question to the locations array
        [_AnimalTypes addObject:newAnimalType];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        [self.delegate itemsDownloaded:_AnimalTypes];
    }
}

@end