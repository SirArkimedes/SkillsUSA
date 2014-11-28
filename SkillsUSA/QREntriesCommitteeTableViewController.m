//
//  QREntriesCommitteeTableViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/17/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "QREntriesCommitteeTableViewController.h"
#import "QRCodeReaderViewController.h"
#import "CommitteeTableViewCell.h"
#import "DetailViewController.h"
#import "Person.h"
#import "Committee.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

@interface QREntriesCommitteeTableViewController ()

@end

@implementation QREntriesCommitteeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Pass IndexPath to other views

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //    DetailCellViewController *vc = [[DetailCellViewController alloc] initWithNibName:@"DetailCellViewController" bundle:nil];
    //    [vc setIndexPath:indexPath];
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    appDelegate.indexPath = indexPath;
    //    NSLog(@"indexPath.row: %ld", (long)indexPath.row);
    //    NSLog(@"indexPath.section: %ld", (long)indexPath.section);
}

#pragma mark - Unwind

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    return [appDelegate.committee count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CommitteeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scannedCell" forIndexPath:indexPath];
    
    // Configure the cell...
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    Committee *returnedCommittee = [appDelegate.committee objectAtIndex:indexPath.row];
    Person *returnedObject = [appDelegate.entries objectAtIndex:returnedCommittee.personIndex];
    
    // Rounds the edges of the imageview
    cell.colorCell.layer.cornerRadius = cell.colorCell.frame.size.width / 2;
    cell.colorCell.clipsToBounds = YES;
//    
    // Checks for color type, not case sensitive.
    if ([returnedObject.color caseInsensitiveCompare: @"red"] == NSOrderedSame) {
        cell.colorCell.backgroundColor = [UIColor redColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"blue"] == NSOrderedSame) {
        cell.colorCell.backgroundColor = [UIColor blueColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"yellow"] == NSOrderedSame) {
        cell.colorCell.backgroundColor = [UIColor yellowColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"green"] == NSOrderedSame) {
        cell.colorCell.backgroundColor = [UIColor greenColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"black"] == NSOrderedSame) {
        cell.colorCell.backgroundColor = [UIColor blackColor];
    } else if ([returnedObject.color caseInsensitiveCompare: @"orange"] == NSOrderedSame) {
        cell.colorCell.backgroundColor = [UIColor orangeColor];
    } else if (returnedObject.color == nil) {
        NSLog(@"committeeColor is nil");
    } else {
        cell.colorCell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.nameCell.text = returnedObject.name;
    //    NSLog(@"nameCell: %@", cell.nameCell.text);
    
    cell.schoolCell.text = returnedObject.school;
    //    NSLog(@"schoolCell: %@", cell.schoolCell.text);
    
    cell.groupCell.text = returnedCommittee.committeeName;
    //    NSLog (@"committeeGroup: %@", clel.roleCell.text);
    
    return cell;
}

#pragma mark - Deleting Tableview Cells

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [appDelegate.committeeName removeObjectAtIndex:indexPath.row];
        [appDelegate.committeeSchool removeObjectAtIndex:indexPath.row];
        [appDelegate.committeeColor removeObjectAtIndex:indexPath.row];
        [appDelegate.committeeGroup removeObjectAtIndex:indexPath.row];
        [tableView reloadData]; // tell table to refresh now
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - Share

- (IBAction)sharePress:(id)sender {
    
    NSString *textToShare = @"<html><body><!--Andrew Table--><style>#andrew-table, tr, td{border: 1px solid black;padding: 0px;margin: 0px;border-collapse: collapse;}.text {padding: 5px;}td {width: 100px;height: 25px;}</style><table><tr><td class='text'>Name</td><td class='text'>School</td><td class='text'>Color</td></tr><tr><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td></tr></table>";
    NSArray *itemsToShare = @[textToShare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypePrint,
                                         UIActivityTypeMessage,
                                         UIActivityTypeCopyToPasteboard,
                                         UIActivityTypeAssignToContact,
                                         UIActivityTypeSaveToCameraRoll,
                                         UIActivityTypeAirDrop,
                                         UIActivityTypePostToTwitter,
                                         UIActivityTypePostToFacebook,
                                         UIActivityTypePostToFlickr,
                                         UIActivityTypePostToVimeo,
                                         UIActivityTypePostToWeibo,
                                         UIActivityTypePostToTencentWeibo]; //or whichever you don't need
    
    [activityVC setValue:@"Officers Data" forKey:@"subject"];
    [self presentViewController:activityVC animated:YES completion:nil];
    
    //    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    //    [mailComposeViewController setToRecipients:@[@"mattt@nshipster.com"]];
    //    [mailComposeViewController setSubject:@"Hello"];
    //    [mailComposeViewController setMessageBody:@"Lorem ipsum dolor sit amet"
    //                                       isHTML:NO];
    //    [self presentViewController:mailComposeViewController animated:YES completion:^{
    //        // ...
    //    }];
    
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