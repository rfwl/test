//
//  UIPasteboardHelper.m
//  App1
//
//  Created by KH1386 on 11/6/13.
//  Copyright (c) 2013 KH1386. All rights reserved.
//

#import "UIPasteboardHelper.h"
#define PB_DICT_NAME @"value"
@implementation UIPasteboardHelper
@synthesize pbName;

-(id) initWithName:(NSString*)name
{
    self = [super init];
    if(self)
    {
        pbName = [NSString stringWithString:name];
        NSLog(@"Setting Name =%@",pbName);

    }
    return self;
}
-(void) writeDataToPasteBoard:(NSString * )key :(id) value
{
    NSLog(@"PB Name =%@",pbName);

    UIPasteboard * pasteBoard = [UIPasteboard pasteboardWithName:pbName create:YES];
    [pasteBoard setPersistent:YES];
    NSMutableDictionary * dict = nil;

    NSArray * items =[pasteBoard items];
    if(items && [items count] > 0)
       dict=[items objectAtIndex:0];
    else
        dict =[[NSMutableDictionary alloc]init];
    
    [dict setObject:value forKey:key];

    NSMutableArray * array =[[NSMutableArray alloc] init];
    [array addObject:dict];
    NSLog(@"Adding Dictionary :%@",array);

    [pasteBoard setValue:array forPasteboardType:@"0"];

}

-(id) readDataFromPasteBoard:(NSString*)key
{
    NSLog(@"PB Name =%@",pbName);
    UIPasteboard * pasteBoard = [UIPasteboard pasteboardWithName:pbName create:NO];
    NSArray * items =[pasteBoard items];
    NSLog(@"Items are =%@",items);
    if(items)
    {
        NSDictionary *dict = [items objectAtIndex:0];
    
        return [dict objectForKey:key];
    }
    return nil;
}
@end
