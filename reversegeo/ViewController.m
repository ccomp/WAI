//
//  ViewController.m
//  reversegeo
//
//  Created by Cyron Completo on 4/10/15.
//  Copyright (c) 2015 Cyron Completo. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.latText.delegate = self;
    self.longText.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return true;
}

- (IBAction)submitButtonPressed:(id)sender {
    float lat = [[self.latText text] floatValue];
    float lng = [[self.longText text] floatValue];
    [self addressLocation:lat lng:lng];
}

- (void)addressLocation:(float)lat lng:(float)lng{
    __block NSString *location, *status;
    __block NSArray *locArray = [[NSArray alloc] init];
    NSMutableString *urlString = [NSMutableString stringWithFormat:
          @"https://maps.googleapis.com/maps/api/geocode/json?latlng=%f,%f&sensor=false", lat, lng];
    
    [urlString setString:[urlString stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation
             JSONRequestOperationWithRequest:request success:^(NSURLRequest *request,
               NSHTTPURLResponse *response, id JSON)
    {
        locArray = [JSON objectForKey:@"results"];
        status = [JSON valueForKey:@"status"];
        if ([status isEqualToString:@"OK"]) {
            locArray = [locArray objectAtIndex:0];
            location = [locArray valueForKey:@"formatted_address"];
            self.outputText.text = [NSString stringWithFormat:@"Your location is: \n%@", location];
        } else {
            self.outputText.text = [NSString stringWithFormat:@"Invalid Coordinates.\nPerhaps you are in the ocean?"];
        }
        
    }failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON)
    {
        NSLog(@"Error contacting Google: %@", [error localizedDescription]);
    }
    ];
    
    [operation start];
}
@end
