//
//  AddAnimalViewController.h
//  _sampledb
//
//  Created by Jennifer Tsau on 1/1/15.
//  Copyright (c) 2015 ___SummerTechnologies___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"


@class AddAnimalViewController;

@protocol AddAnimalViewControllerDelegate <NSObject>
- (void)AddAnimalViewControllerDidCancel: (AddAnimalViewController *)controller;
- (void)AddAnimalViewController:(AddAnimalViewController *)controller didAddAnimal:(Animal *)animal;
@end

@interface AddAnimalViewController : UITableViewController {
    IBOutlet UIScrollView *scroller;
}
@property (weak, nonatomic) IBOutlet UITextField *idNumberTextField;
@property (weak, nonatomic) IBOutlet UITextField *animalTypeTextField;
@property (weak, nonatomic) IBOutlet UITextField *breedTextField;
@property (weak, nonatomic) IBOutlet UITextField *ranchTextField;
@property (weak, nonatomic) IBOutlet UITextField *notesTextField;

@property (nonatomic, weak) id <AddAnimalViewControllerDelegate> delegate;

- (IBAction)cancel:(id)sender;
- (IBAction)done:(id)sender;

@end
