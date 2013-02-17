//
//  MMNewMoyaViewController.m
//  MoyaMap
//
//  Created by Haruyuki Seki on 2/17/13.
//  Copyright (c) 2013 Hacker's Cafe. All rights reserved.
//

#import "MMNewMoyaViewController.h"

@interface MMNewMoyaViewController ()

@end

@implementation MMNewMoyaViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)showNewMoyaView {

    [self presentModalViewController:self.placePickerController animated:YES];
}


- (void)viewDidLoad
{

    [super viewDidLoad];
	// Do any additional setup after loading the view.
}
- (void)viewDidAppear:(BOOL)animated{
    [self.textTag becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressClose:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}

- (IBAction)pressPlace:(id)sender{
    if (!self.placePickerController) {
        self.placePickerController = [[FBPlacePickerViewController alloc]
                                      initWithNibName:nil bundle:nil];
        self.placePickerController.title = @"Select a restaurant";
    }
    self.placePickerController.locationCoordinate = _lastLocation.coordinate;
    self.placePickerController.radiusInMeters = 1000;
    self.placePickerController.resultsLimit = 50;
    self.placePickerController.searchText = @"restaurant";
    
    [self.placePickerController loadData];
    [self.navigationController pushViewController:self.placePickerController animated:YES];
}

- (IBAction)pressMoya:(id)sender {
    [self.navigationController dismissModalViewControllerAnimated:YES];
}
- (void)viewDidUnload {
    self.placePickerController = nil;
    [self setText:nil];
    [self setTextTag:nil];
    [super viewDidUnload];
}
@end
