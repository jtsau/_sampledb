//
//  AnimalDetailViewController.m
//  _sampledb
//
//  Created by Jennifer Tsau on 1/3/15.
//  Copyright (c) 2015 ___SummerTechnologies___. All rights reserved.
//

#import "AnimalDetailViewController.h"
#import "IndividualAnimalTableViewController.h"
#import "Ranch.h"

@interface AnimalDetailViewController ()

@end

@implementation AnimalDetailViewController

@synthesize animalID;
@synthesize breed;
@synthesize birthdate;
@synthesize notes;
@synthesize navBarTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    navBarTitle.title = [NSString stringWithFormat:@"%@ in %@ Ranch", self._animal.animal, self._animal.ranch];
    
    animalID.text = self._animal.ID_Number;
    breed.text = self._animal.breed;
    birthdate.text = self._animal.birthdate;
    notes.text = self._animal.notes;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"BackToIndividualAnimal"])
    {
        IndividualAnimalTableViewController *viewController = segue.destinationViewController;
        viewController.ranch = self._animal.ranch;
        viewController.animal_type = self._animal.animal;
        viewController.animalTypeObject = self.AnimalTypeObject;
    }
}

@end
