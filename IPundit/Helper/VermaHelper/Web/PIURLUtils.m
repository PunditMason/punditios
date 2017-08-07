//
//  PIURLUtils.m
//  Commons
//
//  Created by Omar Hussain on 7/5/13.
//  Copyright (c) 2013 Populace Inc. All rights reserved.
//

#import "PIURLUtils.h"

@implementation PIURLUtils
+(void)openURL:(NSString *)url{
    if([url rangeOfString:@":"].location == NSNotFound){
        url = [NSString stringWithFormat:@"http://%@",url];
        
    }
    if([url rangeOfString:@"www.facebook"].location != NSNotFound){
        url = [url stringByReplacingOccurrencesOfString:@"www.facebook" withString:@"facebook"];
    }
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];

}
@end
