//
//  UIPasteboardHelper.h
//  App1
//
//  Created by KH1386 on 11/6/13.
//  Copyright (c) 2013 KH1386. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UIPasteboardHelper : NSObject
-(void) writeDataToPasteBoard:(NSString * )key :(id)value;
-(id) readDataFromPasteBoard:(NSString*)key;
@property NSString * pbName;

-(id) initWithName:(NSString*)name;

@end
