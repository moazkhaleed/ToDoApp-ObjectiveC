//
//  DetailsViewController.m
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import "DetailsViewController.h"
#import "Task.h"
#import "UserDefaultsManager.h"

@interface DetailsViewController (){
    @public
    UserDefaultsManager *pref;
    NSMutableArray<Task *> *tasks;
}

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *desc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *status;

@property (weak, nonatomic) IBOutlet UIDatePicker *date;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    tasks = [NSMutableArray new];
    pref = [UserDefaultsManager new];
    
}

- (void)viewWillAppear:(BOOL)animated{
    switch (_taskStatus) {
        case 0:
            tasks = [pref getTodo];
            break;
        case 1:
            tasks = [pref getInprogress];
            break;
        case 2:
            tasks = [pref getDone];
            break;
        default:
            break;
    }
    
    _name.text =[tasks[_taskIndex] name];
    _desc.text = [tasks[_taskIndex] desc];
    _date.date = [tasks[_taskIndex] date];
    _priority.selectedSegmentIndex = [tasks[_taskIndex] priority];
    _status.selectedSegmentIndex = [tasks[_taskIndex] status];
}

- (IBAction)back:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

@end
