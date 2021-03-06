//
//  StringEncryption.h
//
//  Created by DAVID VEKSLER on 2/4/09.
//

#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>
#import <Foundation/Foundation.h>


#define kChosenCipherBlockSize	kCCBlockSizeAES128
#define kChosenCipherKeySize	kCCKeySizeAES128
#define kChosenDigestLength		CC_SHA1_DIGEST_LENGTH

@interface StringEncryption : NSObject 

+ (NSString *) EncryptString:(NSString *)plainSourceStringToEncrypt;
+ (NSString *) DecryptString:(NSString *) base64StringToDecrypt;

- (void)testSymmetricEncryption;

- (NSData *)encrypt:(NSData *)plainText key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7;
- (NSData *)decrypt:(NSData *)plainText key:(NSData *)aSymmetricKey padding:(CCOptions *)pkcs7;

- (NSData *)doCipher:(NSData *)plainText key:(NSData *)aSymmetricKey
			 context:(CCOperation)encryptOrDecrypt padding:(CCOptions *)pkcs7;

- (NSData*) md5data: ( NSString *) str;


@end
