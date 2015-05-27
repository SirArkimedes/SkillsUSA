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
#import "Person.h"
#import "Committee.h"
#import "AppDelegate.h"
#import <MessageUI/MessageUI.h>

@interface QREntriesCommitteeTableViewController () <MFMailComposeViewControllerDelegate>

@property (strong, nonatomic) NSIndexPath *savedSelectedIndexPath;

@end

@implementation QREntriesCommitteeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    self.savedSelectedIndexPath = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView deselectRowAtIndexPath:[self.tableView indexPathForSelectedRow] animated:animated];
    
    [self.tableView reloadData];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self.savedSelectedIndexPath = self.tableView.indexPathForSelectedRow;
    
    if (self.savedSelectedIndexPath) {
        [self.tableView deselectRowAtIndexPath:self.savedSelectedIndexPath animated:YES];
    }
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
    
    NSString *nameMod;
    if ([returnedObject.chair isEqualToString: returnedCommittee.committeeName]) {
        nameMod = [NSString stringWithFormat:@"%@ - Chair", returnedObject.name];
    } else {
        nameMod = returnedObject.name;
    }
    
    cell.nameCell.text = nameMod;
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
        
        Committee *returnedCommittee = [appDelegate.committee objectAtIndex:indexPath.row];
        Person *returnedObject = [appDelegate.entries objectAtIndex:returnedCommittee.personIndex];
        
        NSString *committee = returnedCommittee.committeeName;
        
        if ([committee isEqual: @"Professional Development"]) {
            returnedObject.professionalDev = NO;
        } else if ([committee isEqual: @"Community Service"]) {
            returnedObject.communityService = NO;
        } else if ([committee isEqual: @"Employment"]) {
            returnedObject.employment = NO;
        } else if ([committee isEqual: @"Ways and Means"]) {
            returnedObject.waysAndMeans = NO;
        } else if ([committee isEqual: @"SkillsUSA Championships"]) {
            returnedObject.skillsUSAChamps = NO;
        } else if ([committee isEqual: @"Public Relations"]) {
            returnedObject.publicRelations = NO;
        } else if ([committee isEqual: @"Social Activities"]) {
            returnedObject.socialActivites = NO;
        }
        
        if (returnedCommittee.chair == YES) {
            returnedObject.chair = nil;
        }
        
        [appDelegate.committee removeObjectAtIndex:indexPath.row];
        
        [tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

#pragma mark - Share

-(NSString *)dataFilePathPro {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Professional Development.csv"];
}

-(NSString *)dataFilePathCom{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Community Service.csv"];
}

-(NSString *)dataFilePathEmp {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Employment.csv"];
}

-(NSString *)dataFilePathWay {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Ways and Means.csv"];
}

-(NSString *)dataFilePathSki {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"SkillsUSA Championships.csv"];
}

-(NSString *)dataFilePathPub {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Public Relations.csv"];
}

-(NSString *)dataFilePathSoc {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    return [documentsDirectory stringByAppendingPathComponent:@"Social Activities.csv"];
}

- (IBAction)sharePress:(id)sender {
    
    if ([MFMailComposeViewController canSendMail]) {

        AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        
        //    if (![[NSFileManager defaultManager] fileExistsAtPath:[self dataFilePath]]) {
        //        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePath] contents:nil attributes:nil];
        //        NSLog(@"Route creato");
        //    }
        
        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePathPro] contents:nil attributes:nil];
        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePathCom] contents:nil attributes:nil];
        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePathEmp] contents:nil attributes:nil];
        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePathWay] contents:nil attributes:nil];
        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePathSki] contents:nil attributes:nil];
        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePathPub] contents:nil attributes:nil];
        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePathSoc] contents:nil attributes:nil];
        
        NSMutableString *writeStringPro = [NSMutableString stringWithCapacity:0];
        NSMutableString *writeStringCom = [NSMutableString stringWithCapacity:0];
        NSMutableString *writeStringEmp = [NSMutableString stringWithCapacity:0];
        NSMutableString *writeStringWay = [NSMutableString stringWithCapacity:0];
        NSMutableString *writeStringSki = [NSMutableString stringWithCapacity:0];
        NSMutableString *writeStringPub = [NSMutableString stringWithCapacity:0];
        NSMutableString *writeStringSoc = [NSMutableString stringWithCapacity:0];
        
        for (int i = 0; i < [appDelegate.entries count]; i++) {
            Person *returnedObject = [appDelegate.entries objectAtIndex:i];
            
            NSString *isChair;
            
            if (returnedObject.professionalDev == YES) {
                if ([returnedObject.chair isEqual: @"Professional Development"]) {
                    isChair = @"Yes";
                } else {
                    isChair = @"";
                }
                if ([writeStringPro containsString:@"Name,School,Color,Chair"]) {
                    [writeStringPro appendString:[NSString stringWithFormat:@"%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                } else {
                    [writeStringPro appendString:[NSString stringWithFormat:@"Name,School,Color,Chair\n%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                }
            }
            if (returnedObject.communityService == YES) {
                if ([returnedObject.chair isEqual: @"Community Service"]) {
                    isChair = @"Yes";
                } else {
                    isChair = @"";
                }
                if ([writeStringCom containsString:@"Name,School,Color,Chair"]) {
                    [writeStringCom appendString:[NSString stringWithFormat:@"%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                } else {
                    [writeStringCom appendString:[NSString stringWithFormat:@"Name,School,Color,Chair\n%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                }
            }
            if (returnedObject.employment == YES) {
                if ([returnedObject.chair isEqual: @"Employment"]) {
                    isChair = @"Yes";
                } else {
                    isChair = @"";
                }
                if ([writeStringEmp containsString:@"Name,School,Color,Chair"]) {
                    [writeStringEmp appendString:[NSString stringWithFormat:@"%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                } else {
                    [writeStringEmp appendString:[NSString stringWithFormat:@"Name,School,Color,Chair\n%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                }
            }
            if (returnedObject.waysAndMeans == YES) {
                if ([returnedObject.chair isEqual: @"Ways and Means"]) {
                    isChair = @"Yes";
                } else {
                    isChair = @"";
                }
                if ([writeStringWay containsString:@"Name,School,Color,Chair"]) {
                    [writeStringWay appendString:[NSString stringWithFormat:@"%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                } else {
                    [writeStringWay appendString:[NSString stringWithFormat:@"Name,School,Color,Chair\n%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                }
            }
            if (returnedObject.skillsUSAChamps == YES) {
                if ([returnedObject.chair isEqual: @"SkillsUSA Championships"]) {
                    isChair = @"Yes";
                } else {
                    isChair = @"";
                }
                if ([writeStringSki containsString:@"Name,School,Color,Chair"]) {
                    [writeStringSki appendString:[NSString stringWithFormat:@"%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                } else {
                    [writeStringSki appendString:[NSString stringWithFormat:@"Name,School,Color,Chair\n%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                }
            }
            if (returnedObject.publicRelations == YES) {
                if ([returnedObject.chair isEqual: @"Public Relations"]) {
                    isChair = @"Yes";
                } else {
                    isChair = @"";
                }
                if ([writeStringPub containsString:@"Name,School,Color,Chair"]) {
                    [writeStringPub appendString:[NSString stringWithFormat:@"%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                } else {
                    [writeStringPub appendString:[NSString stringWithFormat:@"Name,School,Color,Chair\n%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                }
            }
            if (returnedObject.socialActivites == YES) {
                if ([returnedObject.chair isEqual: @"Social Activities"]) {
                    isChair = @"Yes";
                } else {
                    isChair = @"";
                }
                if ([writeStringSoc containsString:@"Name,School,Color,Chair"]) {
                    [writeStringSoc appendString:[NSString stringWithFormat:@"%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                } else {
                    [writeStringSoc appendString:[NSString stringWithFormat:@"Name,School,Color,Chair\n%@,%@,%@,%@\n", returnedObject.name, returnedObject.school, returnedObject.color, isChair]];
                }
            }
        }

        NSFileHandle *handle;
        handle = [NSFileHandle fileHandleForWritingAtPath:[self dataFilePathPro]];
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        [handle writeData:[writeStringPro dataUsingEncoding:NSUTF8StringEncoding]];
        
        handle = [NSFileHandle fileHandleForWritingAtPath:[self dataFilePathCom]];
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        [handle writeData:[writeStringCom dataUsingEncoding:NSUTF8StringEncoding]];
        
        handle = [NSFileHandle fileHandleForWritingAtPath:[self dataFilePathEmp]];
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        [handle writeData:[writeStringEmp dataUsingEncoding:NSUTF8StringEncoding]];
        
        handle = [NSFileHandle fileHandleForWritingAtPath:[self dataFilePathWay]];
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        [handle writeData:[writeStringWay dataUsingEncoding:NSUTF8StringEncoding]];
        
        handle = [NSFileHandle fileHandleForWritingAtPath:[self dataFilePathSki]];
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        [handle writeData:[writeStringSki dataUsingEncoding:NSUTF8StringEncoding]];
        
        handle = [NSFileHandle fileHandleForWritingAtPath:[self dataFilePathPub]];
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        [handle writeData:[writeStringPub dataUsingEncoding:NSUTF8StringEncoding]];
        
        handle = [NSFileHandle fileHandleForWritingAtPath:[self dataFilePathSoc]];
        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
        [handle writeData:[writeStringSoc dataUsingEncoding:NSUTF8StringEncoding]];

        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
        mailViewController.mailComposeDelegate = self;
        [mailViewController setSubject:@"Committees Data"];
        [mailViewController setMessageBody:@"" isHTML:NO];
        //    mailViewController.navigationBar.tintColor = [UIColor blackColor];

        [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:[self dataFilePathPro]]
                                     mimeType:@"text/csv"
                                     fileName:@"Professional Development.csv"];
        
        [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:[self dataFilePathCom]]
                                     mimeType:@"text/csv"
                                     fileName:@"Community Service.csv"];
        
        [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:[self dataFilePathEmp]]
                                     mimeType:@"text/csv"
                                     fileName:@"Employment.csv"];
        
        [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:[self dataFilePathWay]]
                                     mimeType:@"text/csv"
                                     fileName:@"Ways and Means.csv"];
        
        [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:[self dataFilePathSki]]
                                     mimeType:@"text/csv"
                                     fileName:@"SkillsUSA Championships.csv"];
        
        [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:[self dataFilePathPub]]
                                     mimeType:@"text/csv"
                                     fileName:@"Public Relations.csv"];
        
        [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:[self dataFilePathSoc]]
                                     mimeType:@"text/csv"
                                     fileName:@"Social Activities.csv"];

//        [[NSFileManager defaultManager] createFileAtPath:[self dataFilePath] contents:nil attributes:nil];
//        
//        NSMutableString *writeString = [NSMutableString stringWithCapacity:0];
//        
//        for (int i = 0; i < [appDelegate.entries count]; i++) {
//            Person *returnedObject = [appDelegate.entries objectAtIndex:i];
//            
//            if ([writeString containsString:@"Name,School,Color"]) {
//                [writeString appendString:[NSString stringWithFormat:@"%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@\n",
//                                           returnedObject.name,
//                                           returnedObject.school,
//                                           returnedObject.color,
//                                           NSStringChairFromBOOL(returnedObject.chair),
//                                           NSStringFromBOOL(returnedObject.professionalDev),
//                                           NSStringFromBOOL(returnedObject.communityService),
//                                           NSStringFromBOOL(returnedObject.employment),
//                                           NSStringFromBOOL(returnedObject.waysAndMeans),
//                                           NSStringFromBOOL(returnedObject.skillsUSAChamps),
//                                           NSStringFromBOOL(returnedObject.publicRelations),
//                                           NSStringFromBOOL(returnedObject.socialActivites)]];
//            } else {
//                [writeString appendString:[NSString stringWithFormat:@"Name,School,Color,Chair,Professional Development,Community Service,Employment,Ways and Means,SkillsUSA Championships,Public Relations,Social Activities\n%@,%@,%@,%@,%@,%@,%@,%@,%@,%@,%@\n",
//                                           returnedObject.name,
//                                           returnedObject.school,
//                                           returnedObject.color,
//                                           NSStringChairFromBOOL(returnedObject.chair),
//                                           NSStringFromBOOL(returnedObject.professionalDev),
//                                           NSStringFromBOOL(returnedObject.communityService),
//                                           NSStringFromBOOL(returnedObject.employment),
//                                           NSStringFromBOOL(returnedObject.waysAndMeans),
//                                           NSStringFromBOOL(returnedObject.skillsUSAChamps),
//                                           NSStringFromBOOL(returnedObject.publicRelations),
//                                           NSStringFromBOOL(returnedObject.socialActivites)]];
//
//            }
//        }
//        
////        NSLog(@"writeString: %@", writeString);
//        
//        NSFileHandle *handle;
//        handle = [NSFileHandle fileHandleForWritingAtPath: [self dataFilePath]];
//        //say to handle where's the file fo write
//        [handle truncateFileAtOffset:[handle seekToEndOfFile]];
//        //position handle cursor to the end of file
//        [handle writeData:[writeString dataUsingEncoding:NSUTF8StringEncoding]];
//        
//        MFMailComposeViewController *mailViewController = [[MFMailComposeViewController alloc] init];
//        mailViewController.mailComposeDelegate = self;
//        [mailViewController setSubject:@"Committees Data"];
//        [mailViewController setMessageBody:@"" isHTML:NO];
//        //    mailViewController.navigationBar.tintColor = [UIColor blackColor];
//        NSString *csvFilePath = [self dataFilePath];
//        
//        [mailViewController addAttachmentData:[NSData dataWithContentsOfFile:csvFilePath]
//                                     mimeType:@"text/csv"
//                                     fileName:@"Committees Data.csv"];
        
        [self presentViewController:mailViewController animated:YES completion:nil];
    } else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!"
                                                        message:@"Sending mail is not configured or is disabled on this device."
                                                       delegate:self
                                              cancelButtonTitle:@"Okay"
                                              otherButtonTitles:nil, nil];
        [alert show];
    }
}

//static inline NSString* NSStringFromBOOL(BOOL aBool) {
//    return aBool? @"Member" : @""; }
//
//static inline NSString* NSStringChairFromBOOL(BOOL aBool) {
//    return aBool? @"Chair" : @""; }

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
