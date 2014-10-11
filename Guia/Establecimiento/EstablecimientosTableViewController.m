//
//  EstablecimientosTableViewController.m
//  Guia
//
//  Created by Diego Serrano on 10/10/14.
//  Copyright (c) 2014 Diego Serrano. All rights reserved.
//

#import "EstablecimientosTableViewController.h"
#import "EstablecimientoTableViewCell.h"
#import "DetalleViewController.h"

@interface EstablecimientosTableViewController (){
    NSArray *tipos;
}

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) NSString *tipoSeleccionado;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *objects;

@end

@implementation EstablecimientosTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    tipos = @[
              @"Top10",
              @"Restaurante",
              @"Entretenimiento",
              ];
    self.tipoSeleccionado = @"Top10";
    [self loadObjects];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)loadObjects
{
    if ([self.tipoSeleccionado isEqualToString:@"Top10"]) {
        PFQuery *querySucursal = [PFQuery queryWithClassName:@"Sucursal"];
        [querySucursal whereKey:@"ciudad" equalTo:self.ciudad];
        [querySucursal includeKey:@"establecimiento"];
        [querySucursal setLimit:10];
        [querySucursal orderByAscending:@"rating"];
        [querySucursal findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                self.objects = [NSArray arrayWithArray:objects];
                [self.tableView reloadData];
            }
        }];
    } else {
        PFQuery *queryEstablecimiento = [PFQuery queryWithClassName:@"Establecimiento"];
        [queryEstablecimiento whereKey:@"tipo" equalTo:@"Comida"];
        [queryEstablecimiento findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                PFQuery *querySucursal = [PFQuery queryWithClassName:@"Sucursal"];
                [querySucursal whereKey:@"ciudad" equalTo:self.ciudad];
                [querySucursal whereKey:@"establecimiento" containedIn:objects];
                [querySucursal includeKey:@"establecimiento"];
                [querySucursal findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
                    if (!error) {
                        self.objects = [NSArray arrayWithArray:objects];
                        [self.tableView reloadData];
                    }
                }];
            }
        }];
    }
}

#pragma mark - Table view data source

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.objects.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    EstablecimientoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"establecimientoCell"];
    PFObject *object = [self.objects objectAtIndex:indexPath.row];
    cell.titulo.text = object[@"establecimiento"][@"nombre"];
    
    return cell;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"detalleSegue"]) {
        DetalleViewController *dvc = [segue destinationViewController];
        dvc.sucursal = [self.objects objectAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
}

@end
