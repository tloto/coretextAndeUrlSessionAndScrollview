//
//  RuntimeTest.m
//  coretextAndeUrlSession
//
//  Created by zhouhao on 2016/11/15.
//  Copyright © 2016年 zhouhao. All rights reserved.
//

#import "RuntimeTest.h"
#import "UIImage+Image.h"
#import "NSObject+Property.h"
#import <objc/runtime.h>
#import <objc/message.h>
@interface RuntimeTest (){
    NSString *testStr;
}
@property(nonatomic,strong)NSString *helloStr;
@end

@implementation RuntimeTest

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    UIImage *img=[UIImage imageNamed:@"111"];
    UIImageView *image=[[UIImageView alloc] initWithImage:img];
    
    [self.view addSubview:image];
    
    NSObject *objc=[[NSObject alloc] init];
    objc.name=@"小马哥";
    NSLog(@"%@",objc.name);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
