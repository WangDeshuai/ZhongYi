//
//  YuYinView.m
//  ZYVoiceToWordTextViewDemo
//
//  Created by Macx on 17/7/20.
//  Copyright © 2017年 ZY. All rights reserved.
//

#import "YuYinView.h"
#import "SDAutoLayout.h"
//语音转文字 讯飞
#import "iflyMSC/IFlyRecognizerViewDelegate.h"
#import "iflyMSC/IFlyRecognizerView.h"
#import "iflyMSC/IFlySpeechUtility.h"
#import "ISRDataHelper.h"
#import "iflyMSC/iflyMSC.h"
//音效
#import <AudioToolbox/AudioToolbox.h>
#define ScreenWidth [UIScreen mainScreen].bounds.size.width
#define ScreenHeight [UIScreen mainScreen].bounds.size.height
#define JXColor(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)]
@interface YuYinView()<IFlySpeechRecognizerDelegate>
@property(nonatomic,strong)UILabel * namelabel;
@property (nonatomic, strong) IFlySpeechRecognizer *iFlySpeechRecognizer;
@property(nonatomic,strong)UIButton * yuYinBtn;
@end

@implementation YuYinView

- (id)init{
    self=[super init];
    if (self) {
        
        
        self.backgroundColor=[UIColor whiteColor];
        [self YuYinZhangHao];
        UIButton * btn =[UIButton buttonWithType:UIButtonTypeCustom];
        btn.backgroundColor=JXColor(60, 163, 250, 1);
        _yuYinBtn=btn;
        btn.sd_cornerRadius=@(50);
        [btn addTarget:self
                action:@selector(btnclinkk:) forControlEvents:UIControlEventTouchUpInside];
        [btn setImage:[UIImage imageNamed:@"voice"] forState:0];
        
        [self sd_addSubviews:@[btn]];
        btn.sd_layout
        .centerXEqualToView(self)
        .topSpaceToView(self,30)
        .widthIs(100)
        .heightIs(100);
        
        
        UILabel * namelabel =[UILabel new];
        namelabel.text=@"点击按钮开始语音转文字";
        namelabel.font=[UIFont systemFontOfSize:15];
        namelabel.textColor=JXColor(60, 163, 250, 1);
        [self sd_addSubviews:@[namelabel]];
        _namelabel=namelabel;
        namelabel.sd_layout
        .centerXEqualToView(btn)
        .topSpaceToView(btn,20)
        .heightIs(20);
        [namelabel setSingleLineAutoResizeWithMaxWidth:300];
        
        
        

       
        
    }
    return self;
}

-(void)btnclinkk:(UIButton*)btn{
    btn.selected=!btn.selected;
    if (btn.selected==YES) {
       
        [self playVoiceSoundWithWav:@"VoiceOn"];
        [_iFlySpeechRecognizer cancel];
        [_iFlySpeechRecognizer startListening];
         btn.backgroundColor=[UIColor orangeColor];
    }else{
        btn.backgroundColor=JXColor(60, 163, 250, 1);;
         [_iFlySpeechRecognizer stopListening];
        self.namelabel.text = @"点击按钮开始语音转文字";
    }
    
    
}




-(void)YuYinZhangHao{
        NSString *initString = @"appid=58119529";
        [IFlySpeechUtility createUtility:initString];
    
        [IFlySetting showLogcat:NO];//关闭日志
    
        //初始化语音识别控件
        if (_iFlySpeechRecognizer == nil) {
            _iFlySpeechRecognizer = [IFlySpeechRecognizer sharedInstance];
    
            [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
    
            //设置听写模式
            [_iFlySpeechRecognizer setParameter:@"iat" forKey:[IFlySpeechConstant IFLY_DOMAIN]];
        }
        _iFlySpeechRecognizer.delegate = self;
    
        //设置音频来源为麦克风
        [_iFlySpeechRecognizer setParameter:IFLY_AUDIO_SOURCE_MIC forKey:@"audio_source"];
    
        //设置听写结果格式为json
        [_iFlySpeechRecognizer setParameter:@"json" forKey:[IFlySpeechConstant RESULT_TYPE]];
        //保存录音文件，保存在sdk工作路径中，如未设置工作路径，则默认保存在library/cache下
        [_iFlySpeechRecognizer setParameter:@"asr.pcm" forKey:[IFlySpeechConstant ASR_AUDIO_PATH]];
        //设置最长录音时间
        [_iFlySpeechRecognizer setParameter:@"30000" forKey:[IFlySpeechConstant SPEECH_TIMEOUT]];
        //设置后端点
        [_iFlySpeechRecognizer setParameter:@"500" forKey:[IFlySpeechConstant VAD_EOS]];
        //设置前端点
        [_iFlySpeechRecognizer setParameter:@"3000" forKey:[IFlySpeechConstant VAD_BOS]];
        //网络等待时间
        [_iFlySpeechRecognizer setParameter:@"20000" forKey:[IFlySpeechConstant NET_TIMEOUT]];
        //设置采样率，推荐使用16K
        [_iFlySpeechRecognizer setParameter:@"16000" forKey:[IFlySpeechConstant SAMPLE_RATE]];
        //设置语言
        [_iFlySpeechRecognizer setParameter:@"zh_cn" forKey:[IFlySpeechConstant LANGUAGE]];
        [_iFlySpeechRecognizer setParameter:@"mandarin" forKey:[IFlySpeechConstant ACCENT]];
        //设置是否返回标点符号
        [_iFlySpeechRecognizer setParameter:@"0" forKey:[IFlySpeechConstant ASR_PTT]];
      
    
   
}

#pragma mark --3.停止录音回调
- (void)onEndOfSpeech
{
    [self playVoiceSoundWithWav:@"VoiceOff"];
    
    if (self.yuYinBtn.selected == YES) {
        
        self.namelabel.text = @"识别结束";
        
        self.yuYinBtn.userInteractionEnabled = NO;
        self.yuYinBtn.enabled=NO;
        //停留1s
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self btnclinkk:_yuYinBtn];
            self.yuYinBtn.userInteractionEnabled = YES;
            self.yuYinBtn.enabled=YES;
        });
    }
}

#pragma mark --4.开始录音回调
- (void)onBeginOfSpeech {
    self.yuYinBtn.enabled=NO;
    self.namelabel.text = @"识别中...";
}

#pragma mark --1.识别返回结果
- (void)onResults:(NSArray *)results isLast:(BOOL)isLast
{
    NSMutableString *result = [[NSMutableString alloc] init];
    NSDictionary *dic = [results objectAtIndex:0];
    
    for (NSString *key in dic) {
        [result appendFormat:@"%@",key];
    }
    
    NSString *resultFromJson = [ISRDataHelper stringFromJson:result];
    
   
    self.TextBlock(resultFromJson,isLast);
    
    
   
    
}
/*识别会话错误返回代理
 @ param  error 错误码
 */
#pragma mark --2.识别会话结束返回代理
- (void)onError: (IFlySpeechError *) error
{
    NSLog(@"error.errorDesc %@",error.errorDesc);
    if (error.errorCode == 20001) {//没有网络
        //提示没有网络
        //        [MBProgressHUD showHudTipStr:@请检查网络!"];
    }
}
#pragma mark --5.会话取消回调
- (void)cancel
{
    [_iFlySpeechRecognizer cancel]; //取消识别
    [_iFlySpeechRecognizer setDelegate:nil];
    [_iFlySpeechRecognizer setParameter:@"" forKey:[IFlySpeechConstant PARAMS]];
}


-(void)playVoiceSoundWithWav:(NSString *)wavName
{
    //音效
    SystemSoundID soundID;
    
    // 加载文件
    NSURL *fileURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:wavName ofType:@"wav"]];
    AudioServicesCreateSystemSoundID((__bridge CFURLRef)(fileURL), &soundID);
    
    // 播放短频音效
    AudioServicesPlaySystemSound(soundID);
    
    //    // 增加震动效果，如果手机处于静音状态，提醒音将自动触发震动
        AudioServicesPlayAlertSound(kSystemSoundID_Vibrate);
}












- (void)show{
    //获取window对象
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
//    self.center=window.center;
    self.frame=CGRectMake(0, ScreenHeight-256, ScreenWidth, 256);
    
    UIButton * view = [UIButton buttonWithType:UIButtonTypeCustom];//
    view.frame=CGRectMake(0, 0, ScreenWidth, ScreenHeight);
    [view addTarget:self action:@selector(dissmiss) forControlEvents:UIControlEventTouchUpInside];
    view.backgroundColor = [UIColor blackColor];
    view.alpha = 0.1;
    view.tag=1000;
    [window addSubview:view];
    [window addSubview:self];
    
   
    
    
}
-(void)dissmiss{
    
    [self cancel];
    _yuYinBtn.backgroundColor=JXColor(60, 163, 250, 1);;
    [_iFlySpeechRecognizer stopListening];
    self.namelabel.text = @"点击按钮开始语音转文字";
    
    UIWindow *window = [UIApplication sharedApplication].delegate.window;
    UIView * view =[window viewWithTag:1000];
    
    [view removeFromSuperview];
    [self removeFromSuperview];
    
    
    
}


@end
