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
        
//        if (!(_professionalDev == YES)) {
//            _professionalDev = NO;
//        } else if (!(_communityService == YES)) {
//            _communityService = NO;
//        } else if (!(_employment == YES)) {
//            _employment = NO;
//        } else if (!(_waysAndMeans == YES)) {
//            _waysAndMeans = NO;
//        } else if (!(_skillsUSAChamps == YES)) {
//            _professionalDev = NO;
//        } else if (!(_publicRelations == YES)) {
//            _publicRelations = NO;
//        } else if (!(_socialActivites == YES)) {
//            _socialActivites = NO;
//        }
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

- (void)encodeWithCoder:(NSCoder *)coder;
{
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_school forKey:@"school"];
    [coder encodeObject:_color forKey:@"color"];
    
    [coder encodeBool:_chair forKey:@"chair"];
    
    [coder encodeObject:_role forKey:@"role"];
    
    [coder encodeBool:_professionalDev forKey:@"professionalDev"];
    [coder encodeBool:_communityService forKey:@"communityService "];
    [coder encodeBool:_employment forKey:@"employment"];
    [coder encodeBool:_waysAndMeans forKey:@"waysAndMeans"];
    [coder encodeBool:_skillsUSAChamps forKey:@"skillsUSAChamps"];
    [coder encodeBool:_publicRelations forKey:@"publicRelations"];
    [coder encodeBool:_socialActivites forKey:@"socialActivites"];
}

- (id)initWithCoder:(NSCoder *)coder;
{
    self = [super init];
    if (self != nil)
    {
        _name = [coder decodeObjectForKey:@"name"];
        _school = [coder decodeObjectForKey:@"school"];
        _color = [coder decodeObjectForKey:@"color"];
        
        _chair = [coder decodeBoolForKey:@"chair"];
        
        _role = [coder decodeObjectForKey:@"role"];
        
        _professionalDev = [coder decodeBoolForKey:@"professionalDev"];
        _communityService = [coder decodeBoolForKey:@"communityService"];
        _employment = [coder decodeBoolForKey:@"employment"];
        _waysAndMeans = [coder decodeBoolForKey:@"waysAndMeans"];
        _skillsUSAChamps = [coder decodeBoolForKey:@"skillsUSAChamps"];
        _publicRelations = [coder decodeBoolForKey:@"publicRelations"];
        _socialActivites = [coder decodeBoolForKey:@"socialActivites"];
        
    }
    return self;
}

@end
