//
//  AddTaskViewController.m
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import "AddTaskViewController.h"
#import "Task.h"
#import "UserDefaultsManager.h"

@interface AddTaskViewController (){
    @public
    Task *task;
    UserDefaultsManager *pref;
    NSMutableArray<Task *> *todoList;
}

@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *desc;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;

@property (weak, nonatomic) IBOutlet UIDatePicker *date;

@end

@implementation AddTaskViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    task = [Task new];
    todoList = [NSMutableArray new];
    
    pref = [UserDefaultsManager new];
    
}

- (void)viewWillAppear:(BOOL)animated{
    todoList = [pref getTodo];
    _date.minimumDate = [NSDate new];
}

- (IBAction)addTask:(id)sender {
    
    
    if(![_name.text isEqual:@""]){

        task.name = _name.text;
        task.desc = _desc.text;
        
        task.priority = [_priority selectedSegmentIndex];
        
        task.status = 0;
        
        task.date = _date.date;
        
        [todoList addObject:task];
        
        [pref setTodo:todoList];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        [self showAlert:@"Name is Empty"];
    }
    
}

- (IBAction)back:(id)sender {
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(void)showAlert: (NSString *) message{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    
    UIAlertAction * ok =[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:ok];
    
    [self presentViewController:alert animated:YES completion:NULL];
}


-(void)showSaveAlert: (NSString *) message{
    UIAlertController * alert =[UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction * save = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [self->todoList addObject:self->task];
        
        [self->pref setTodo:self->todoList];
        
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:save];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:NULL];
}
    


@end
