//
//  ViewController.m
//  note
//
//  Created by  李俊 on 15/6/2.
//  Copyright (c) 2015年  李俊. All rights reserved.
//

#import "ViewController.h"
#import "NoteViewController.h"
#import "Note.h"
#import "AddNoteViewController.h"
#import "NoteTableViewCell.h"
#import "FMMoveTableView.h"
#import "FMMoveTableViewCell.h"


@interface ViewController ()<FMMoveTableViewDataSource,FMMoveTableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *addNote;

@property (strong, nonatomic) NoteTableViewCell *cell;

@property (strong, nonatomic) NSMutableArray *notes;


@end

@implementation ViewController

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
    if (self.notes.count > 0) {
    
        Note *note = self.notes[0];
    
        if (note.text.length == 0) {
            [self.notes removeObjectAtIndex:0];
        }
    }
    
    [self.tableView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIColor *color = [UIColor colorWithRed:18/255.0 green:136/255.0 blue:97/255.0 alpha:1];
    
    self.notes = [NSMutableArray array];
    NSString *filePath = [self dataFilePath];
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array = [NSArray arrayWithContentsOfFile:filePath];
        self.notes = [Note modelToArray:array];
    }
    
    [self.navigationController.navigationBar setBarTintColor:color];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    UIApplication *app = [UIApplication sharedApplication];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:) name:UIApplicationWillResignActiveNotification object:app];
    
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    self.tableView.estimatedRowHeight = 44;
    
    // 修改导航栏标题的颜色
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                   [UIColor whiteColor],NSForegroundColorAttributeName, nil];
    
    
}


- (void)applicationWillResignActive:(NSNotification *)notification{
    
    NSString *filePath = [self dataFilePath];
    NSMutableArray *temArray = [NSMutableArray array ];
    for (int i = 0; i < self.notes.count; i++) {
        Note *note = self.notes[i];
        NSDictionary *tempDic = @{@"text":note.text};
        [temArray addObject:tempDic];
        
    }
    
    NSArray *array = temArray;
    [array writeToFile:filePath atomically:YES];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.notes.count;
}

- (NoteTableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoteTableViewCell *cell = [NoteTableViewCell noteCellWith:tableView];
   
    Note *note = self.notes[indexPath.row];
    
    cell.note = note;
   
    return cell;
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"真的要删除" message:@"删除后将不可恢复" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancle = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *ture = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [self.notes removeObjectAtIndex:indexPath.row];
            [self.tableView reloadData];
        }];
        
        [alert addAction:cancle];
        [alert addAction:ture];
        
        [self presentViewController:alert animated:YES completion:nil];
       
     
    }
    
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NoteViewController *noteViewController = [[NoteViewController alloc] init];
    
    noteViewController.note = self.notes[indexPath.row];
    
    [self.navigationController pushViewController:noteViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    AddNoteViewController *addNoteVC = segue.destinationViewController;
    
    addNoteVC.note = [[Note alloc] init];
    
    
    [self.notes insertObject:addNoteVC.note atIndex:0];
    
}

- (BOOL)moveTableView:(FMMoveTableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return YES;
}

- (void)moveTableView:(FMMoveTableView *)tableView moveRowFromIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath{
    
    Note *note = self.notes[fromIndexPath.row];
    
    [self.notes removeObjectAtIndex:fromIndexPath.row];
    
    [self.notes insertObject:note atIndex:toIndexPath.row];
    
    [self.tableView reloadData];
}


- (NSString *)dataFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentationDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingString:@"data.plist"];
    
}


@end
