//
//  ExercisePresetsTableViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "ExercisePresetsTableViewController.h"
#import "ExercisePresetsController.h"
#import "PlaylistsController.h"
#import <Parse/Parse.h>

@interface ExercisePresetsTableViewController ()

@property (nonatomic, strong) NSDictionary *activitiesDictionary;
@property (nonatomic, strong) NSString *sectionTitle;
@property (nonatomic, strong) NSString *indexSection;


@end

@implementation ExercisePresetsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[ExercisePresetsController sharedInstance]  queryForPresetExercisesWithCompletion:^(BOOL completion) {
        self.activitiesDictionary  = [[NSDictionary alloc]initWithDictionary:[ExercisePresetsController sharedInstance].presetsDictionary];
        [self.tableView reloadData];
    }];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
   
    return self.activitiesDictionary.count;

}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.

    return [self.activitiesDictionary[@"pursuits"] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        self.sectionTitle = @"pursuits";
    } else if (indexPath.section == 1) {
        self.sectionTitle = @"OPK";
    }else if (indexPath.section == 2) {
        self.sectionTitle = @"hemistim";
    }else if (indexPath.section == 3) {
        self.sectionTitle = @"cartesianCross";
    }

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text =[NSString stringWithFormat:@"%@",self.activitiesDictionary[self.sectionTitle][indexPath.row][@"identifier"]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        self.indexSection = @"pursuits";
    } else if (indexPath.section == 1) {
        self.indexSection = @"OPK";
    }else if (indexPath.section == 2) {
        self.indexSection = @"hemistim";
    }else if (indexPath.section == 3) {
        self.indexSection = @"cartesianCross";
    }
    
    [[PlaylistsController sharedInstance] addExerciseToPlaylist:self.activitiesDictionary[self.indexSection][indexPath.row]];
    NSLog(@"Exercise Added %@", self.activitiesDictionary[self.indexSection][indexPath.row]);
    [self.navigationController popViewControllerAnimated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
