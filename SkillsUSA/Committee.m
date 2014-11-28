//
//  Committee.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/27/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "Committee.h"

@implementation Committee

- (id)initWithName:(NSString *)name withIndex:(NSUInteger)index {
    
    self = [super init];
    if (nil != self) {
        self.committeeName = [NSString stringWithFormat:@"%@", name];
        self.personIndex = index;
    }
    return self;
}

@end
