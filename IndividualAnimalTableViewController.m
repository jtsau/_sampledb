//
//  IndividualAnimalTableViewController.m
//  _sampledb
//
//  Created by Jennifer Tsau on 1/3/15.
//  Copyright (c) 2015 ___SummerTechnologies___. All rights reserved.
//

#import "IndividualAnimalTableViewController.h"
#import "RanchViewController.h"
#import "AnimalDetailViewController.h"

@interface IndividualAnimalTableViewController ()
{
    AnimalIDData *_animalIDData;
    NSArray *_animals;
}
@end

@implementation IndividualAnimalTableViewController

@synthesize IndividualAnimalTableView;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.IndividualAnimalTableView.delegate = self;
    self.IndividualAnimalTableView.dataSource = self;
    
    self.navBarTitleIndAnimal.title = [NSString stringWithFormat:@"%@ IDs on %@ Ranch", self.animal_type, self.ranch];
    
    // Create array object and assign it to variable
    _animals = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to variable
    _animalIDData = [[AnimalIDData alloc] init];
    
    // Set this view controller object as the delegate for the data model object
    _animalIDData.delegate = self;
    
    // Call the download items method of the data model object
    [_animalIDData downloadItems:self.ranch :self.animal_type];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _animals.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"AnimalCell";
    UITableViewCell *animalCell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Animal *item = [_animals objectAtIndex:indexPath.row];
    NSLog(@"TEST animal id: %@", item.ID_Number);
//    UILabel *ranchNameLabel = (UILabel *)[cell viewWithTag:300];
    animalCell.textLabel.text = item.ID_Number;
    
    return animalCell;
}

- (void)itemsDownloaded:(NSArray *)animalItems
{
    _animals = animalItems;
    NSLog(@"%@", _animals);
    [self.IndividualAnimalTableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"idToDetail"])
    {
        //        NSIndexPath *indexPath = [self.listTableView indexPathForCell:sender];
        NSIndexPath *indexPath = [self.IndividualAnimalTableView indexPathForSelectedRow];
        
        //AnimalType *animalType = [self.listTableView objectAtIndexPath:indexPath];
        AnimalDetailViewController *viewController = segue.destinationViewController;
        viewController._animal = [_animals objectAtIndex:indexPath.row];
        viewController.AnimalTypeObject = self.animalTypeObject;
        
        NSLog(@"Segue data %@", viewController._animal.notes);
    }
    else if ([segue.identifier isEqualToString:@"BackToRanch"])
    {
        RanchViewController *viewController = segue.destinationViewController;
        viewController.item = self.animalTypeObject;
  
        
    }
}


@end
