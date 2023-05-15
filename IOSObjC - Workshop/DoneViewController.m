//
//  DoneViewController.m
//  IOSObjC - Workshop
//
//  Created by Moaz Khaled on 27/04/2023.
//

#import "DoneViewController.h"
#import "DetailsViewController.h"
#import "EditViewController.h"

@interface DoneViewController (){
    BOOL isFiltered;
    NSMutableArray<Task*> *lowPriority;
    NSMutableArray<Task*> *mediumPriority;
    NSMutableArray<Task*> *highPriority;
    
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *filterBtn;

@end

@implementation DoneViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [_tableView setDelegate:self];
    [_tableView setDataSource:self];
    
    [self.navigationController setNavigationBarHidden:YES];
    
    _doneTasks = [NSMutableArray new];
    _pref = [UserDefaultsManager new];
    
    
}

- (void)viewWillAppear:(BOOL)animated{
    _doneTasks = [_pref getDone];
    
    [self filterToMiniArrays];
    
    [_tableView reloadData];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if(isFiltered)
        return 3;
    return 1;
}



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(!isFiltered)
        return _doneTasks.count;
    
    printf("low: %d, ", lowPriority.count);
    switch(section){
        case 0:
            return [lowPriority count];
        case 1:
            return [mediumPriority count];
        default:
            return [highPriority count];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
        
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    
    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"mycell"];
    
    Task *t =_doneTasks[indexPath.row];
    
    if(!isFiltered){
        
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
    }
    else{
        switch(indexPath.section){
            case 0:
                cell.textLabel.text = [lowPriority objectAtIndex:indexPath.row].name;
                cell.detailTextLabel.text = [lowPriority objectAtIndex:indexPath.row].desc;
                cell.imageView.image = [UIImage imageNamed:@"3"];
                break;
            case 1:
                cell.textLabel.text = [mediumPriority objectAtIndex:indexPath.row].name;
                cell.detailTextLabel.text = [mediumPriority objectAtIndex:indexPath.row].desc;
                cell.imageView.image = [UIImage imageNamed:@"2"];
                break;
            case 2:
                cell.textLabel.text = [highPriority objectAtIndex:indexPath.row].name;
                cell.detailTextLabel.text = [highPriority objectAtIndex:indexPath.row].desc;
                cell.imageView.image = [UIImage imageNamed:@"1"];
                break;
        }
        
    }

    return cell;
}
    

-(NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    int globalTaskIndex;
    if(isFiltered){
        Task *currentTask;
        switch(indexPath.section){
            case 0:
                currentTask = [lowPriority objectAtIndex:indexPath.row];
                globalTaskIndex = [_doneTasks indexOfObject:currentTask];
                break;
            case 1:
                currentTask = [mediumPriority objectAtIndex:indexPath.row];
                globalTaskIndex = [_doneTasks indexOfObject:currentTask];
                break;
            case 2:
                currentTask = [highPriority objectAtIndex:indexPath.row];
                globalTaskIndex = [_doneTasks indexOfObject:currentTask];
                break;
        }
        
    }else{
        globalTaskIndex = indexPath.row;
    }
    
    UITableViewRowAction *editAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Edit" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
       //insert your editAction here
        EditViewController * sec=[self.storyboard instantiateViewControllerWithIdentifier:@"editTask"];
        
        sec.taskIndex = globalTaskIndex;
        Task *t = [_doneTasks objectAtIndex:globalTaskIndex];
        sec.taskStatus = t.status;
        
        [self.navigationController pushViewController:sec animated:YES];
    }];
    
    editAction.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"Delete"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
       //insert your deleteAction here
        
//        [_inprogressTasks removeObjectAtIndex:indexPath.row];
//
//        [_pref setInprog:_inprogressTasks];
//
//        self.tableView.reloadData;
        
        
        
                    
        [_doneTasks removeObjectAtIndex:globalTaskIndex];

        [_pref setDone:_doneTasks];
    
        [self filterToMiniArrays];
        
        [_tableView reloadData];
    }];
    
    deleteAction.backgroundColor = [UIColor redColor];
    return @[deleteAction,editAction];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsViewController *sec = [self.storyboard instantiateViewControllerWithIdentifier:@"details"];
    
    int globalTaskIndex;
    if(isFiltered){
        Task *currentTask;
        switch(indexPath.section){
            case 0:
                currentTask = [lowPriority objectAtIndex:indexPath.row];
                globalTaskIndex = [_doneTasks indexOfObject:currentTask];
                break;
            case 1:
                currentTask = [mediumPriority objectAtIndex:indexPath.row];
                globalTaskIndex = [_doneTasks indexOfObject:currentTask];
                break;
            case 2:
                currentTask = [highPriority objectAtIndex:indexPath.row];
                globalTaskIndex = [_doneTasks indexOfObject:currentTask];
                break;
        }
        
    }else{
        globalTaskIndex = indexPath.row;
    }
    
    sec.taskIndex = globalTaskIndex;
    Task *t = [_doneTasks objectAtIndex:globalTaskIndex];
    sec.taskStatus = t.status;
    
    
    [self.navigationController pushViewController:sec animated:YES];
}




- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(isFiltered){
        if(section == 0)
        {
            return @"Low";
        }
        else if (section == 1){
            return @"Medium";
        }
        else if (section == 2){
            return @"High";
        }
    }

    return @"";
}

-(void) filterToMiniArrays{
    lowPriority = [NSMutableArray new];
    mediumPriority = [NSMutableArray new];
    highPriority = [NSMutableArray new];
      
    for(int i=0 ;i <_doneTasks.count; i++){
        Task *t = [_doneTasks objectAtIndex:i];
        switch(t.priority){
            case 0:
                [lowPriority addObject:t];
                break;
            case 1:
                [mediumPriority addObject:t];
                break;
            case 2:
                [highPriority addObject:t];
                break;
        }
    }
}
- (IBAction)filter:(id)sender {
    [_filterBtn setSelected:!isFiltered];
    isFiltered = !isFiltered;
    
    [_tableView reloadData];
}

@end
