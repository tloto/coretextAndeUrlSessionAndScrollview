//
//  ScrollAnalog.m
//  coretextAndeUrlSession
//
//  Created by zhouhao on 2016/11/18.
//  Copyright © 2016年 zhouhao. All rights reserved.
//

#import "ScrollAnalog.h"

@interface ScrollAnalog (){

    CFTimeInterval TimerInterval;
    CGFloat facter_veloc;
    CGFloat Accelerated_speed;

}
@property (nonatomic,strong)UIView *AnalogView;
@property (nonatomic,assign)CGPoint startLocation;
@property (nonatomic,strong)CADisplayLink *displaylink;
@end

@implementation ScrollAnalog

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    for (int i=0; i<500; i++) {
        UILabel *lab=[[UILabel alloc] initWithFrame:CGRectMake(0, i*50, 200, 50)];
        lab.text=[NSString stringWithFormat:@"%d",i];
        lab.textColor=[UIColor whiteColor];
        lab.textAlignment=NSTextAlignmentCenter;
        [_AnalogView addSubview:lab];
    }
    
    UIPanGestureRecognizer * panGesture=[[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(GestureTouchAction:)];
    [_AnalogView addGestureRecognizer:panGesture];
    
    _displaylink=[CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkEvent)];
    [_displaylink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    _displaylink.frameInterval=1;
    _displaylink.paused=YES;
    
    
    Accelerated_speed=1500;
    
    
}

-(void)loadView{
    [super loadView];
    
    _AnalogView=[[UIView alloc] initWithFrame:CGRectMake(50, 80, 200, 300)];
    _AnalogView.backgroundColor=[UIColor redColor];
    _AnalogView.clipsToBounds=YES;
    [self.view addSubview:_AnalogView];
    
}

-(void)GestureTouchAction:(UIPanGestureRecognizer*)Gesture{
    
    if (Gesture.state == UIGestureRecognizerStateBegan) {
        self.startLocation = _AnalogView.bounds.origin;
        _displaylink.paused=YES;
    }
    
    // 相对于初始触摸点的偏移量
    else if (Gesture.state == UIGestureRecognizerStateChanged) {
        CGPoint point = [Gesture translationInView:_AnalogView];
        CGFloat newOriginalY = self.startLocation.y - point.y;
        CGRect bounds = _AnalogView.bounds;
        bounds.origin = CGPointMake(0, newOriginalY);
        _AnalogView.bounds = bounds;
    }
    else if (Gesture.state==UIGestureRecognizerStateEnded){
        CGPoint veloc = [Gesture velocityInView:_AnalogView];
        facter_veloc=veloc.y/1.1;
        if (facter_veloc<0.000001&&facter_veloc>-0.000001) {
            return;
        }
        if (facter_veloc>0) {
            Accelerated_speed=-Accelerated_speed;
        }
        TimerInterval=fabs(facter_veloc/Accelerated_speed);
        _displaylink.paused=NO;
    }
}


-(void)displayLinkEvent{

    CFTimeInterval timer = MIN(TimerInterval, _displaylink.duration);
    if (TimerInterval==timer) {
        _displaylink.paused=YES;
    }
    
    CGFloat facter_offset_y=timer*(facter_veloc+0.5*Accelerated_speed*timer);
    self.startLocation = _AnalogView.bounds.origin;
    CGRect bounds = _AnalogView.bounds;
    bounds.origin = CGPointMake(0,_startLocation.y-facter_offset_y);
    _AnalogView.bounds=bounds;
    facter_veloc=facter_veloc-timer*Accelerated_speed;
    TimerInterval=TimerInterval-timer;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)dealloc{
    [_displaylink invalidate];
    _displaylink=nil;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
