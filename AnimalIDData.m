//
//  AnimalIDData.m
//  _sampledb
//
//  Created by Jennifer Tsau on 1/3/15.
//  Copyright (c) 2015 ___SummerTechnologies___. All rights reserved.
//


#import "AnimalIDData.h"
#import "Animal.h"
//#import "RanchViewController.h"

@interface AnimalIDData()
{
    NSMutableData *_downloadedData;
}
@end

@implementation AnimalIDData

- (void)downloadItems:(NSString *)ranch :(NSString *)animal_type
{
    // Download the json file
    NSString *urlString = [NSString stringWithFormat:@"http://farmtocloud.com/animalIDs_service.php?animal=%@&ranch=%@", animal_type, ranch];
    
    NSLog(@"url: %@", urlString);
    
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
    NSMutableArray *_Animals = [[NSMutableArray alloc] init];
    
    // Parse the JSON that came in
    NSError *error;
    NSArray *jsonArray = [NSJSONSerialization JSONObjectWithData:_downloadedData options:NSJSONReadingAllowFragments error:&error];
    
    // Loop through Json objects, create question objects and add them to our questions array
    for (int i = 0; i < jsonArray.count; i++)
    {
        NSDictionary *jsonElement = jsonArray[i];
        
        // Create a new location object and set its props to JsonElement properties
        Animal *newAnimal = [[Animal alloc] init];
        
        newAnimal.ranch = jsonElement[@"Ranch"];
        newAnimal.animal = jsonElement[@"Animal"];
        newAnimal.breed = jsonElement[@"Breed"];
        newAnimal.birthdate = jsonElement[@"Birthdate"];
        newAnimal.ID_Number = jsonElement[@"ID_Number"];
        newAnimal.notes = jsonElement[@"Notes"];
        newAnimal.target_sell_date = jsonElement[@"Target_Sell_Date"];
        newAnimal.UID = jsonElement[@"UID"];
        
        // Add this question to the locations array
        [_Animals addObject:newAnimal];
    }
    
    // Ready to notify delegate that data is ready and pass back items
    if (self.delegate)
    {
        NSLog(@"animals test: %@", _Animals);
        [self.delegate itemsDownloaded:_Animals];
    }
}

@end