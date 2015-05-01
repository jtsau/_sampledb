//
//  RanchViewController.h
//  _sampledb
//
//  Created by Jennifer Tsau on 12/27/14.
//  Copyright (c) 2014 ___SummerTechnologies___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AnimalType.h"
#import "RanchData.h"
#import "Ranch.h"

@class RanchViewController;

//@protocol RanchViewControllerDelegate <NSObject>
//- (void)RanchViewControllerDidBack: (RanchViewController *)controller;
//@end

@interface RanchViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, RanchDataProtocol>

@property (weak, nonatomic) IBOutlet UITableView *ranchListTableView;

//@property (nonatomic, strong) IBOutlet UILabel *animalLabel;
@property (nonatomic, strong) NSString *animal;
@property (nonatomic, strong) AnimalType *item;

@property (weak, nonatomic) IBOutlet UINavigationItem *NavBarTitle;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *RanchBack;
//- (IBAction)RanchBackAction:(id)sender;
//
//@property (nonatomic, weak) id <RanchViewControllerDelegate> delegate;


@end
