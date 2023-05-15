//
//  userDefaultsManager.m
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import "UserDefaultsManager.h"

@implementation UserDefaultsManager

- (NSMutableArray<Task *> *) getTodo{
    return [self getArr:@"ToDo"];
}

- (NSMutableArray<Task *> *) getInprogress{
    return [self getArr:@"Inprogress"];
}

- (NSMutableArray<Task *> *) getDone{
    return [self getArr:@"Done"];
}


-(NSMutableArray<Task *> *) getArr : (NSString *) ObjectKey{
    NSArray *dataArray = [[NSUserDefaults standardUserDefaults] objectForKey:ObjectKey];

    // Create a mutable array to hold the converted custom objects
    NSMutableArray<Task *> *myCustomArray = [NSMutableArray array];

    // Convert each element of the NSArray to NSData, and then to your custom object
    for (NSData *data in dataArray) {
        Task *obj = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [myCustomArray addObject:obj];
    }
    
    if(myCustomArray == Nil){
        myCustomArray = [NSMutableArray new];
    }
    
    return myCustomArray;
}

- (void) addToTodo : (Task *) task{
    NSMutableArray<Task *> *myCustomArray = [self getArr:@"ToDo"];
    
    [myCustomArray addObject:task];
    [self setToUserDef:@"ToDo" arr:myCustomArray];
}

- (void) addToInprog : (Task *) task{
    NSMutableArray<Task *> *myCustomArray = [self getArr:@"Inprogress"];
    
    [myCustomArray addObject:task];
    
    [self setToUserDef:@"Inprogress" arr:myCustomArray];

}

- (void) addToDone : (Task *) task{
    NSMutableArray<Task *> *myCustomArray = [self getArr:@"Done"];
    
    [myCustomArray addObject:task];
    [self setToUserDef:@"Done" arr:myCustomArray];

}

- (void) setTodo: (NSMutableArray<Task*> *) tasks{
    [self setToUserDef:@"ToDo" arr:tasks];
}

- (void) setInprog: (NSMutableArray<Task*> *) tasks{
    [self setToUserDef:@"Inprogress" arr:tasks];
    
}

- (void) setDone: (NSMutableArray<Task*> *) tasks{
    [self setToUserDef:@"Done" arr:tasks];
}

- (void) setToUserDef: (NSString* ) objectKey arr: (NSArray*) arr{
    NSMutableArray *dataArrayMales = [NSMutableArray array];
    for (Task *obj in arr) {
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:obj];
        [dataArrayMales addObject:data];
    }
    [[NSUserDefaults standardUserDefaults] setObject:dataArrayMales forKey:objectKey];
}
@end
