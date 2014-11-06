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

@end

@implementation DetailCellViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSString *str1 = [appDelegate.scanName objectAtIndex:0];
    self.nameLabel.text = [NSString stringWithFormat:@"%@", str1];
    
    NSString *str2 = [appDelegate.scanSchool objectAtIndex:0];
    self.schoolLabel.text = [NSString stringWithFormat:@"School: %@", str2];
    
    self.colorImage.layer.cornerRadius = self.colorImage.frame.size.width / 2;
    self.colorImage.clipsToBounds = YES;
    
//    if ([[appDelegate.scanColor objectAtIndex:indexPath.row] caseInsensitiveCompare: @"red"] == NSOrderedSame) {
//        self.color.backgroundColor = [UIColor redColor];
//    } else if ([[appDelegate.scanColor objectAtIndex:indexPath.row] caseInsensitiveCompare: @"blue"] == NSOrderedSame) {
//        cell.colorCell.backgroundColor = [UIColor blueColor];
//    } else if ([[appDelegate.scanColor objectAtIndex:indexPath.row] caseInsensitiveCompare: @"yellow"] == NSOrderedSame) {
//        cell.colorCell.backgroundColor = [UIColor yellowColor];
//    } else if ([[appDelegate.scanColor objectAtIndex:indexPath.row] caseInsensitiveCompare: @"green"] == NSOrderedSame) {
//        cell.colorCell.backgroundColor = [UIColor greenColor];
//    } else if ([[appDelegate.scanColor objectAtIndex:indexPath.row] caseInsensitiveCompare: @"purple"] == NSOrderedSame) {
//        cell.colorCell.backgroundColor = [UIColor purpleColor];
//    } else if ([appDelegate.scanColor objectAtIndex:indexPath.row] == nil) {
//        NSLog(@"scanColor is nil");
//    } else {
//        cell.colorCell.backgroundColor = [UIColor whiteColor];
//    }
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
