//
//  AddCommitteeViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/17/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "AddCommitteeViewController.h"
#import "QRCodeReaderViewController.h"
#import "Person.h"
#import "Committee.h"
#import "AppDelegate.h"

#define COMMITTEE_NO_EXIST 0xFFFFFFFF

@interface AddCommitteeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
@property (weak, nonatomic) IBOutlet UIPickerView *rolePicker;
@property (weak, nonatomic) IBOutlet UILabel *groupLabel;

@property (strong, nonatomic) NSArray *pickerData;

@end

@implementation AddCommitteeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorImage.layer.cornerRadius = self.colorImage.frame.size.width / 2;
    self.colorImage.clipsToBounds = YES;
    
    // Init
    _pickerData = @[@"Professional Development", @"Community Service", @"Employment", @"Ways and Means", @"SkillsUSA Championships", @"Public Relations", @"Social Activities"];
    
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
    if ([[_pickerData objectAtIndex:row] isEqual: @"Professional Development"]) {
        self.groupLabel.text = @"Prof. Dev.";
    } else if ([[_pickerData objectAtIndex:row] isEqual: @"Community Service"]) {
        self.groupLabel.text = @"Com. Ser.";
    } else if ([[_pickerData objectAtIndex:row] isEqual: @"Employment"]) {
        self.groupLabel.text = @"Employ";
    } else if ([[_pickerData objectAtIndex:row] isEqual: @"Ways and Means"]) {
        self.groupLabel.text = @"WaM";
    } else if ([[self.pickerData objectAtIndex:row] isEqual: @"SkillsUSA Championships"]) {
        self.groupLabel.text = @"Ski. Cha.";
    } else if ([[self.pickerData objectAtIndex:row] isEqual: @"Public Relations"]) {
        self.groupLabel.text = @"Pub. Rel.";
    } else if ([[self.pickerData objectAtIndex:row] isEqual: @"Social Activities"]) {
        self.groupLabel.text = @"Soc. Act.";
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
            
            if (resultAsString == nil) {
                NSLog(@"resultAsString = %@", resultAsString);
            } else {
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCode" message:resultAsString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                //                [alert show];
                
                NSArray *data = [resultAsString componentsSeparatedByString:@"\n"];
                NSLog(@"%@", data);
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                
                NSString *selected = [self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]];

                
//                NSNumber *index = [NSNumber numberWithInteger:indexOfTheObject];
                
//                Person *returnedObject = [appDelegate.entries objectAtIndex:indexOfTheObject];
                
                NSString *namestr = [data objectAtIndex:0];
                NSString *schoolstr = [data objectAtIndex:1];
                NSString *colorstr = [data objectAtIndex:2];
                
                Person *personObject = [[Person alloc] initWithName:namestr withSchool:schoolstr withColor:colorstr];
                Committee *committee = [[Committee alloc] init];
                
                NSUInteger indexOfTheObject;
                indexOfTheObject = [self doesPersonExist:personObject];
                if(indexOfTheObject != COMMITTEE_NO_EXIST) {
                    personObject = [appDelegate.entries objectAtIndex:indexOfTheObject];
                }
//                if( indexOfTheObject = [self doesPersonExist:personObject] ) {
//                    // person exists
//                    indexOfTheObject = [self doesPersonBelongToCommittee:indexOfPerson];
//                }
//                indexOfTheObject = [self isCommitteeSelected:YES];
                
                NSString *shortenedName;
                if ([selected  isEqual: @"Professional Development"]) {
                    shortenedName = @"Prof. Dev.";
                    personObject.professionalDev = YES;
                } else if ([selected isEqual: @"Community Service"]) {
                    shortenedName = @"Com. Ser.";
                    personObject.communityService = YES;
                } else if ([selected isEqual: @"Employment"]) {
                    shortenedName = @"Employ";
                    personObject.employment = YES;
                } else if ([selected isEqual: @"Ways and Means"]) {
                    shortenedName = @"WaM";
                    personObject.waysAndMeans = YES;
                } else if ([selected isEqual: @"SkillsUSA Championships"]) {
                    shortenedName = @"Ski. Cha.";
                    personObject.skillsUSAChamps = YES;
                } else if ([selected isEqual: @"Public Relations"]) {
                    shortenedName = @"Pub. Rel.";
                    personObject.publicRelations = YES;
                } else if ([selected isEqual: @"Social Activities"]) {
                    shortenedName = @"Soc. Act.";
                    personObject.socialActivites = YES;
                }
//                [appDelegate.committeeGroup addObject:[self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]]];
                
                if (COMMITTEE_NO_EXIST != indexOfTheObject) {
                    // officer previously selected
                    // OFFICER EXISTS
                    [appDelegate.entries setObject:personObject atIndexedSubscript:indexOfTheObject];

                    committee.committeeName = [NSString stringWithFormat:@"%@", shortenedName];
                    committee.personIndex = indexOfTheObject;
                    [appDelegate.committee addObject:committee];
                    
                    NSLog(@"%@", appDelegate.committee);
                    
                } else {
                    // new officer not in array
                    // OFFICER NO EXIST
                    NSUInteger arrayCount = [appDelegate.entries count];
                    [appDelegate.entries addObject:personObject];
                    
                    committee.committeeName = [NSString stringWithFormat:@"%@", shortenedName];
                    committee.personIndex = arrayCount;
//                    committee = [[Committee alloc] initWithName:shortenedName withIndex:arrayCount];
                    [appDelegate.committee addObject:committee];
                    
                    NSLog(@"%@", appDelegate.committee);
                }
                
//                if ([[self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]]  isEqual: @"President"]) {
//                    [appDelegate.committeeGroup addObject:@"Pres."];
//                } else if ([[self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]] isEqual: @"Vice President"]) {
//                    [appDelegate.committeeGroup addObject:@"V.P."];
//                } else if ([[self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]] isEqual: @"Treasurer"]) {
//                    [appDelegate.committeeGroup addObject:@"Treas."];
//                } else if ([[self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]] isEqual: @"Secratary"]) {
//                    [appDelegate.committeeGroup addObject:@"Sec."];
//                } else if ([[self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]] isEqual: @"Reporter"]) {
//                    [appDelegate.committeeGroup addObject:@"Rep."];
//                } else if ([[self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]] isEqual: @"Historian"]) {
//                    [appDelegate.committeeGroup addObject:@"Hist."];
//                } else if ([[self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]] isEqual: @"Parlimentarian"]) {
//                    [appDelegate.committeeGroup addObject:@"Par."];
//                } else if ([[self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]] isEqual: @"Chaplain"]) {
//                    [appDelegate.committeeGroup addObject:@"Chap."];
//                }
                
                //                NSString *str4 = [self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]];
                //                [appDelegate.committeeGroup addObject:str4];
                //                NSLog(@"%@", appDelegate.committeeGroup);
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        }];
    }];
    
    [self presentViewController:reader animated:YES completion:NULL];
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
    return COMMITTEE_NO_EXIST;
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
