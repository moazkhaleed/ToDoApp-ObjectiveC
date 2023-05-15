//
//  Task.m
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import "Task.h"

@implementation Task

- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _desc = [coder decodeObjectForKey:@"desc"];
        _priority = [coder decodeIntegerForKey:@"priority"];
        _status = [coder decodeIntegerForKey:@"status"];
        _date = [coder decodeObjectForKey:@"date"];

    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_desc forKey:@"desc"];
    [coder encodeInt:_priority forKey:@"priority"];
    [coder encodeInt:_status forKey:@"status"];
    [coder encodeObject:_date forKey:@"date"];
    
}

+ (BOOL)supportsSecureCoding{
    return YES;
}



@end
