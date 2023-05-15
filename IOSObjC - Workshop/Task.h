//
//  Task.h
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Task : NSObject<NSCoding,NSSecureCoding>

@property NSString *name;
@property NSString *desc;
@property int priority;
@property int status;
@property NSDate *date;


@end

NS_ASSUME_NONNULL_END
