//
//  AnimalDetailViewController.h
//  _sampledb
//
//  Created by Jennifer Tsau on 1/3/15.
//  Copyright (c) 2015 ___SummerTechnologies___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Animal.h"
#import "Ranch.h"
#import "AnimalType.h"

@interface AnimalDetailViewController : UIViewController

@property (weak, nonatomic) IBOutlet UINavigationItem *navBarTitle;
@property (weak, nonatomic) IBOutlet UILabel *animalID;
@property (weak, nonatomic) IBOutlet UILabel *breed;
@property (weak, nonatomic) IBOutlet UILabel *birthdate;
@property (weak, nonatomic) IBOutlet UILabel *notes;

@property (nonatomic, strong) Animal *_animal;
@property (nonatomic, strong) AnimalType *AnimalTypeObject;

@end
