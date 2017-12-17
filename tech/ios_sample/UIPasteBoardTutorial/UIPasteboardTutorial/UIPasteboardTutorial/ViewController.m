//
//  ViewController.m
//  UIPasteboardTutorial
//
//  Created by KH1386 on 11/12/13.
//  Copyright (c) 2013 KH1386. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>
@interface ViewController ()

@end
#define PASTE_BOARD_NAME @"mypasteboard"
#define PASTE_BOARD_TYPE @"mydata"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void) writeToPasteBoard:(NSDictionary*) dict
{
    UIPasteboard * pb = [UIPasteboard pasteboardWithName:PASTE_BOARD_NAME create:YES];
    [pb setPersistent:TRUE];
    
    [pb setData:[NSKeyedArchiver archivedDataWithRootObject:dict] forPasteboardType:PASTE_BOARD_TYPE];
}
-(NSDictionary*) readFromPasteboard
{
    
    UIPasteboard * pb=[UIPasteboard pasteboardWithName:PASTE_BOARD_NAME create:NO];
    NSData * data=[pb valueForPasteboardType:PASTE_BOARD_TYPE];
    NSDictionary * dict;
    
    if (!data) {
        return nil;
    }
    @try {
        dict = [NSKeyedUnarchiver unarchiveObjectWithData:data];
    }
    @catch (NSException* exception)
    {
        NSLog(@"Exception: %@",exception);
        return nil;
    }
    return dict;
}

-(IBAction) save:(id)sender
{
    NSString * name = self.nameBox.text;
    NSNumber *age = [NSNumber numberWithInteger:[self.ageBox.text integerValue]];
    
    NSMutableDictionary * dict =[[NSMutableDictionary alloc]init];
    [dict setObject:name forKey:@"name"];
    [dict setObject:age forKey:@"age"];
    [self writeToPasteBoard:dict];
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Pasteboard Data"
                                                        message:@"Data is saved to pasteboard"
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:Nil, nil];
    
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    [alertView show];
}
-(IBAction) read:(id)sender
{
    NSString * message=nil;
    NSDictionary * dict = [self readFromPasteboard];
    if(dict)
    {
        NSString * name = [dict objectForKey:@"name"];
        NSNumber * age = [dict objectForKey:@"age"];
        message =[NSString stringWithFormat:@"name =%@,\nage=%@",name,age];
    }
    else
    {
        message =@"No data from Pasteboard";
    }
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Pasteboard Data"
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:Nil, nil];
    
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    [alertView show];

}
-(IBAction) saveGPB:(id)sender
{
 
    UIPasteboard * pasteboard=[UIPasteboard generalPasteboard];
    NSString * text =self.textBox.text;
//    [pasteboard setString:text];
    
    NSData *data = [text dataUsingEncoding:NSUTF8StringEncoding];
    [pasteboard setData:data forPasteboardType:(NSString *)kUTTypeText];

    /*
     //Copy Image
    UIImage * image=[UIImage imageWithContentsOfFile:@"FILE_PATH"];
    [pasteboard setImage:image];
    
    //Copy Image
    NSData *imageData = UIImagePNGRepresentation(image);
    [pasteboard setData:imageData forPasteboardType:(NSString *)kUTTypePNG];
     */
    
}
-(IBAction) readGPB:(id)sender
{
    UIPasteboard * pasteboard=[UIPasteboard generalPasteboard];
    NSLog(@"Text =%@",[pasteboard string]);
    
    NSData * data = [pasteboard dataForPasteboardType:(NSString*)kUTTypeText];
    NSString * text =[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"Text =%@",text);
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Pasteboard Data"
                                                        message:text
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:Nil, nil];
    
    alertView.alertViewStyle = UIAlertViewStyleDefault;
    [alertView show];
    [UIPasteboard removePasteboardWithName:PASTE_BOARD_NAME];

    
}


@end
