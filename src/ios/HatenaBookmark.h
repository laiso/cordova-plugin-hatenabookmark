#import <Cordova/CDV.h>

@interface HatenaBookmark : CDVPlugin

- (void)setup:(CDVInvokedUrlCommand*)command;
- (void)authorize:(CDVInvokedUrlCommand*)command;
- (void)addBookmark:(CDVInvokedUrlCommand*)command;

@end
