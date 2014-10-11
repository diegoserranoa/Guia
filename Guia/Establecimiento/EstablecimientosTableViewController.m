//
//  EstablecimientosTableViewController.m
//  Guia
//
//  Created by Diego Serrano on 10/10/14.
//  Copyright (c) 2014 Diego Serrano. All rights reserved.
//

#import "EstablecimientosTableViewController.h"
#import "EstablecimientoTableViewCell.h"

@interface EstablecimientosTableViewController (){
    NSArray *tipos;
}

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (strong, nonatomic) NSString *tipoSeleccionado;

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
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(PFQuery *)queryForTable
{
    PFQuery *query = [PFQuery queryWithClassName:@"Sucursal"];
    
    [query whereKey:@"ciudad" equalTo:self.ciudad];
    [query includeKey:@"establecimiento"];
    
    query.cachePolicy = kPFCachePolicyCacheElseNetwork;

    return query;
}

-(void)objectsDidLoad:(NSError *)error
{
    [super objectsDidLoad:error];
    if (error) {
        // mostrar error
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

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath object:(PFObject *)object
{
    
    EstablecimientoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"establecimientoCell"];
    
    cell.titulo.text = object[@"establecimiento"][@"nombre"];
    
    return cell;
}
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
