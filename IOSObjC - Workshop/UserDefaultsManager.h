//
//  userDefaultsManager.h
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import <Foundation/Foundation.h>
#import "Task.h"

NS_ASSUME_NONNULL_BEGIN

@interface UserDefaultsManager : NSObject
- (NSMutableArray<Task *> *) getTodo;

- (NSMutableArray<Task *> *) getInprogress;

- (NSMutableArray<Task *> *) getDone;


-(NSMutableArray<Task *> *) getArr : (NSString *) ObjectKey;

- (void) addToTodo : (Task *) task;

- (void) addToInprog : (Task *) task;

- (void) addToDone : (Task *) task;

- (void) setTodo: (NSMutableArray<Task*> *) taks;

- (void) setInprog: (NSMutableArray<Task*> *) taks;

- (void) setDone: (NSMutableArray<Task*> *) taks;

- (void) setToUserDef: (NSString* ) objectKey arr: (NSArray*) arr;

@end

NS_ASSUME_NONNULL_END
