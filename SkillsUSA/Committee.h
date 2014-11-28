//
//  Committee.h
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/27/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Committee : NSObject

@property (strong, nonatomic) NSString *committeeName;
@property NSUInteger personIndex;

- (id)initWithName:(NSString *)name withIndex:(NSUInteger)index;

@end
