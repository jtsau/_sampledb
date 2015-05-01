//
//  IndividualAnimalTableViewController.h
//  _sampledb
//
//  Created by Jennifer Tsau on 1/3/15.
//  Copyright (c) 2015 ___SummerTechnologies___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimalIDData.h"
#import "Animal.h"
#import "AnimalType.h"

@interface IndividualAnimalTableViewController : UITableViewController<AnimalIDDataProtocol>

@property (strong, nonatomic) IBOutlet UITableView *IndividualAnimalTableView;

@property (nonatomic, strong) NSString *ranch;
@property (nonatomic, strong) NSString *animal_type;
@property (nonatomic, strong) AnimalType *animalTypeObject;

@property (weak, nonatomic) IBOutlet UINavigationItem *navBarTitleIndAnimal;
@end
