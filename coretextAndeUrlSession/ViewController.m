//
//  ViewController.m
//  coretextAndeUrlSession
//
//  Created by zhouhao on 2016/11/11.
//  Copyright © 2016年 zhouhao. All rights reserved.
//

#import "ViewController.h"
#import "RuntimeTest.h"
#import "CoreTestVC.h"
#import "ScrollAnalog.h"
#import "reuseVC.h"
#import "scrollZoom.h"
@interface ViewController ()

@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
}

-(void)loadView{
    [super loadView];
    [self addBtnWithTile:@"RunTimer" TAG:1 farme:CGRectMake(0, 64, 150, 40)];
    [self addBtnWithTile:@"coretext" TAG:2 farme:CGRectMake(0, 104, 150, 40)];
    [self addBtnWithTile:@"scrollAnalog" TAG:3 farme:CGRectMake(0, 144, 150, 40)];
    [self addBtnWithTile:@"复用" TAG:4 farme:CGRectMake(0, 184, 150, 40)];
    [self addBtnWithTile:@"scrollView缩放" TAG:5 farme:CGRectMake(0, 224, 150, 40)];
    [self addBtnWithTile:@"网络" TAG:6 farme:CGRectMake(0, 264, 150, 40)];
}

-(void)btnClickEvent:(UIButton*)btn{

    NSString *VCStrClass=@"UIViewController";
    if (btn.tag==1) {
     
        VCStrClass=@"RuntimeTest";
        
    }else if (btn.tag==2){
        VCStrClass=@"CoreTestVC";
    }else if (btn.tag==3){
        VCStrClass=@"ScrollAnalog";
    }else if (btn.tag==4){
        VCStrClass=@"reuseVC";
    }else if (btn.tag==5){
        VCStrClass=@"scrollZoom";
    }else if (btn.tag==6){
        VCStrClass=@"NetWork";
    }
    UIViewController *VC=[NSClassFromString(VCStrClass) alloc];
    [self.navigationController pushViewController:VC animated:YES];
    
}

















-(void)addBtnWithTile:(NSString*)title TAG:(NSInteger)tag farme:(CGRect)rect{
    UIButton *but=[[UIButton alloc] initWithFrame:rect];
    [but setTitle:title forState:UIControlStateNormal];
    [but setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    but.tag=tag;
    [but addTarget:self action:@selector(btnClickEvent:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:but];
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
