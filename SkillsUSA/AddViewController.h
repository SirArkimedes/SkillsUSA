//
//  AddViewController.h
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/7/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"

@interface AddViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, QRCodeReaderDelegate>

@end
