//
//  ViewController.h
//  reversegeo
//
//  Created by Cyron Completo on 4/10/15.
//  Copyright (c) 2015 Cyron Completo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *latText;
@property (weak, nonatomic) IBOutlet UITextField *longText;
@property (weak, nonatomic) IBOutlet UILabel *outputText;
- (IBAction)submitButtonPressed:(id)sender;
- (void)addressLocation:(float)lat lng:(float)lng;


@end

