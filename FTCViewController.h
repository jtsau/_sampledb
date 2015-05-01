//
//  FTCViewController.h
//  _sampledb
//
//  Created by Jennifer Tsau on 8/4/14.
//  Copyright (c) 2014 ___SummerTechnologies___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HomeModel.h"
#import "AddAnimalViewController.h"
#import "RanchViewController.h"

@interface FTCViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, HomeModelProtocol, AddAnimalViewControllerDelegate> {
    IBOutlet UIScrollView *scroller;
}
// -----Added 1/4 --------
//@property (weak, nonatomic) IBOutlet UIImageView *animalPhoto;


@property (weak, nonatomic) IBOutlet UITableView *listTableView;

@end

//1/1/2015 Adding a new line instead of adding to line 13
//@interface FTCViewController : UITableViewController <AddAnimalViewControllerDelegate>
//
//@end