//
//  RanchViewController.m
//  _sampledb
//
//  Created by Jennifer Tsau on 12/27/14.
//  Copyright (c) 2014 ___SummerTechnologies___. All rights reserved.
//

#import "RanchViewController.h"
#import "FTCViewController.h"
#import "IndividualAnimalTableViewController.h"

@interface RanchViewController ()
{
    RanchData *_ranchData;
    NSArray *_ranches;
}

@end

@implementation RanchViewController

@synthesize NavBarTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NavBarTitle.title = [NSString stringWithFormat:@"Ranches With %@s", self.item.animal];
    
    self.ranchListTableView.delegate = self;
    self.ranchListTableView.dataSource = self;
    
    // Create array object and assign it to _feedItems variable
    _ranches = [[NSArray alloc] init];
    
    // Create new HomeModel object and assign it to _homeModel variable
    _ranchData = [[RanchData alloc] init];
    
    // Set this view controller object as the delegate for the home model object
    _ranchData.delegate = self;
    
    // Call the download items method of the home model object
    [_ranchData downloadItems:self.item.animal];
    
    self.navigationItem.backBarButtonItem=[[UIBarButtonItem alloc] initWithTitle:@"animalToRanch" style:UIBarButtonItemStylePlain target:nil action:nil];

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
//Added 12/31
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return _ranches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *cellIdentifier = @"RanchCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    Ranch *item = [_ranches objectAtIndex:indexPath.row];
    NSLog(@"TEST!!!: %@", item.ranch);
    UILabel *ranchNameLabel = (UILabel *)[cell viewWithTag:300];
    ranchNameLabel.text = item.ranch;
    
    // ----- COUNT CODE STUFF ----------
    NSLog(@"TEST2!!!: %@", item.ranches_count);
    
    UILabel *ranchDetailLabel = (UILabel *)[cell viewWithTag:301];
    
    ranchDetailLabel.text = item.ranches_count;    
    
    //cell.textLabel.text = item.ranch;
    
//    UILabel *animalTypeLabel = (UILabel *)[myCell viewWithTag:101];
//    animalTypeLabel.text = item.animal;
    
//    UILabel *ranchLabel = (UILabel *)[cell viewWithTag:200];
//    ranchLabel.text = item.ranch;
    
//    NSLog(@"TEST!!!: %@", item.ranch);
    
    return cell;
}

- (void)itemsDownloaded:(NSArray *)ranchItems
{
    _ranches = ranchItems;
    NSLog(@"%@", _ranches);
    [self.ranchListTableView reloadData];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ranchToIndividualAnimalID"])
    {
        //        NSIndexPath *indexPath = [self.listTableView indexPathForCell:sender];
        NSIndexPath *indexPath = [self.ranchListTableView indexPathForSelectedRow];
        
        //AnimalType *animalType = [self.listTableView objectAtIndexPath:indexPath];
        IndividualAnimalTableViewController *viewController = segue.destinationViewController;
        Ranch *selectedRanch = [_ranches objectAtIndex:indexPath.row];
        viewController.ranch = selectedRanch.ranch;
        viewController.animal_type = self.item.animal;
        viewController.animalTypeObject = self.item;
        
        //NSLog(@" data %@", viewController.item.animal);
    }
    else if ([segue.identifier isEqualToString:@"BackToMain"])
    {
    

   }
}

//- (IBAction)RanchBackAction:(id)sender
//{
//    [self.delegate RanchViewControllerDidBack:self];
//}
@end
