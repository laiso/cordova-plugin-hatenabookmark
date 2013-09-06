#import "HatenaBookmark.h"
#import <Cordova/CDV.h>

#import "HatenaBookmarkSDK.h"

@implementation HatenaBookmark

- (void)setup:(CDVInvokedUrlCommand*)command
{
  [self.commandDelegate runInBackground:^{
    NSString* consumer = [command argumentAtIndex:0];
    NSString* secret = [command argumentAtIndex:1];
    [[HTBHatenaBookmarkManager sharedManager] setConsumerKey:consumer consumerSecret:secret];
  }];
}

- (void)authorize:(CDVInvokedUrlCommand*)command
{
  [self.commandDelegate runInBackground:^{
    [[HTBHatenaBookmarkManager sharedManager] authorizeWithSuccess:^{
      NSLog(@"success");
    } failure:^(NSError *error) {
      NSLog(@"failure");
    }];
  }];
}

- (void)addBookmark:(CDVInvokedUrlCommand*)command
{
  [self.commandDelegate runInBackground:^{
    NSURL *URL = [NSURL URLWithString:[command argumentAtIndex:0]];
    HTBHatenaBookmarkViewController *widget = [[HTBHatenaBookmarkViewController alloc] init];
    widget.URL = URL;
    dispatch_sync(dispatch_get_main_queue(), ^{
      [self.viewController presentViewController:widget animated:YES completion:nil];
    });
  }];
}

#pragma maek - Plugin

- (void)pluginInitialize
{
  [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showOAuthLoginView:) name:kHTBLoginStartNotification object:nil];
}

#pragma maek - Private

-(void)showOAuthLoginView:(NSNotification *)notification {
  NSURLRequest *req = (NSURLRequest *)notification.object;
  UINavigationController *navigationController = [[UINavigationController alloc] initWithNavigationBarClass:[HTBNavigationBar class] toolbarClass:nil];
  HTBLoginWebViewController *viewController = [[HTBLoginWebViewController alloc] initWithAuthorizationRequest:req];
  navigationController.viewControllers = @[viewController];
  
  [self.viewController presentViewController:navigationController animated:YES completion:nil];
}

@end
