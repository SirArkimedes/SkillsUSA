//
//  Person.m
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/26/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import "Person.h"

@implementation Person

- (id)initWithName:(NSString *)name withSchool:(NSString *)school withColor:(NSString *)color withRole:(NSString *)role {
    
    if (self = [super init]) {
        _name = name;
        _school = school;
        _color = color;
        _role = role;

    }
    return self;
}

- (id)initWithName:(NSString *)name withSchool:(NSString *)school withColor:(NSString *)color {
    
    if (self = [super init]) {
        _name = name;
        _school = school;
        _color = color;
    }
    return self;
}

@end
