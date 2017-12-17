//
//  ViewController.h
//  UIPasteboardTutorial
//
//  Created by KH1386 on 11/12/13.
//  Copyright (c) 2013 KH1386. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *nameBox;
@property (weak, nonatomic) IBOutlet UITextField *ageBox;
@property (weak, nonatomic) IBOutlet UITextField *textBox;

-(IBAction) save:(id)sender;
-(IBAction) read:(id)sender;

-(IBAction) saveGPB:(id)sender;
-(IBAction) readGPB:(id)sender;


@end
