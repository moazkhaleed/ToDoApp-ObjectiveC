//
//  TodoViewController.h
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import <UIKit/UIKit.h>
#import "UserDefaultsManager.h"

NS_ASSUME_NONNULL_BEGIN

@interface TodoViewController : UIViewController<UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>

@property NSMutableArray *todoTasks;
@property UserDefaultsManager *pref;

@end

NS_ASSUME_NONNULL_END
