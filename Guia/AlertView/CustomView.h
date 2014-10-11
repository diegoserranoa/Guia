//
//  CustomView.h
//  Guia
//
//  Created by Diego Serrano on 10/10/14.
//  Copyright (c) 2014 Diego Serrano. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CXCardView/CXCardView.h>
#import <Parse/Parse.h>

@class CustomView;
typedef void(^ActionHandler)(CustomView *view);

@interface CustomView : UIView

@property (nonatomic, copy) ActionHandler dismissHandler;

+(CustomView *)defaultView;
+(CustomView *)defaultViewWithDescription:(NSString *)description;
+(CustomView *)defaultViewWithError:(NSError *)error;

@end
