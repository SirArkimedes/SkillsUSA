//
//  DetailCommitteeViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/17/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "DetailCommitteeViewController.h"
#import "Person.h"
#import "Committee.h"
#import "AppDelegate.h"

#define PERSON_NO_EXIST 0xFFFFFFFF

@interface DetailCommitteeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *committeeLabel;
@property (weak, nonatomic) IBOutlet UILabel *committeeLabel2;
@property (weak, nonatomic) IBOutlet UIView *secondLabel;

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
    Committee *returnedCommittee = [appDelegate.committee objectAtIndex:appDelegate.indexPath.row];
    Person *returnedObject = [appDelegate.entries objectAtIndex:returnedCommittee.personIndex];
    
    self.nameLabel.text = returnedObject.name;
    
    self.schoolLabel.text = returnedObject.school;
    
//        self.committeeLabel.text = [appDelegate.committeeGroup objectAtIndex:appDelegate.indexPath.row];
    
    self.colorImage.layer.cornerRadius = self.colorImage.frame.size.width / 2;
    self.colorImage.clipsToBounds = YES;
    self.colorImage.layer.borderWidth = 5.0;
    self.colorImage.layer.borderColor = [[UIColor whiteColor] CGColor];
    
    int counter = 0;
    if (returnedObject.professionalDev == YES) {
        if (counter >= 1) {
            self.committeeLabel2.text = @"Professional Development";
            self.secondLabel.hidden = NO;
        } else {
            self.committeeLabel.text = @"Professional Development";
            self.secondLabel.hidden = YES;
        }
        counter++;
    }
    if (returnedObject.communityService == YES) {
        if (counter >= 1) {
            self.committeeLabel2.text = @"Community Service";
            self.secondLabel.hidden = NO;
        } else {
            self.committeeLabel.text = @"Community Service";
            self.secondLabel.hidden = YES;
        }
        counter++;
    }
    if (returnedObject.employment == YES) {
        if (counter >= 1) {
            self.committeeLabel2.text = @"Employment";
            self.secondLabel.hidden = NO;
        } else {
            self.committeeLabel.text = @"Employment";
            self.secondLabel.hidden = YES;
        }
        counter++;
    }
    if (returnedObject.waysAndMeans == YES) {
        if (counter >= 1) {
            self.committeeLabel2.text = @"Ways and Means";
            self.secondLabel.hidden = NO;
        } else {
            self.committeeLabel.text = @"Ways and Means";
            self.secondLabel.hidden = YES;
        }
        counter++;
    }
    if (returnedObject.skillsUSAChamps == YES) {
        if (counter >= 1) {
            self.committeeLabel2.text = @"SkillsUSA Championships";
            self.secondLabel.hidden = NO;
        } else {
            self.committeeLabel.text = @"SkillsUSA Championships";
            self.secondLabel.hidden = YES;
        }
        counter++;
    }
    if (returnedObject.publicRelations == YES) {
        if (counter >= 1) {
            self.committeeLabel2.text = @"Public Relations";
            self.secondLabel.hidden = NO;
        } else {
            self.committeeLabel.text = @"Public Relations";
            self.secondLabel.hidden = YES;
        }
        counter++;
    }
    if (returnedObject.socialActivites == YES) {
        if (counter >= 1) {
            self.committeeLabel2.text = @"Social Activities";
            self.secondLabel.hidden = NO;
        } else {
            self.committeeLabel.text = @"Social Activities";
            self.secondLabel.hidden = YES;
        }
        counter++;
    }
    
    
    if ([returnedObject.color caseInsensitiveCompare: @"red"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor redColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"blue"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor blueColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"yellow"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor yellowColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"green"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor greenColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"black"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor blackColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"orange"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor orangeColor];
    } else if (returnedObject.color == nil) {
        NSLog(@"scanColor is nil");
    } else {
        self.colorImage.backgroundColor = [UIColor whiteColor];
    }
    
    // Set navigation bar title to Name
    self.navigationItem.title = returnedObject.name;
    
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
