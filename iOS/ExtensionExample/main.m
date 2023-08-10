//
//  main.m
//  ExtensionExample
//
//  Created by N17 on 2022/8/5.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
#import <HTEffectAR/HTEffectARInterface.h>
  
NSString* CString(const char *string){
NSString *str= [NSString stringWithCString:string encoding:[NSString defaultCStringEncoding]];
return str;
}


int main(int argc, char * argv[]) {

    [[HTEffectARInterface shareInstance] initRuntime:argc argv:argv];
//    NSString *nsArgv = CString(argv[0]);
//    NSDictionary *dic = @{
//        @"argc":@(argc),
//        @"argv":nsArgv,
//    };
//        NSError *error;
//        NSData *data =
//        [NSJSONSerialization dataWithJSONObject:dic
//                                        options:NSJSONWritingPrettyPrinted
//                                          error:&error];
//        NSString *json = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    
//    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy"
//                                        extension:@"HTEffect"
//                                              key:@"htInitRuntime"
//                                            value:json];
    
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}
