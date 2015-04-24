//
//  SessionsTableViewController.m
//  Neuroplasticity
//
//  Created by David Monson on 4/10/15.
//  Copyright (c) 2015 David Monson. All rights reserved.
//

#import "PlaylistsTableViewController.h"
#import "ExercisePlaylistTableViewController.h"
#import "PlaylistsController.h"
#import "CustomLoginViewController.h"
#import "CustomSignUpViewController.h"
#import <Parse/Parse.h>
#import <ParseUI/ParseUI.h>


@interface PlaylistsTableViewController () <PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>

@property (nonatomic, strong) NSMutableArray *playlistsArray;

@end

@implementation PlaylistsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Playlists";
    
    if (![PFUser currentUser]) { // No user logged in
        // Create the log in view controller
        CustomLoginViewController *logInViewController = [[CustomLoginViewController alloc] init];
        [logInViewController setDelegate:self]; // Set ourselves as the delegate
        
        
        // Create the sign up view controller
        CustomSignUpViewController *signUpViewController = [[CustomSignUpViewController alloc] init];
        [signUpViewController setDelegate:self]; // Set ourselves as the delegate
        
        // Assign our sign up controller to be displayed from the login controller
        [logInViewController setSignUpController:signUpViewController];

        // Present the log in view controller
        [self.navigationController presentViewController:logInViewController animated:NO completion:NULL];
        
    } else {
    [[PlaylistsController sharedInstance] queryForPlaylistsWithCompletion:^(BOOL completion) {
        self.playlistsArray = [[NSMutableArray alloc] initWithArray:[PlaylistsController sharedInstance].playlistArray];
        [self.tableView reloadData];
    }];
    }
    
    self.tableView.allowsMultipleSelectionDuringEditing = NO;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
//-(BOOL)shouldAutorotate {
//    return NO;
//}

-(void)viewDidAppear:(BOOL)animated {
    [self.tableView reloadData];
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return YES if you want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        PFObject *deleteObject = [self.playlistsArray objectAtIndex:indexPath.row];
        [[PlaylistsController sharedInstance] deletePlaylist:deleteObject];
        [self.playlistsArray removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    }
}

- (IBAction)addPlaylistButtonTapped:(id)sender {
    [[PlaylistsController sharedInstance] createNewPlaylist];
    [[PlaylistsController sharedInstance] queryForPlaylistsWithCompletion:^(BOOL completion) {
        self.playlistsArray = [[NSMutableArray alloc] initWithArray:[PlaylistsController sharedInstance].playlistArray];
        [self.tableView reloadData];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.playlistsArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        
    NSString *playlistName = self.playlistsArray[indexPath.row][@"name"];
    NSString *playlistCreationDate = self.playlistsArray[indexPath.row][@"dateCreated"];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@ %@",playlistName ,playlistCreationDate];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.backgroundColor = [UIColor colorWithRed:(25.0/255.0) green:(157.0/255.0) blue:(243.0/255.0) alpha:1];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.textLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:self.view.frame.size.height / 20];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self performSegueWithIdentifier:@"showExercises" sender:[tableView cellForRowAtIndexPath:indexPath]];
    [PlaylistsController sharedInstance].object = self.playlistsArray[indexPath.row];
    [PlaylistsController sharedInstance].exercisesArray = [PlaylistsController sharedInstance].object[@"playlistArray"];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.view.frame.size.height / 8;
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

#pragma mark - login/signup

- (BOOL)logInViewController:(PFLogInViewController *)logInController shouldBeginLogInWithUsername:(NSString *)username password:(NSString *)password {
    // Check if both fields are completed
    if (username && password && username.length != 0 && password.length != 0) {
        return YES; // Begin login process
    }
    
    [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                message:@"Make sure you fill out all of the information!"
                               delegate:nil
                      cancelButtonTitle:@"ok"
                      otherButtonTitles:nil] show];
    return NO; // Interrupt login process
}

// Sent to the delegate when a PFUser is logged in.
- (void)logInViewController:(PFLogInViewController *)logInController didLogInUser:(PFUser *)user {
    [[PlaylistsController sharedInstance] queryForPlaylistsWithCompletion:^(BOOL completion) {
        self.playlistsArray = [[NSMutableArray alloc] initWithArray:[PlaylistsController sharedInstance].playlistArray];
        [self.tableView reloadData];
    }];
    [self dismissViewControllerAnimated:YES completion:NULL];

}

// Sent to the delegate when the log in attempt fails.
- (void)logInViewController:(PFLogInViewController *)logInController didFailToLogInWithError:(NSError *)error {
    NSLog(@"Failed to log in...");
}

// Sent to the delegate when the log in screen is dismissed.
- (void)logInViewControllerDidCancelLogIn:(PFLogInViewController *)logInController {
    [self.navigationController popViewControllerAnimated:YES];
}

// Sent to the delegate to determine whether the sign up request should be submitted to the server.
- (BOOL)signUpViewController:(PFSignUpViewController *)signUpController shouldBeginSignUp:(NSDictionary *)info {
    BOOL informationComplete = YES;
    
    // loop through all of the submitted data
    for (id key in info) {
        NSString *field = [info objectForKey:key];
        if (!field || field.length == 0) { // check completion
            informationComplete = NO;
            break;
        }
    }
    
    // Display an alert if a field wasn't completed
    if (!informationComplete) {
        [[[UIAlertView alloc] initWithTitle:@"Missing Information"
                                    message:@"Make sure you fill out all of the information!"
                                   delegate:nil
                          cancelButtonTitle:@"ok"
                          otherButtonTitles:nil] show];
    }
    
    return informationComplete;
}

// Sent to the delegate when a PFUser is signed up.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didSignUpUser:(PFUser *)user {
    [self dismissViewControllerAnimated:YES completion:nil]; // Dismiss the PFSignUpViewController
}

// Sent to the delegate when the sign up attempt fails.
- (void)signUpViewController:(PFSignUpViewController *)signUpController didFailToSignUpWithError:(NSError *)error {
    NSLog(@"Failed to sign up...");
}

// Sent to the delegate when the sign up screen is dismissed.
- (void)signUpViewControllerDidCancelSignUp:(PFSignUpViewController *)signUpController {
    NSLog(@"User dismissed the signUpViewController");
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([segue.identifier isEqualToString:@"showExercises"]) {
        ExercisePlaylistTableViewController *viewController = [segue destinationViewController];
        
        viewController.titleLabel = [[sender textLabel] text];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        viewController.selectedPlaylistObject = self.playlistsArray[indexPath.row];
    }

}
@end
