//
//  CustomView.m
//  Guia
//
//  Created by Diego Serrano on 10/10/14.
//  Copyright (c) 2014 Diego Serrano. All rights reserved.
//

#import "CustomView.h"

@interface CustomView (){
    UIView *_backgroundView;
    UIButton *_dismissButton;
    UILabel *_description;
}

- (void)setup;
- (void)dismissButtonPressed:(UIButton *)button;

@end

@implementation CustomView

- (id)init
{
    self = [super init];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithDescription:(NSString *)description
{
    self = [super init];
    if (self) {
        [self setupWithDescription:description];
    }
    return self;
}

- (id)initWithError:(NSError *)error
{
    self = [super init];
    if (self) {
        [self setupWithDescription:[self getStringForError:error]];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _backgroundView.frame = self.bounds;
}

#pragma mark -
+ (CustomView *)defaultView
{
    CustomView *view = [[CustomView alloc] init];
    view.frame = CGRectMake( 0, 0, 300, 150);
    
    return view;
}

+ (CustomView *)defaultViewWithDescription:(NSString *)description
{
    CustomView *view = [[CustomView alloc] initWithDescription:description];
    view.frame = CGRectMake( 0, 0, 300, 150);
    
    [view setDismissHandler:^(CustomView *view){[CXCardView dismissCurrent];}];
    
    return view;
}

+ (CustomView *)defaultViewWithError:(NSError *)error
{
    CustomView *view = [[CustomView alloc] initWithError:error];
    view.frame = CGRectMake( 0, 0, 300, 150);
    
    [view setDismissHandler:^(CustomView *view){[CXCardView dismissCurrent];}];
    
    return view;
}

#pragma mark -
- (void)setup
{
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.cornerRadius = 2.;
    self.layer.masksToBounds = NO;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(0.0, 1.);
    self.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.layer.shadowRadius = 2.;
    
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.alpha = 0.8;
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backgroundView];
    
    _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dismissButton.frame = CGRectMake(0, 150 - 44, 300, 44);
    _dismissButton.backgroundColor = [[UINavigationBar appearance] barTintColor];
    [_dismissButton addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_dismissButton setTitle:@"OK" forState:UIControlStateNormal];
    [_dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dismissButton setTitleColor:[UIColor colorWithRed:0.431 green:0.706 blue:0.992 alpha:1.000] forState:UIControlStateHighlighted];
    [self addSubview:_dismissButton];
}

- (void)setupWithDescription:(NSString *)description
{
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.cornerRadius = 2.;
    self.layer.masksToBounds = NO;
    self.layer.shadowOpacity = 0.5;
    self.layer.shadowOffset = CGSizeMake(0.0, 1.);
    self.layer.shadowColor = [UIColor whiteColor].CGColor;
    self.layer.shadowRadius = 2.;
    
    _backgroundView = [[UIView alloc] initWithFrame:self.bounds];
    _backgroundView.alpha = 0.8;
    _backgroundView.backgroundColor = [UIColor whiteColor];
    [self addSubview:_backgroundView];
    
    _description = [[UILabel alloc] init];
    _description.frame = CGRectMake(20, 8, 260, 100);
    _description.numberOfLines = 0.;
    _description.textAlignment = NSTextAlignmentLeft;
    _description.backgroundColor = [UIColor clearColor];
    _description.textColor = [UIColor blackColor];
    _description.font = [UIFont fontWithName:@"Avenir-Roman" size:14.];
    _description.text = description;
    [self addSubview:_description];
    
    
    _dismissButton = [UIButton buttonWithType:UIButtonTypeCustom];
    _dismissButton.frame = CGRectMake(0, 150 - 44, 300, 44);
    _dismissButton.backgroundColor = [[UINavigationBar appearance] barTintColor];
    [_dismissButton addTarget:self action:@selector(dismissButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    [_dismissButton setTitle:@"OK" forState:UIControlStateNormal];
    [_dismissButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_dismissButton setTitleColor:[UIColor colorWithRed:0.431 green:0.706 blue:0.992 alpha:1.000] forState:UIControlStateHighlighted];
    [self addSubview:_dismissButton];
}

//Actions
- (void)dismissButtonPressed:(UIButton *)button
{
    if (self.dismissHandler) {
        self.dismissHandler(self);
    }
}

// Parse errors
- (NSString *)getStringForError:(NSError *)error
{
    // Parse errors.
    if (error.code == kPFErrorInvalidEmailAddress) {
        // 125: The email address was invalid.
        return NSLocalizedString(@"Cuenta de correo invalida", nil);
    } else if (error.code == kPFErrorConnectionFailed) {
        // 100: The connection to the Parse servers failed.
        return NSLocalizedString(@"Error de conexion", nil);
    } else if (error.code == kPFErrorInternalServer){
        // 1: Internal server error. No information available.
        return NSLocalizedString(@"Error en el servidor", nil);
    } else if (error.code == kPFErrorTimeout){
        // 124: The request timed out on the server. Typically this indicates the request is too expensive.
        return NSLocalizedString(@"Error de timeout", nil);
    } else if (error.code == kPFErrorUserEmailMissing){
        // 204: The email is missing, and must be specified
        return NSLocalizedString(@"Introduzca un correo valido", nil);
    } else if (error.code == kPFErrorUserEmailTaken) {
        // 203: Email has already been taken
        return NSLocalizedString(@"Ya existe una cuenta con este correo", nil);
    } else if (error.code == kPFErrorUsernameMissing){
        // 200: Username is missing or empty
        return NSLocalizedString(@"Introduzca nombre de usuario", nil);
    } else if (error.code == kPFErrorUsernameTaken){
        // 202: Username has already been taken
        return NSLocalizedString(@"Ya existe una cuenta con este nombre de usuario", nil);
    } else if (error.code == kPFErrorUserPasswordMissing){
        // 201: Password is missing or empty
        return NSLocalizedString(@"Introduzca una contrasena valida", nil);
    } else if (error.code == kPFErrorUserWithEmailNotFound){
        // 205: A user with the specified email was not found
        return NSLocalizedString(@"Usuario no encontrado", nil);
    } else if (error.code == kPFErrorObjectNotFound){
        // 101: Object doesn't exist, or has an incorrect password.
        return NSLocalizedString(@"Usuario no existe o contrasena incorrecta", nil);
    }
    // default
    return NSLocalizedString(@"Error en la aplicacion", nil);
}

@end

