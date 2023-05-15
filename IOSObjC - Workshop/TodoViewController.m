//
//  TodoViewController.m
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 26/04/2023.
//

#import "TodoViewController.h"
#import "AddTaskViewController.h"
#import "DetailsViewController.h"
#import "EditViewController.h"

@interface TodoViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;


@property BOOL isSearch;
@property NSMutableArray *filterArr;

@end

@implementation TodoViewController

//-(void)navToAddScreen{

//    AddTaskViewController * addScreen =[self.storyboard instantiateViewControllerWithIdentifier:@"addTask"];

//    [self.navigationController pushViewController:addScreen animated:YES];
//}

- (IBAction)add:(id)sender {
    AddTaskViewController * addScreen =[self.storyboard instantiateViewControllerWithIdentifier:@"addTask"];
    [self.navigationController pushViewController:addScreen animated:YES];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length == 0) {
        self.isSearch = false;
    } else {
        self.isSearch = true;
        [self.filterArr removeAllObjects];
        for (Task *task in _todoTasks) {
            NSRange range = [task.name rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [self.filterArr addObject:task];
            }
        }
    }
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    _isSearch = NO;
    self.filterArr = [NSMutableArray new];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    
    _todoTasks = [NSMutableArray new];
    _pref = [UserDefaultsManager new];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    _todoTasks = [_pref getTodo];
    [_tableView reloadData];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(_isSearch){
        return _filterArr.count;
    }else{
        return _todoTasks.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
        
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mycell"];
    
    Task *t;
    if(_isSearch){
        t =_filterArr[indexPath.row];
    }else{
       t =_todoTasks[indexPath.row];
    }
    
    
    cell.textLabel.text = t.name;
    cell.detailTextLabel.text = t.desc;
    
    switch (t.priority) {
        case 0:
            [cell.imageView setImage:[UIImage imageNamed:@"3"]];
            break;
        case 1:
           [cell.imageView setImage:[UIImage imageNamed:@"2"]];
            break;
        case 2:
           [cell.imageView setImage:[UIImage imageNamed:@"1"]];
            break;
        default:
            break;
    }

        return cell;
}
    

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
       //insert your editAction here
//        EditViewController * sec=[self.storyboard instantiateViewControllerWithIdentifier:@"editTask"];
//
//        sec.taskIndex = indexPath.row;
//        Task *t = [_todoTasks objectAtIndex:indexPath.row];
//        sec.taskStatus = t.status;
//
//        [self.navigationController pushViewController:sec animated:YES];
        
        
        _searchBar.text=@"";
        EditViewController *sec = [self.storyboard instantiateViewControllerWithIdentifier:@"editTask"];
                if(_isSearch){
                    int i=[self->_todoTasks  indexOfObject:self->_filterArr[indexPath.row]];
                    Task *task=self->_todoTasks[i];
                    _isSearch=false;
//                    sec.task=[_filterArr objectAtIndex:indexPath.row];
                    sec.taskIndex=i;
                }
                else{
                    sec.taskIndex = indexPath.row;
                }
                sec.taskStatus = 0;
                [self.navigationController pushViewController:sec animated:YES];
        
        
        
    }];
    
    editAction.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
       //insert your deleteAction here
        
        _searchBar.text=@"";
        if(self->_isSearch){
            int i = [self->_todoTasks  indexOfObject:self->_filterArr[indexPath.row]];
            Task *task = self->_todoTasks[i];
            [self->_todoTasks removeObject:task];
            _isSearch=false;
            [_pref setTodo:_todoTasks];
            self.todoTasks=[_pref getTodo];

            self.tableView.reloadData;
            
        }
        else{
            [_todoTasks removeObjectAtIndex:indexPath.row];
            
            [_pref setTodo:_todoTasks];
            
            self.tableView.reloadData;
        }
        
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction,editAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *sec = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    
    sec.taskIndex = indexPath.row;
    Task *t = [_todoTasks objectAtIndex:indexPath.row];
    sec.taskStatus = t.status;
    
    
    [self.navigationController pushViewController:sec animated:YES];
}

@end
