//
//  DetailViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/7/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "DetailViewController.h"
#import "Person.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *officerLabel;

@end

@implementation DetailViewController

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
    
    NSNumber *index = [appDelegate.officerIndex objectAtIndex:appDelegate.indexPath.row];
    NSUInteger integer = [index integerValue];
    Person *returnedObject = [appDelegate.entries objectAtIndex:integer];
    
    self.nameLabel.text = returnedObject.name;
    
    self.schoolLabel.text = returnedObject.school;
    
    self.officerLabel.text = returnedObject.role;
    
    self.colorImage.layer.cornerRadius = self.colorImage.frame.size.width / 2;
    self.colorImage.clipsToBounds = YES;
    self.colorImage.layer.borderWidth = 5.0;
    self.colorImage.layer.borderColor = [[UIColor whiteColor] CGColor];
    
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
