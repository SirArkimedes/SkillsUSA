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
    if ([[_pickerData objectAtIndex:row]  isEqual: @"President"]) {
        self.roleLabel.text = @"Pres.";
    } else if ([[_pickerData objectAtIndex:row]  isEqual: @"Vice President"]) {
        self.roleLabel.text = @"V.P.";
    } else if ([[_pickerData objectAtIndex:row]  isEqual: @"Treasurer"]) {
        self.roleLabel.text = @"Treas.";
    } else if ([[_pickerData objectAtIndex:row]  isEqual: @"Secratary"]) {
        self.roleLabel.text = @"Sec.";
    } else if ([[self.pickerData objectAtIndex:row] isEqual: @"Reporter"]) {
        self.roleLabel.text = @"Rep.";
    } else if ([[self.pickerData objectAtIndex:row] isEqual: @"Historian"]) {
        self.roleLabel.text = @"Hist.";
    } else if ([[self.pickerData objectAtIndex:row] isEqual: @"Parlimentarian"]) {
        self.roleLabel.text = @"Par.";
    } else if ([[self.pickerData objectAtIndex:row] isEqual: @"Chaplain"]) {
        self.roleLabel.text = @"Chap.";
    }
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
    
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        [self dismissViewControllerAnimated:YES completion:^{
            //            NSLog(@"String: %@", resultAsString);
            
            NSString *officerRoleString = [self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]];
            
            if (resultAsString == nil) {
                NSLog(@"resultAsString = %@", resultAsString);
            } else {
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCode" message:resultAsString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                //                [alert show];
                
                NSArray *data = [resultAsString componentsSeparatedByString:@"\n"];
                NSLog(@"%@", data);
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];

                NSUInteger indexOfTheObject = [self isOfficerSelected:officerRoleString];
                
                NSString *namestr = [data objectAtIndex:0];
                NSString *schoolstr = [data objectAtIndex:1];
                NSString *colorstr = [data objectAtIndex:2];
                
                Person *personObject = [[Person alloc] initWithName:namestr withSchool:schoolstr withColor:colorstr withRole:@""];
                
                NSUInteger existing = [self doesPersonExist:personObject];
                if (existing != OFFICER_NO_EXIST) {
                    indexOfTheObject = existing;
                }
                NSNumber *index = [NSNumber numberWithInteger:indexOfTheObject];
                
                if ([officerRoleString isEqual: @"President"]) {
                    personObject.role = @"Pres.";
                } else if ([officerRoleString isEqual: @"Vice President"]) {
                    personObject.role = @"V.P.";
                } else if ([officerRoleString isEqual: @"Treasurer"]) {
                    personObject.role = @"Treas.";
                } else if ([officerRoleString isEqual: @"Secratary"]) {
                    personObject.role = @"Sec.";
                } else if ([officerRoleString isEqual: @"Reporter"]) {
                    personObject.role = @"Rep.";
                } else if ([officerRoleString isEqual: @"Historian"]) {
                    personObject.role = @"Hist.";
                } else if ([officerRoleString isEqual: @"Parlimentarian"]) {
                    personObject.role = @"Par.";
                } else if ([officerRoleString isEqual: @"Chaplain"]) {
                    personObject.role = @"Chap.";
                }
                
                if (OFFICER_NO_EXIST != indexOfTheObject) {
                    // officer previously selected
                    // OFFICER EXISTS
                    
                    [appDelegate.entries setObject:personObject atIndexedSubscript:indexOfTheObject];
                    [appDelegate.officerIndex addObject:index];
                    
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
                
            }
            
        }];
    }];
    
    [self presentViewController:reader animated:YES completion:NULL];
}

- (NSUInteger)isOfficerSelected:(NSString *)off {
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSArray* per_arr = appDelegate.entries;
    
    NSString *role;
    if ([off isEqual: @"President"]) {
        role = @"Pres.";
    } else if ([off isEqual: @"Vice President"]) {
        role = @"V.P.";
    } else if ([off isEqual: @"Treasurer"]) {
        role = @"Treas.";
    } else if ([off isEqual: @"Secratary"]) {
        role = @"Sec.";
    } else if ([off isEqual: @"Reporter"]) {
        role = @"Rep.";
    } else if ([off isEqual: @"Historian"]) {
        role = @"Hist.";
    } else if ([off isEqual: @"Parlimentarian"]) {
        role = @"Par.";
    } else if ([off isEqual: @"Chaplain"]) {
        role = @"Chap.";
    } else {
        role = nil;
    }
    
    for (int i = 0; i < [appDelegate.entries count]; i++) {
        Person *per = per_arr[i];
        if([per.role isEqualToString:role]) {
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

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    NSLog(@"Testing: %@", result);
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"Result: %@", result);
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
