//
//  InprogressViewController.h
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 27/04/2023.
//

#import <UIKit/UIKit.h>
#import "UserDefaultsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface InprogressViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property NSMutableArray *inprogressTasks;
@property UserDefaultsManager *pref;

@end

NS_ASSUME_NONNULL_END
