//
//  EditViewController.m
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import "EditViewController.h"
#import "UserDefaultsManager.h"
#import "Task.h"

@interface EditViewController (){
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

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tasks = [NSMutableArray new];
    
    pref = [UserDefaultsManager new];
//    _date.minimumDate = [NSDate new];
    
}

- (void)viewWillAppear:(BOOL)animated{
    switch (_taskStatus) {
        case 0:
            tasks = [pref getTodo];
            break;
        case 1:
            tasks = [pref getInprogress];
            [_status setEnabled:NO forSegmentAtIndex:0];
            break;
        case 2:
            tasks = [pref getDone];
            [_status setEnabled:NO forSegmentAtIndex:0];
            [_status setEnabled:NO forSegmentAtIndex:1];
            break;
        default:
            break;
    }
    _name.text =[tasks[_taskIndex] name];
    _desc.text = [tasks[_taskIndex] desc];
    
    _priority.selectedSegmentIndex = [tasks[_taskIndex] priority];
    _status.selectedSegmentIndex = [tasks[_taskIndex] status];
    
    _date.date = [tasks[_taskIndex] date];
    
}

- (IBAction)editTask:(id)sender {
    if(![_name.text isEqual:@""]){
        
        Task *newTask=[Task new];
        newTask.name = _name.text;
        newTask.desc = _desc.text;
        newTask.priority = [_priority selectedSegmentIndex];
        newTask.status = [_status selectedSegmentIndex];
        newTask.date = _date.date;
        
        
        
        NSMutableArray * arr;
        
        switch (_taskStatus) {
            case 0:
                arr = [pref getTodo];
                if(newTask.status ==_taskStatus){
                    [arr replaceObjectAtIndex:_taskIndex withObject:newTask];
                    [pref setTodo:arr];
                }
                else{
                    [arr removeObjectAtIndex:_taskIndex];
                    [pref setTodo:arr];
                    
                    NSMutableArray * arrForAdd;
                    switch (newTask.status) {
                        case 0:
                            arrForAdd = [pref getTodo];
                            
                            if(arrForAdd == nil){
                                NSMutableArray *newArr=[NSMutableArray new];
                                [newArr addObject:newTask];
                                [pref setTodo:newArr];
                            }
                            else{
                                [arrForAdd addObject:newTask];
                                [pref setTodo:arrForAdd];
                            }
                            break;
                        case 1:
                            arrForAdd = [pref getInprogress];
                            
                            if(arrForAdd == nil){
                                NSMutableArray *newArr=[NSMutableArray new];
                                [newArr addObject:newTask];
                                [pref setInprog:newArr];
                            }
                            else{
                                [arrForAdd addObject:newTask];
                                [pref setInprog:arrForAdd];
                            }
                            break;
                        case 2:
                            arrForAdd = [pref getDone];
                            
                            if(arrForAdd == nil){
                                NSMutableArray *newArr=[NSMutableArray new];
                                [newArr addObject:newTask];
                                [pref setDone:newArr];
                            }
                            else{
                                [arrForAdd addObject:newTask];
                                [pref setDone:arrForAdd];
                            }
                            break;
                        default:
                            break;
                    }
                }
                break;
            case 1:
                arr = [pref getInprogress];
                if(newTask.status == _taskStatus){
                    [arr replaceObjectAtIndex:_taskIndex withObject:newTask];
                    [pref setInprog:arr];
                }else{
                    [arr removeObjectAtIndex:_taskIndex];
                    [pref setInprog:arr];
                    
                    NSMutableArray * arrForAdd;
                    switch (newTask.status) {
                        case 0:
                            arrForAdd = [pref getTodo];
                            
                            if(arrForAdd == nil){
                                NSMutableArray *newArr=[NSMutableArray new];
                                [newArr addObject:newTask];
                                [pref setTodo:newArr];
                            }
                            else{
                                [arrForAdd addObject:newTask];
                                [pref setTodo:arrForAdd];
                            }
                            break;
                        case 1:
                            arrForAdd = [pref getInprogress];
                            
                            if(arrForAdd == nil){
                                NSMutableArray *newArr=[NSMutableArray new];
                                [newArr addObject:newTask];
                                [pref setInprog:newArr];
                            }
                            else{
                                [arrForAdd addObject:newTask];
                                [pref setInprog:arrForAdd];
                            }
                            break;
                        case 2:
                            arrForAdd = [pref getDone];
                            
                            if(arrForAdd == nil){
                                NSMutableArray *newArr=[NSMutableArray new];
                                [newArr addObject:newTask];
                                [pref setDone:newArr];
                            }
                            else{
                                [arrForAdd addObject:newTask];
                                [pref setDone:arrForAdd];
                            }
                            break;
                        default:
                            break;
                    }
                }
                break;
            case 2:
                arr = [pref getDone];
                if(newTask.status ==_taskStatus){
                    [arr replaceObjectAtIndex:_taskIndex withObject:newTask];
                    [pref setDone:arr];
                }else{
                    [arr removeObjectAtIndex:_taskIndex];
                    [pref setDone:arr];
                    
                    NSMutableArray * arrForAdd;
                    switch (newTask.status) {
                        case 0:
                            arrForAdd = [pref getTodo];
                            
                            if(arrForAdd == nil){
                                NSMutableArray *newArr=[NSMutableArray new];
                                [newArr addObject:newTask];
                                [pref setTodo:newArr];
                            }
                            else{
                                [arrForAdd addObject:newTask];
                                [pref setTodo:arrForAdd];
                            }
                            break;
                        case 1:
                            arrForAdd = [pref getInprogress];
                            
                            if(arrForAdd == nil){
                                NSMutableArray *newArr=[NSMutableArray new];
                                [newArr addObject:newTask];
                                [pref setInprog:newArr];
                            }
                            else{
                                [arrForAdd addObject:newTask];
                                [pref setInprog:arrForAdd];
                            }
                            break;
                        case 2:
                            arrForAdd = [pref getDone];
                            
                            if(arrForAdd == nil){
                                NSMutableArray *newArr=[NSMutableArray new];
                                [newArr addObject:newTask];
                                [pref setDone:newArr];
                            }
                            else{
                                [arrForAdd addObject:newTask];
                                [pref setDone:arrForAdd];
                            }
                            break;
                        default:
                            break;
                    }
                }
                break;
            default:
                break;
        }
        
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
//        [self->tasks addObject:self->task];
//
//        [self->pref setTodo:self->tasks];
        
    }];
    
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    [alert addAction:save];
    [alert addAction:cancel];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

@end
