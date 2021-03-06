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

@property (strong, nonatomic) NSMutableArray *entries;
@property (strong, nonatomic) NSMutableArray *officerIndex;
@property (strong, nonatomic) NSMutableArray *committee;

@property (strong, nonatomic) NSIndexPath *indexPath;
@property (strong, nonatomic) NSNumber *gottenOfficer;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end

