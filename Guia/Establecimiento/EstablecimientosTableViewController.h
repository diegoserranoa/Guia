//
//  EstablecimientosTableViewController.h
//  Guia
//
//  Created by Diego Serrano on 10/10/14.
//  Copyright (c) 2014 Diego Serrano. All rights reserved.
//

#import <Parse/Parse.h>

@interface EstablecimientosTableViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) PFObject *ciudad;

@end
