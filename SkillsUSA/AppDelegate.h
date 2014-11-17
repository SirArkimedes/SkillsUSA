//
//  AppDelegate.h
//  SkillsUSA
//
//  Created by Andrew Robinson on 10/22/14.
//  Copyright (c) 2014 Andrew Robinson. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (strong, nonatomic) NSMutableArray *scanName;
@property (strong, nonatomic) NSMutableArray *scanSchool;
@property (strong, nonatomic) NSMutableArray *scanColor;

@property (strong, nonatomic) NSMutableArray *officersName;
@property (strong, nonatomic) NSMutableArray *officersSchool;
@property (strong, nonatomic) NSMutableArray *officerColor;
@property (strong, nonatomic) NSMutableArray *officerRole;

@property (strong, nonatomic) NSMutableArray *committeeName;
@property (strong, nonatomic) NSMutableArray *committeeSchool;
@property (strong, nonatomic) NSMutableArray *committeeColor;
@property (strong, nonatomic) NSMutableArray *committeeGroup;

@property (strong, nonatomic) NSIndexPath *indexPath;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end

