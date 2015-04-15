//
//  NSURL+Unit.m
//  hmeIosCn
//
//  Created by JunhuaShao on 15/4/10.
//  Copyright (c) 2015年 Byhere. All rights reserved.
//

#import "NSURL+Unit.h"

@implementation NSURL (Unit)

- (NSDictionary *)queryDictionary
{
    NSMutableDictionary *params = [[NSMutableDictionary alloc] init];
    for (NSString *param in [self.absoluteString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [params setObject:[elts objectAtIndex:1] forKey:[elts objectAtIndex:0]];
    }
    return params;
}

@end
