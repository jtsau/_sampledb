//
//  FTCViewController.m
//  _sampledb
//
//  Created by Jennifer Tsau on 8/4/14.
//  Copyright (c) 2014 ___SummerTechnologies___. All rights reserved.
//

#import "FTCViewController.h"
#import "AnimalType.h"
#import "RanchViewController.h"

@interface FTCViewController ()
{
    HomeModel *_homeModel;
    NSArray *_animals;
}
@end

@implementation FTCViewController

@synthesize listTableView;

static NSString *animalToRanch = @"animalToRanch";

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // Set this view controller object as the delegate and data source for the table view
    self.listTableView.delegate = self;
    self.listTableView.dataSource = self;
  
    
    // Create array object and assign it to _feedItems variable
    _animals = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _homeModel = [[HomeModel alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _homeModel.delegate = self;
    
    // Call the download items method of the home model object
    [_homeModel downloadItems];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 528)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)itemsDownloaded:(NSArray *)items
{
    // This delegate method will get called when the items are finished downloading
    
    // Set the downloaded items to the array
    _animals = items;
    
    // Reload the table view
    [self.listTableView reloadData];
}

#pragma mark Table View Delegate Methods

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of feed items (initially 0)
    return _animals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Retrieve cell
    NSString *cellIdentifier = @"BasicCell";
    UITableViewCell *myCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // Get the location to be shown
    // 12/24 newly inputted based on website: www.appcoda.com/ios-programming-customize-uitableview-stoyrboard/
    //Cattle *item = _feedItems[indexPath.row];
    AnimalType *item = [_animals objectAtIndex:indexPath.row];
    UIImageView *animalImageView = (UIImageView *)[myCell viewWithTag:100];
//    animalImageView.image = [UIImage imageNamed:item.imageFile];
    
    //added 12/24
    UILabel *animalTypeLabel = (UILabel *)[myCell viewWithTag:101];
    animalTypeLabel.text = item.animal;
    
    UILabel *animalDetailLabel = (UILabel *)[myCell viewWithTag:102];
                                  
    animalDetailLabel.text = item.count;
    NSLog(@"imageFile: %@", item.imageFile);
//    animalImageView.image = [UIImage imageNamed:item.imageFile];
    myCell.imageView.image = [UIImage imageNamed:item.imageFile];
    NSLog(@"image Itself: %@", animalImageView.image);
    
    //added 12/24 animalDetailLabel.text = item.detail;
    
    // Get references to labels of cell
//    myCell.textLabel.text = item.ranch;
   // myCell.textLabel.text = item.animal;
//    myCell.textLabel.text = [myCell.textLabel.text stringByAppendingString:item.breed];
//    myCell.textLabel.text = [myCell.textLabel.text stringByAppendingString:item.ID_Number];
//    myCell.textLabel.text = item.birthdate;
//    myCell.textLabel.text = item.target_sell_date;
//    myCell.textLabel.text = item.notes;
//    myCell.textLabel.text = item.UID;
    
    return myCell;
}

// 12/27 Segue: animal type screen to ranch
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"animalToRanch"])
    {
//        NSIndexPath *indexPath = [self.listTableView indexPathForCell:sender];
        NSIndexPath *indexPath = [self.listTableView indexPathForSelectedRow];
        
        //AnimalType *animalType = [self.listTableView objectAtIndexPath:indexPath];
        RanchViewController *viewController = segue.destinationViewController;
        viewController.item = [_animals objectAtIndex:indexPath.row];
        
        //12 28 Trying to test if the data is being logged, can't figure out how to debug and what the information in the console means
        NSLog(@" data %@", viewController.item.animal);
    }
    else if ([segue.identifier isEqualToString:@"AddAnimal"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddAnimalViewController *addAnimalViewController = [navigationController viewControllers][0];
        addAnimalViewController.delegate = self;
    }
}

// Added 1/1

- (void)AddAnimalViewControllerDidCancel:(AddAnimalViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)AddAnimalViewControllerDidSave:(AddAnimalViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//- (void)RanchViewControllerDidBack:(RanchViewController *)controller
//{
//    [self dismissViewControllerAnimated:YES completion:nil];
//}

- (void)AddAnimalViewController:(AddAnimalViewController *)controller didAddAnimal:(Animal *)animal
{
//    AnimalType newAnimalType = 
//    [self._animals addObject:animal];
//    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:([self._animals count] - 1) inSection:0];
//    [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
   

    NSURL *url = [NSURL URLWithString:@"http://farmtocloud.com/addAnimalService.php"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:60.0];
    
    NSString *selectorString = [NSString stringWithFormat:@"ranch=%@&animal=%@&breed=%@&ID_Number=%@&notes=%@", animal.ranch, animal.animal, animal.breed, animal.ID_Number, animal.notes];
    NSData *requestData = [selectorString dataUsingEncoding:NSUTF8StringEncoding];
//  [@"name=testname&suggestion=testing123" dataUsingEncoding:NSUTF8StringEncoding];
    
    [request setHTTPMethod:@"POST"];
    [request setValue:@"text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];
    [request setValue:[NSString stringWithFormat:@"%lu", (unsigned long)[requestData length]] forHTTPHeaderField:@"Content-Length"];
    [request setHTTPBody: requestData];
    
    [NSURLConnection connectionWithRequest:request delegate:self];
    [self dismissViewControllerAnimated:YES completion:nil];
    [_homeModel downloadItems];
}

//Added in first prepareForSegue code above -------- IGNORE ------
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
//{
//    if ([segue.identifier isEqualToString:@"AddAnimal"]) {
//        UINavigationController *navigationController = segue.destinationViewController;
//        AddAnimalViewController *addAnimalViewController = [navigationController viewControllers][0];
//        addAnimalViewController.delegate = self;
//    }
//}
@end