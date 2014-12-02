//
//  Person.h
//  SkillsUSA
//
//  Created by Andrew Robinson on 11/26/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Person : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *school;
@property (strong, nonatomic) NSString *color;

@property BOOL chair;

@property (strong, nonatomic) NSString *role;

@property BOOL professionalDev;
@property BOOL communityService;
@property BOOL employment;
@property BOOL waysAndMeans;
@property BOOL skillsUSAChamps;
@property BOOL publicRelations;
@property BOOL socialActivites;

- (id)initWithName:(NSString *)name withSchool:(NSString *)school withColor:(NSString *)color withRole:(NSString *)role;
- (id)initWithName:(NSString *)name withSchool:(NSString *)school withColor:(NSString *)color;

@end
