//
//  DetailCommitteeViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/17/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "DetailCommitteeViewController.h"
#import "AppDelegate.h"

@interface DetailCommitteeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *committeeLabel;

@end

@implementation DetailCommitteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    self.nameLabel.text = [appDelegate.committeeName objectAtIndex:appDelegate.indexPath.row];
    
    self.schoolLabel.text = [appDelegate.committeeSchool objectAtIndex:appDelegate.indexPath.row];
    
    //    self.committeeLabel.text = [appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row];
    if ([[appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row]  isEqual: @"Pres."]) {
        self.committeeLabel.text = @"President";
    } else if ([[appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row]  isEqual: @"V.P."]) {
        self.committeeLabel.text = @"Vice President";
    } else if ([[appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row]  isEqual: @"Treas."]) {
        self.committeeLabel.text = @"Treasurer";
    } else if ([[appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row]  isEqual: @"Sec."]) {
        self.committeeLabel.text = @"Secratary";
    } else if ([[appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row]  isEqual: @"Rep."]) {
        self.committeeLabel.text = @"Reporter";
    } else if ([[appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row]  isEqual: @"Hist."]) {
        self.committeeLabel.text = @"Historian";
    } else if ([[appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row]  isEqual: @"Par."]) {
        self.committeeLabel.text = @"Parlimentarian";
    } else if ([[appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row]  isEqual: @"Chap."]) {
        self.committeeLabel.text = @"Chaplain";
    }
    
    self.colorImage.layer.cornerRadius = self.colorImage.frame.size.width / 2;
    self.colorImage.clipsToBounds = YES;
    self.colorImage.layer.borderWidth = 5.0;
    self.colorImage.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    if ([[appDelegate.committeeColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"red"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor redColor];
    } else if ([[appDelegate.committeeColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"blue"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor blueColor];
    } else if ([[appDelegate.committeeColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"yellow"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor yellowColor];
    } else if ([[appDelegate.committeeColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"green"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor greenColor];
    } else if ([[appDelegate.committeeColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"black"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor blackColor];
    } else if ([[appDelegate.committeeColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"orange"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor orangeColor];
    } else if ([appDelegate.committeeColor objectAtIndex:appDelegate.indexPath.row] == nil) {
        NSLog(@"scanColor is nil");
    } else {
        self.colorImage.backgroundColor = [UIColor whiteColor];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
