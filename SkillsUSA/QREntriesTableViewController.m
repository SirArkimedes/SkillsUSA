//
//  QREntriesTableViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 10/27/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "QREntriesTableViewController.h"
#import "RegistrantsTableViewCell.h"
#import "QRCodeReaderViewController.h"

@interface QREntriesTableViewController ()

//@property (strong, nonatomic) NSMutableArray *scannedResults;
@property (strong, nonatomic) NSMutableArray *scanName;
@property (strong, nonatomic) NSMutableArray *scanSchool;


@end

@implementation QREntriesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /*-------------------------------------------------------
     TODO: Setup userDefaults
     -------------------------------------------------------*/
    
//    self.scannedResults     = [[NSMutableArray alloc] init];
    self.scanName           = [[NSMutableArray alloc] init];
    self.scanSchool         = [[NSMutableArray alloc] init];

    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)unwindToList:(UIStoryboardSegue *)segue {
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.scanName count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    RegistrantsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"scannedCell" forIndexPath:indexPath];
    
    // Configure the cell...
    
    cell.nameCell.text = [self.scanName objectAtIndex:indexPath.row];
//    NSLog(@"nameCell: %@", cell.nameCell.text);
    
    cell.schoolCell.text = [self.scanSchool objectAtIndex:indexPath.row];
//    NSLog(@"schoolCell: %@", cell.schoolCell.text);
    
    return cell;
}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.scanName removeObjectAtIndex:indexPath.row];
        [self.scanSchool removeObjectAtIndex:indexPath.row];
        [tableView reloadData]; // tell table to refresh now
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (IBAction)addEntry:(id)sender {
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    reader.modalPresentationStyle      = UIModalPresentationFormSheet;
    
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        [self dismissViewControllerAnimated:YES completion:^{
//            NSLog(@"String: %@", resultAsString);
            
            if (resultAsString == nil) {
                NSLog(@"resultAsString = %@", resultAsString);
            } else {
//                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCode" message:resultAsString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
//                [alert show];
                
                NSArray *data = [resultAsString componentsSeparatedByString:@"/"];
                NSLog(@"%@", data);
                
                NSString *str1 = [data objectAtIndex:0];
                [self.scanName addObject:str1];
//                NSLog(@"scanName: %@", self.scanName);
                
                NSString *str2 = [data objectAtIndex:1];
                [self.scanSchool addObject:str2];
//                NSLog(@"scanSchool: %@", self.scanSchool);

                
//                [self.scannedResults addObject:resultAsString];
//                NSLog(@"Array: %@", self.scannedResults);
                [self.tableView reloadData];
            }
            
        }];
    }];
    
    [self presentViewController:reader animated:YES completion:NULL];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Result: %@", result);
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return YES;
}

- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    
    NSString *stringToMove = self.scanName[sourceIndexPath.row];
    [self.scanName removeObjectAtIndex:sourceIndexPath.row];
    [self.scanName insertObject:stringToMove atIndex:destinationIndexPath.row];
    
    NSString *stringToMove2 = self.scanSchool[sourceIndexPath.row];
    [self.scanSchool removeObjectAtIndex:sourceIndexPath.row];
    [self.scanSchool insertObject:stringToMove2 atIndex:destinationIndexPath.row];
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
