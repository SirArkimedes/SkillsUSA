//
//  AddCommitteeViewController.h
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/17/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QRCodeReaderDelegate.h"

@interface AddCommitteeViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, QRCodeReaderDelegate>

@end
