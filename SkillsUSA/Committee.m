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

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:self.committeeName forKey:@"name"];
    [coder encodeInteger:self.personIndex forKey:@"index"];
    [coder encodeBool:self.chair forKey:@"chair"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        self.committeeName = [coder decodeObjectForKey:@"name"];
        self.personIndex = [coder decodeIntegerForKey:@"index"];
        self.chair = [coder decodeBoolForKey:@"chair"];
        
    }
    return self;
}


@end
