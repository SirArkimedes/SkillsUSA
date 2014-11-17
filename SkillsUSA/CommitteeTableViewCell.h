//
//  CommitteeTableViewCell.h
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/17/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommitteeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *colorCell;
@property (weak, nonatomic) IBOutlet UILabel *nameCell;
@property (weak, nonatomic) IBOutlet UILabel *schoolCell;
@property (weak, nonatomic) IBOutlet UILabel *groupCell;

@end
