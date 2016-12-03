//
//  scrollZoom.m
//  coretextAndeUrlSession
//
//  Created by zhouhao on 2016/12/3.
//  Copyright © 2016年 zhouhao. All rights reserved.
//

#import "scrollZoom.h"

@interface scrollZoom ()<UIScrollViewDelegate>{
    UIScrollView *scrollview;
    UIImageView *image;
}


@end

@implementation scrollZoom

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    image=[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"3"]];
    [scrollview addSubview:image];
    //    [scrollview setContentSize:image.frame.size];
}


-(void)loadView{
    [super loadView];
    CGRect rect=[UIScreen mainScreen].bounds;
    rect.size.height=rect.size.height-64;
    rect.origin.y=0;
    scrollview=[[UIScrollView alloc] initWithFrame:rect];
    scrollview.delegate=self;
    scrollview.zoomScale=1;
    scrollview.maximumZoomScale=2;
    scrollview.minimumZoomScale=0.5;
    [self.view addSubview:scrollview];
    self.automaticallyAdjustsScrollViewInsets=NO;
    
}


-(void)scrollViewDidZoom:(UIScrollView *)scrollView{
    
    //    NSLog(@"%f",scrollview.zoomScale);
    //    if(scrollView.zoomScale <=1) scrollView.zoomScale = 1.0f;
    
    CGFloat xcenter = scrollView.center.x , ycenter = scrollView.center.y;
    
    xcenter = scrollView.contentSize.width > scrollView.frame.size.width ? scrollView.contentSize.width/2 : xcenter;
    
    ycenter = scrollView.contentSize.height > scrollView.frame.size.height ? scrollView.contentSize.height/2 : ycenter;
    
    [image setCenter:CGPointMake(xcenter, ycenter)];
    
}
- (nullable UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
    return image;
    
}
-(void)scrollViewWillBeginZooming:(UIScrollView *)scrollView withView:(UIView *)view{
    //     NSLog(@"2222    %f",scrollview.zoomScale);
    
}

//- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(nullable UIView *)view atScale:(CGFloat)scale{
//    NSLog(@"%f",scale);
//
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
