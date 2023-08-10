//
//  ViewController.m
//  ExtensionExample
//
//  Created by N17 on 2022/8/5.
//

#import "ViewController.h"
#import "Config.h"
#import <AgoraRtcKit/AgoraRtcEngineKit.h>
#import "HTKey.h"

@interface ViewController ()<AgoraRtcEngineDelegate,AgoraMediaFilterEventDelegate, AgoraVideoFrameDelegate>

@property (strong, nonatomic) AgoraRtcEngineKit *agoraKit;
@property (assign, nonatomic) BOOL enable;
@property (weak, nonatomic) IBOutlet UIView *localVideoView;
@property (weak, nonatomic) IBOutlet UIButton *enableExtensionBtn;
@property (weak, nonatomic) IBOutlet UIButton *setARItemBtn;
@property (weak, nonatomic) IBOutlet UIButton *enableARBtn;

@property (nonatomic, strong) NSArray *itmeNames;
@property (nonatomic, assign) NSInteger curIndex;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.blackColor;
    [self.enableExtensionBtn setTitle:@"enableExtension" forState:UIControlStateNormal];

    [self.setARItemBtn setTitle:@"htARSetModel" forState:UIControlStateNormal];
    [self.setARItemBtn setTintColor:[UIColor colorWithRed:0 green:1.0 blue:51.0/255 alpha:1.0]];
  
//    [self.enableARBtn setTitle:@"switchCamera" forState:UIControlStateNormal];
//    [self.enableARBtn setTintColor:[UIColor colorWithRed:0 green:1.0 blue:51.0/255 alpha:1.0]];
    self.enableARBtn.hidden = YES;
    
    [self initRtcEngine];
    self.itmeNames = @[@"ht_3d_effect_cap", @"ht_3d_effect_tiger", @"ht_3d_effect_indian", @"ht_3d_effect_giraffe", @"ht_3d_effect_glasses", @"ht_3d_effect_huahuan"];
    self.curIndex = 0;
}


//VideoFormat
- (void)initRtcEngine {
    AgoraRtcEngineConfig *config = [AgoraRtcEngineConfig new];
    config.appId = appID;
    config.eventDelegate = self;
    self.agoraKit = [AgoraRtcEngineKit sharedEngineWithConfig:config
                                                     delegate:self];
    AgoraVideoEncoderConfiguration *configuration = [AgoraVideoEncoderConfiguration new];
    configuration.dimensions = AgoraVideoDimension640x360;
    configuration.orientationMode = 0;
    [self.agoraKit setVideoEncoderConfiguration:configuration];
    [self enableExtension:nil];
    [self.agoraKit enableVideo];
    [self.agoraKit setChannelProfile:AgoraChannelProfileLiveBroadcasting];
    [self.agoraKit setClientRole:AgoraClientRoleBroadcaster];
    [self.agoraKit startPreview];
}

- (IBAction)enableExtension:(id)sender {
    self.enable = !self.enable;
    [self.agoraKit enableExtensionWithVendor:@"Texeljoy"
                                   extension:@"HTAvatar"
                                     enabled:self.enable]; 
    
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy"
                                        extension:@"HTAvatar"
                                              key:@"htARRenderEnable"
                                            value:[self toJson:@{
                                                @"renderEnable":@(self.enable)
                                            }]];
    
    if (self.enable) {
        [self.enableExtensionBtn setTintColor:[UIColor colorWithRed:0 green:1.0 blue:51.0/255 alpha:1.0]];
    } else {
        [self.enableExtensionBtn setTintColor:UIColor.grayColor];
    }
}


- (void)initExtension{
    // 设置初始资源拷贝路径
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy" extension:@"HTAvatar" key:@"htARCopyResource" value:[self toJson:@{
        @"path":[[NSBundle mainBundle] pathForResource:@"HTEffect" ofType:@"bundle"]
    }]];
    // 离线鉴权方式
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy"
                                        extension:@"HTAvatar"
                                              key:@"htARInitOffline"
                                            value:[self toJson:@{
                                                @"license":HTKey
                                            }]];
    
    // setImageFormat
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy"
                                        extension:@"HTAvatar"
                                              key:@"htARImageFormat"
                                            value:[self toJson:@{
                                                @"imageFormat":@6
                                            }]];
    
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy"
                                        extension:@"HTAvatar"
                                              key:@"htARMirror"
                                            value:[self toJson:@{
                                                @"isMirror":@(YES)
                                            }]];
    
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy"
                                        extension:@"HTAvatar"
                                              key:@"htARRotation"
                                            value:[self toJson:@{
                                                @"rotation":@(0)
                                            }]];
    
}


- (IBAction)setARItmeBtn:(id)sender {
    [self.agoraKit setExtensionPropertyWithVendor:@"Texeljoy" extension:@"HTAvatar" key:@"htARSetModel" value:[self toJson:@{
        @"modelName":self.itmeNames[self.curIndex]
    }]];
    NSLog(@"model name is: %@", self.itmeNames[self.curIndex]);
    _curIndex++;
    if(_curIndex >= self.itmeNames.count){
        _curIndex = 0;
    }
    
}

- (IBAction)enableARBtn:(id)sender {
    
    [self.agoraKit switchCamera];
    
    
}


- (NSString *)toJson:(NSDictionary *)dic {
    NSError *error;
    NSData *data =
    [NSJSONSerialization dataWithJSONObject:dic
                                    options:NSJSONWritingPrettyPrinted
                                      error:&error];
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

- (void)onEvent:(NSString *)provider extension:(NSString *)extension key:(NSString *)key value:(NSString *)value{
    NSLog(@"onEvent provider: %@ extension: %@ key: %@ value: %@", provider, extension, key, value);
}

- (void)onExtensionStarted:(NSString *)provider extension:(NSString *)extension {
    if([provider isEqualToString:@"Texeljoy"]){
        [self initExtension];
        AgoraRtcVideoCanvas *canvas = [AgoraRtcVideoCanvas new];
        canvas.view = self.localVideoView;
        [self.agoraKit setupLocalVideo:canvas];
        [self.agoraKit setLocalRenderMode:AgoraVideoRenderModeHidden mirror:AgoraVideoMirrorModeAuto];
    }
}

@end
