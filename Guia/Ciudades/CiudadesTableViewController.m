//
//  CiudadesTableViewController.m
//  Guia
//
//  Created by Diego Serrano on 10/10/14.
//  Copyright (c) 2014 Diego Serrano. All rights reserved.
//

#import "CiudadesTableViewController.h"
#import "CiudadTableViewCell.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import <SDWebImage/UIImageView+WebCache.h>
#import "CustomView.h"
#import <CXCardView/CXCardView.h>
#import "EstablecimientosTableViewController.h"

@interface CiudadesTableViewController ()
@end

@implementation CiudadesTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.clearsSelectionOnViewWillAppear = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Parse query

-(PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:@"Ciudad"];
    
    [query whereKeyExists:@"nombre"];
    
    query.cachePolicy = kPFCachePolicyCacheThenNetwork;
    
    return query;
}

-(void)objectsWillLoad
{
    [super objectsWillLoad];
    
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
}

-(void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (error) {
        [CXCardView showWithView:[CustomView defaultViewWithError:error] draggable:YES];
    }
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.objects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    CiudadTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ciudadCell" forIndexPath:indexPath];
    cell.ciudadLabel.text = [object valueForKey:@"nombre"];
    PFFile *image = [object objectForKey:@"imagen"];
    [cell.ciudadImageView sd_setImageWithURL:[NSURL URLWithString:image.url] placeholderImage:[UIImage imageNamed:[object valueForKey:@"nombre"]]];
    return cell;
    
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

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"establecimientoSegue"]) {
        EstablecimientosTableViewController *etvc = (EstablecimientosTableViewController *)[[(UINavigationController *)[segue destinationViewController] viewControllers] objectAtIndex:0];
        etvc.ciudad = [self.objects objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
