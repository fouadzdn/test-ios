//
//  ObjectiveCFunctions.m
//  CardsDelivery
//
//  Created by IOS Developer 3 on 1/16/19.
//  Copyright © 2019 Softech. All rights reserved.
//

#import "ObjectiveCFunctions.h"
#import "StringEncryption.h"
#import "NSDataAdditions.h"

//#import "ZYQSphereView.h"

@implementation ObjectiveCFunctions
{
    
}

#pragma mark - NSDate
+ (NSNumber *)dateToSecondConvert{
    
    NSDate *today = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeStyle:NSDateFormatterMediumStyle];
    NSString *currentTime = [dateFormatter stringFromDate:today];

    
    NSArray *components = [currentTime componentsSeparatedByString:@":"];
    
    NSInteger hours   = [[components objectAtIndex:0] integerValue];
    NSInteger minutes = [[components objectAtIndex:1] integerValue];
    NSInteger seconds = [[components objectAtIndex:2] integerValue];
    
    return [NSNumber numberWithInteger:(hours * 60 ) + (minutes ) + (seconds/60) ];
}




+ (NSString *)getDeviceID
{
    static NSString *idKey = @"deviceId";
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSString *uuid = [defaults objectForKey:idKey];
    if (!uuid) {
        CFUUIDRef uuidRef = CFUUIDCreate(NULL);
        CFStringRef uuidStringRef = CFUUIDCreateString(NULL, uuidRef);
        CFRelease(uuidRef);
        uuid = [NSString stringWithString:(NSString *) CFBridgingRelease(uuidStringRef)];
        
        [defaults setObject:[uuid copy] forKey:idKey];
    }
    return uuid;
}


+ (NSString *)sha1:(NSString *) str {
    //str = @"123456";
    
    NSData *data = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    uint8_t digest[CC_SHA1_DIGEST_LENGTH];
    
    CC_SHA1(data.bytes, data.length, digest);
    
    NSMutableString *output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
    
    for (int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
    {
        [output appendFormat:@"%02x", digest[i]];
    }
    
    return output;
}
#pragma mark - Image


@end
