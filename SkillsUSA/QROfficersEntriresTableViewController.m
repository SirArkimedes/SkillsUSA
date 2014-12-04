//
//  QROfficersEntriresTableViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/7/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "QROfficersEntriresTableViewController.h"
#import "QRCodeReaderViewController.h"
#import "OfficersTableViewCell.h"
#import "Person.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

#define LARGE_NUMBER 0xFFFFFFFF

@interface QROfficersEntriresTableViewController () <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSIndexPath *savedSelectedIndexPath;

@end

@implementation QROfficersEntriresTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableCell) name:@"ReloadRootViewControllerTable" object:nil];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.savedSelectedIndexPath = nil;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.savedSelectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    if (self.savedSelectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:self.savedSelectedIndexPath animated:YES];
    }
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)reloadTableCell {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSUInteger officer = [appDelegate.gottenOfficer integerValue];
    
    NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:officer inSection:0];
    NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
    if (LARGE_NUMBER != officer) {
        [self.tableView reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationTop];
    }
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
    return [appDelegate.officerIndex count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    OfficersTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scannedCell" forIndexPath:indexPath];
    
    // Configure the cell...
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSNumber *index = [appDelegate.officerIndex objectAtIndex:indexPath.row];
    NSUInteger integer = [index integerValue];
    Person *returnedObject = [appDelegate.entries objectAtIndex:integer];
    
    // Rounds the edges of the imageview
    cell.colorCell.layer.cornerRadius = cell.colorCell.frame.size.width / 2;
    cell.colorCell.clipsToBounds = YES;
    
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
        NSLog(@"officerColor is nil");
    } else {
        cell.colorCell.backgroundColor = [UIColor whiteColor];
    }
    
    cell.nameCell.text = returnedObject.name;
    //    NSLog(@"nameCell: %@", cell.nameCell.text);
    
    cell.schoolCell.text = returnedObject.school;
    //    NSLog(@"schoolCell: %@", cell.schoolCell.text);
    
    cell.roleCell.text = returnedObject.role;
    //    NSLog (@"officerRole: %@", clel.roleCell.text);
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
        
        NSNumber *index = [appDelegate.officerIndex objectAtIndex:indexPath.row];
        NSUInteger integer = [index integerValue];
        Person *returnedObject = [appDelegate.entries objectAtIndex:integer];
        returnedObject.role = nil;
        
        [appDelegate.officerIndex removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - Share

-(NSString *)dataFilePath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Officers Data.csv"];
}

- (IBAction)sharePress:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
    
        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
    //    if (![[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
    //        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePath] contents:nil attributes:nil];
    //        NSLog(@"Route creato");
    //    }
        
        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePath] contents:nil attributes:nil];
        
        NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
        
        for (int i = 0; i < [appDelegate.entries count]; i++) {
            Person *returnedObject = [appDelegate.entries objectAtIndex:i];
            
            if ([writeString containsString:@"Name,School,Color"]) {
                [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, returnedObject.role]];
            } else {
                [writeString appendString:[NSString stringWithFormat:@"Name,School,Color,Role,\n%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, returnedObject.role]];
            }
        }
        
//        NSLog(@"writeString: %@", writeString);
        
        NSFileHandle *handle;
        handle = [NSFileHandle fileHandleForWritingAtPath: [self dataFilePath]];
        //say to handle where's the file fo write
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        //position handle cursor to the end of file
        [handle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Officers Data"];
        [mailViewController setMessageBody:@"" isHTML:NO];
        //    mailViewController.navigationBar.tintColor = [UIColor blackColor];
        NSString *csvFilePath = [self dataFilePath];
        
        [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:csvFilePath]
                                     mimeType:@"text/csv"
                                     fileName:@"Officers Data.csv"];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!" message:@"Sending mail is not configured or is disabled on this device." delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
        [alert show];
    }
    
//    NSString *textToShare = @"<html><body><!--Andrew Table--><style>#andrew-table, tr, td{border: 1px solid black;padding: 0px;margin: 0px;border-collapse: collapse;}.text {padding: 5px;}td {width: 100px;height: 25px;}</style><table><tr><td class='text'>Name</td><td class='text'>School</td><td class='text'>Color</td></tr><tr><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td></tr><tr><td></td><td></td><td></td></tr></table>";
//    NSArray *itemsToShare = @[textToShare];
//    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:itemsToShare applicationActivities:nil];
//    activityVC.excludedActivityTypes = @[UIActivityTypePrint,
//                                         UIActivityTypeMessage,
//                                         UIActivityTypeCopyToPasteboard,
//                                         UIActivityTypeAssignToContact,
//                                         UIActivityTypeSaveToCameraRoll,
//                                         UIActivityTypeAirDrop,
//                                         UIActivityTypePostToTwitter,
//                                         UIActivityTypePostToFacebook,
//                                         UIActivityTypePostToFlickr,
//                                         UIActivityTypePostToVimeo,
//                                         UIActivityTypePostToWeibo,
//                                         UIActivityTypePostToTencentWeibo]; //or whichever you don't need
//    
//    [activityVC setValue:@"Officers Data" forKey:@"subject"];
//    [self presentViewController:activityVC animated:YES completion:nil];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error {
    switch (result)
    {
        case MFMailComposeResultCancelled:
            break;
        case MFMailComposeResultSaved:
            break;
        case MFMailComposeResultSent: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail"
                                                            message:@"Mail send: the email message is queued in the outbox."
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
        case MFMailComposeResultFailed: {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!"
                                                            message:@"Mail failed: the email message was not saved or queued, possibly due to an error."
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
        default:{
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Mail"
                                                            message:@"Mail not sent."
                                                           delegate:self
                                                  cancelButtonTitle:@"Okay"
                                                  otherButtonTitles:nil, nil];
            [alert show];
            break;
        }
    }
    // Remove the mail view
    [self dismissViewControllerAnimated:YES completion:nil];
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

