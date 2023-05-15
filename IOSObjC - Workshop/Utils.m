//
//  Utils.m
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import "Utils.h"

@implementation Utils
-(void)showSaveAlert: (NSString *) message{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * save = [UIAlertAction actionWithTitle:@"Sava" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [self saveColleague];
    }];
    
    UIAlertAction * cancel =[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:save];
    [alert addAction:cancel];
    
//    [self presentViewController:alert animated:YES completion:NULL];
}

@end
