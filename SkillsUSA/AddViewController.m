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

@interface AddViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *colorImage;
@property (weak, nonatomic) IBOutlet UIPickerView *rolePicker;

@property (strong, nonatomic) NSArray *pickerData;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.colorImage.layer.cornerRadius = self.colorImage.frame.size.width / 2;
    self.colorImage.clipsToBounds = YES;
    
    // Init
     _pickerData = @[@"President", @"Vice President", @"Treasurer", @"Secratary"];
    
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
            
            if (resultAsString == nil) {
                NSLog(@"resultAsString = %@", resultAsString);
            } else {
                //                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCode" message:resultAsString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                //                [alert show];
                
                NSArray *data = [resultAsString componentsSeparatedByString:@"\n"];
                NSLog(@"%@", data);
                
                AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                NSString *str1 = [data objectAtIndex:0];
                [appDelegate.officersName addObject:str1];
                //                NSLog(@"scanName: %@", appDelegate.scanName);
                
                NSString *str2 = [data objectAtIndex:1];
                [appDelegate.officersSchool addObject:str2];
                //                NSLog(@"scanSchool: %@", appDelegate.scanSchool);
                
                NSString *str3 = [data objectAtIndex:2];
                [appDelegate.officerColor addObject:str3];
                //                NSLog(@"scanColor: %@", appDelegate.scanColor);
                
                NSString *str4 = [self.pickerData objectAtIndex:[self.rolePicker selectedRowInComponent:0]];
                [appDelegate.officerRole addObject:str4];
                NSLog(@"%@", appDelegate.officerRole);
                
                [self.navigationController popViewControllerAnimated:YES];
                
            }
            
        }];
    }];
    
    [self presentViewController:reader animated:YES completion:NULL];
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
