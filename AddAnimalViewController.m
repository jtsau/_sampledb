//
//  AddAnimalViewController.m
//  _sampledb
//
//  Created by Jennifer Tsau on 1/1/15.
//  Copyright (c) 2015 ___SummerTechnologies___. All rights reserved.
//

#import "AddAnimalViewController.h"
#import "Animal.h"

@interface AddAnimalViewController ()

@end

@implementation AddAnimalViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [scroller setScrollEnabled:YES];
    [scroller setContentSize:CGSizeMake(320, 528)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (IBAction)cancel:(id)sender
{
    [self.delegate AddAnimalViewControllerDidCancel:self];
}
- (IBAction)done:(id)sender
{
    Animal *animal = [[Animal alloc] init];
    animal.ID_Number = self.idNumberTextField.text;
    animal.breed = self.breedTextField.text;
    animal.notes = self.notesTextField.text;
    animal.ranch = self.ranchTextField.text;
    animal.animal = self.animalTypeTextField.text;
    [self.delegate AddAnimalViewController:self didAddAnimal:animal];
}

// Added 1/1 to let tap anywhere in text field row bring up keyboard
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        [self.idNumberTextField becomeFirstResponder];
    }
    else if (indexPath.section == 1) {
        [self.animalTypeTextField becomeFirstResponder];
    }
    else if (indexPath.section == 2) {
        [self.breedTextField becomeFirstResponder];
    }
    else if (indexPath.section == 3) {
        [self.ranchTextField becomeFirstResponder];
    }
    else if (indexPath.section == 4) {
        [self.notesTextField becomeFirstResponder];
    }
}


@end
