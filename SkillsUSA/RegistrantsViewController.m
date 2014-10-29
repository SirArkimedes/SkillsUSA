//
//  RegistrantsViewController.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 10/29/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "RegistrantsViewController.h"
#import "QRCodeReaderViewController.h"

@interface RegistrantsViewController ()

@end

@implementation RegistrantsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editTable:(id)sender {
    QRCodeReaderViewController *reader = [QRCodeReaderViewController new];
    reader.modalPresentationStyle      = UIModalPresentationFormSheet;
    
    [reader setCompletionWithBlock:^(NSString *resultAsString) {
        [self dismissViewControllerAnimated:YES completion:^{
            NSLog(@"%@", resultAsString);
            
            if (resultAsString == nil) {
                NSLog(@"resultAsString = %@", resultAsString);
            } else {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"QRCode" message:resultAsString delegate:self cancelButtonTitle:@"Okay" otherButtonTitles:nil, nil];
                [alert show];
                
                self.scannedResults = [[NSMutableArray alloc] init];
                [self.scannedResults addObject:resultAsString];
                NSLog(@"Array: %@", self.scannedResults);
                [[NSNotificationCenter defaultCenter] postNotificationName:@"capture"
                                                                    object:nil];
            }
            
        }];
    }];
    
    [self presentViewController:reader animated:YES completion:NULL];
}

#pragma mark - QRCodeReader Delegate Methods

- (void)reader:(QRCodeReaderViewController *)reader didScanResult:(NSString *)result
{
    [self dismissViewControllerAnimated:YES completion:^{
        NSLog(@"%@", result);
    }];
}

- (void)readerDidCancel:(QRCodeReaderViewController *)reader
{
    [self dismissViewControllerAnimated:YES completion:NULL];
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
