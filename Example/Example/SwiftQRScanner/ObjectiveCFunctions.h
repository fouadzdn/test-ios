//
//  ObjectiveCFunctions.h
//  CardsDelivery
//
//  Created by IOS Developer 3 on 1/16/19.
//  Copyright © 2019 Softech. All rights reserved.
//

#import <Foundation/Foundation.h>

//#import "NAInterface.h"
//#import "NASecretBox.h"
//#import "NABox.h"
//#import "NABoxKeypair.h"
//#import "NAAuth.h"
//#import "NAAEAD.h"
//#import "NAOneTimeAuth.h"
//#import "NAScrypt.h"
//#import "NAStream.h"
//#import "NARandom.h"
//#import "NASecureData.h"
#import "NSDataAdditions.h"

NS_ASSUME_NONNULL_BEGIN

@interface ObjectiveCFunctions : NSObject

+ (NSNumber *)dateToSecondConvert;

+ (NSString *)getDeviceID;


+ (NSString *) sha1:(NSString *) str;


@end

NS_ASSUME_NONNULL_END
