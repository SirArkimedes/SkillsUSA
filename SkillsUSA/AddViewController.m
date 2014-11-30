//
//  AddViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/7/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "AddViewController.h"
#import "QRCodeReaderViewController.h"
#import "AppDelegate.h"
#import "Person.h"

#define OFFICER_NO_EXIST 0xFFFFFFFF

/*
 0-F
 0-9, normal digits
 10, A
 11, B
 12, C
 13, D
 14, E
 15, F
 
 0000b, 0x0
 0001b, 0x1
    |
    |
 1010b, 0xA
 1011b, 0xB
 1100b, 0xC
 1101b, 0xD
 1110b, 0xE
 1111b, 0xF
 
 0xFF -> 1111 1111b
 0xAF -> 1010 1111b
 */

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
@property (weak, nonatomic) IBOutlet UIPickerView *rolePicker;
@property (weak, nonatomic) IBOutlet UILabel *roleLabel;

@property (strong, nonatomic) NSArray *pickerData;

@property BOOL shouldAnimate;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorImage.layer.cornerRadius = self.colorImage.frame.size.width / 2;
    self.colorImage.clipsToBounds = YES;
    
    // Init
     _pickerData = @[@"President", @"Vice President", @"Treasurer", @"Secratary", @"Reporter", @"Historian", @"Parlimentarian", @"Chaplain"];
    
    // Connect data
    self.rolePicker.dataSource = self;
    self.rolePicker.delegate = self;
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PickerView data

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return _pickerData.count;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    self.roleLabel.text = [_pickerData objectAtIndex:row];
}

#pragma mark - Title Color Change

- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (row == 0) {
        NSString *title = [_pickerData objectAtIndex:0];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    } else if (row == 1) {
        NSString *title = [_pickerData objectAtIndex:1];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    } else if (row == 2) {
        NSString *title = [_pickerData objectAtIndex:2];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    } else if (row == 3) {
        NSString *title = [_pickerData objectAtIndex:3];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    } else if (row == 4) {
        NSString *title = [_pickerData objectAtIndex:4];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    } else if (row == 5) {
        NSString *title = [_pickerData objectAtIndex:5];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    } else if (row == 6) {
        NSString *title = [_pickerData objectAtIndex:6];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    } else if (row == 7) {
        NSString *title = [_pickerData objectAtIndex:7];
        NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]}];
        return attString;
    }
    
    return 0;
    
}

#pragma mark - IBAction Camera Selection

- (IBAction)addEntry:(id)sender {
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    reader.modalPresentationStyle      = UIModalPresentationFormSheet;
    
    reader.delegate = self;
    
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        [self dismissViewControllerAnimated:YES completion:^{
            //            NSLog(@"String: %@", resultAsString);
            
            NSString *officerRoleString = [self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]];
            
            if (resultAsString == nil) {
//                NSLog(@"resultAsString = %@", resultAsString);
            } else {
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCode" message:resultAsString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                //                [alert show];
                
                if ([resultAsString containsString:@"\n"]) {
                    NSArray *data = [resultAsString componentsSeparatedByString:@"\n"];
//                    NSLog(@"%@", data);
                    
                    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

                    NSUInteger indexOfTheObject = [self isOfficerSelected:officerRoleString];
                    
                    NSString *namestr = [data objectAtIndex:0];
                    NSString *schoolstr = [data objectAtIndex:1];
                    NSString *colorstr = [data objectAtIndex:2];
                    
                    Person *personObject = [[Person alloc] initWithName:namestr withSchool:schoolstr withColor:colorstr withRole:@""];
                    
//                    NSNumber *index = [NSNumber numberWithInteger:indexOfTheObject];
                    
                    NSUInteger existing = [self doesPersonExist:personObject];
                    if (existing != OFFICER_NO_EXIST) {
                        indexOfTheObject = existing;
                        
                    }
                    
                    if (OFFICER_NO_EXIST != indexOfTheObject) {
                        // officer previously selected
                        // OFFICER EXISTS
                        
                        Person *returnedObject = [appDelegate.entries objectAtIndex:indexOfTheObject];
                        personObject = returnedObject;
                        
                        // Officer Assign
                        personObject.role = officerRoleString;
                        
                        [appDelegate.entries setObject:personObject atIndexedSubscript:indexOfTheObject];
//                        [appDelegate.officerIndex addObject:index];
//                        NSUInteger offIndex = [self doesOfficerExist:];
                        NSUInteger officer = [self doesOfficerExist:indexOfTheObject];
                        if (officer != OFFICER_NO_EXIST) {
                            self.shouldAnimate = YES;
                            appDelegate.gottenOfficer = [NSNumber numberWithInteger:officer];
                        } else {
                            NSNumber *num = [NSNumber numberWithInteger:indexOfTheObject];
                            [appDelegate.officerIndex addObject:num];
                        }
                        
                    } else {
                        // new officer not in array
                        // OFFICER NO EXIST
                        
                        NSNumber *entryCount = [NSNumber numberWithInteger:[appDelegate.entries count]];
                        [appDelegate.entries addObject:personObject];
                        [appDelegate.officerIndex addObject:entryCount];
                    }
                    
    //                NSString *str4 = officerRoleString;
    //                [appDelegate.officerRole addObject:str4];
    //                NSLog(@"%@", appDelegate.officerRole);
                    
                    [self.navigationController popViewControllerAnimated:YES];
                } else {
                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Oh no!"
                                                                    message:[NSString stringWithFormat:@"QR Code needs a format of:\nAndrew Robinson\nCarthage High\nBlue\n\nScanned: %@", resultAsString]
                                                                   delegate:self cancelButtonTitle:@"Okay"
                                                          otherButtonTitles:nil, nil];
                    [alert show];

                }
                
            }
            
            if (self.shouldAnimate == YES) {
//                NSIndexPath* rowToReload = [NSIndexPath indexPathForRow:self.indexOfTheObject inSection:0];
//                NSArray* rowsToReload = [NSArray arrayWithObjects:rowToReload, nil];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"ReloadRootViewControllerTable" object:nil];
//                QROfficersEntriresTableViewController *officers = [[QROfficersEntriresTableViewController alloc] init];
//                UITableView *table = [officers tableView];
                self.shouldAnimate = NO;
//                [table reloadRowsAtIndexPaths:rowsToReload withRowAnimation:UITableViewRowAnimationTop];
            }
            
        }];
    }];
    
    [self presentViewController:reader animated:YES completion:NULL];
}

- (NSUInteger)isOfficerSelected:(NSString *)off {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray* per_arr = appDelegate.entries;
    
    for (int i = 0; i < [appDelegate.entries count]; i++) {
        Person *per = per_arr[i];
        if([per.role isEqualToString:off]) {
            return i;
        }
    }
    return OFFICER_NO_EXIST;
}

- (NSUInteger)doesPersonExist:(Person *)person {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray* per_arr = appDelegate.entries;
    
    for (int i = 0; i < [appDelegate.entries count]; i++) {
        Person *per = per_arr[i];
        if([person.name isEqual:per.name] && [person.school isEqual:per.school] && [person.color isEqual:per.color]) {
            return i;
        }
    }
    return OFFICER_NO_EXIST;
}

- (NSUInteger)doesOfficerExist:(NSUInteger)off {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    for (int i = 0; i < [appDelegate.officerIndex count]; i++) {
        NSNumber *number = [appDelegate.officerIndex objectAtIndex:i];
        NSUInteger integer = [number integerValue];
        if (off == integer) {
            return i;
        }
    }
    return OFFICER_NO_EXIST;
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
}


#pragma mark - Navigation

/*
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


@end
