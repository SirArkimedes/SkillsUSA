//
//  DetailCellViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 10/31/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "DetailCellViewController.h"
#import "AppDelegate.h"

@interface DetailCellViewController ()

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
@property (weak, nonatomic) IBOutlet UILabel *officerLabel;

@end

@implementation DetailCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
//    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
//    NSString *str1 = [appDelegate.scanName objectAtIndex:_indexPath.row];
//    self.nameLabel.text = str1;
//    
//    NSString *str2 = [appDelegate.scanSchool objectAtIndex:_indexPath.row];
//    self.schoolLabel.text = str2;
//    
//    self.colorImage.layer.cornerRadius = self.colorImage.frame.size.width / 2;
//    self.colorImage.clipsToBounds = YES;
//    
//    if ([[appDelegate.scanColor objectAtIndex:_indexPath.row] caseInsensitiveCompare: @"red"] == NSOrderedSame) {
//        self.colorImage.backgroundColor = [UIColor redColor];
//    } else if ([[appDelegate.scanColor objectAtIndex:_indexPath.row] caseInsensitiveCompare: @"blue"] == NSOrderedSame) {
//        self.colorImage.backgroundColor = [UIColor blueColor];
//    } else if ([[appDelegate.scanColor objectAtIndex:_indexPath.row] caseInsensitiveCompare: @"yellow"] == NSOrderedSame) {
//        self.colorImage.backgroundColor = [UIColor yellowColor];
//    } else if ([[appDelegate.scanColor objectAtIndex:_indexPath.row] caseInsensitiveCompare: @"green"] == NSOrderedSame) {
//        self.colorImage.backgroundColor = [UIColor greenColor];
//    } else if ([[appDelegate.scanColor objectAtIndex:_indexPath.row] caseInsensitiveCompare: @"purple"] == NSOrderedSame) {
//        self.colorImage.backgroundColor = [UIColor purpleColor];
//    } else if ([appDelegate.scanColor objectAtIndex:_indexPath.row] == nil) {
//        NSLog(@"scanColor is nil");
//    } else {
//        self.colorImage.backgroundColor = [UIColor whiteColor];
//    }
}

- (void)viewWillAppear:(BOOL)animated {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.nameLabel.text = [appDelegate.scanName objectAtIndex:appDelegate.indexPath.row];
    
    self.schoolLabel.text = [appDelegate.scanSchool objectAtIndex:appDelegate.indexPath.row];
    
//    if ([[appDelegate.officerRole objectAtIndex:appDelegate.indexPath.row] == nil]) {
//        self.officerLabel.text = @"Member";
//    } else {
//        self.officerLabel.text = [appDelegate.officerRole objectAtIndex:appDelegate.indexPath.row];
//    }
    
    self.colorImage.layer.cornerRadius = self.colorImage.frame.size.width / 2;
    self.colorImage.clipsToBounds = YES;
    
    if ([[appDelegate.scanColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"red"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor redColor];
    } else if ([[appDelegate.scanColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"blue"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor blueColor];
    } else if ([[appDelegate.scanColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"yellow"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor yellowColor];
    } else if ([[appDelegate.scanColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"green"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor greenColor];
    } else if ([[appDelegate.scanColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"purple"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor purpleColor];
    } else if ([[appDelegate.scanColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"black"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor blackColor];
    } else if ([[appDelegate.scanColor objectAtIndex:appDelegate.indexPath.row] caseInsensitiveCompare: @"orange"] == NSOrderedSame) {
        self.colorImage.backgroundColor = [UIColor orangeColor];
    } else if ([appDelegate.scanColor objectAtIndex:appDelegate.indexPath.row] == nil) {
        NSLog(@"scanColor is nil");
    } else {
        self.colorImage.backgroundColor = [UIColor whiteColor];
    }
}

- (void)viewWillDisappear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
