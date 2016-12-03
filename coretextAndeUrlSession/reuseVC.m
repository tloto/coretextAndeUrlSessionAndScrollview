//
//  reuseVC.m
//  coretextAndeUrlSession
//
//  Created by zhouhao on 2016/11/29.
//  Copyright © 2016年 zhouhao. All rights reserved.
//

#import "reuseVC.h"

@interface reuseVC ()<UIScrollViewDelegate>{

    NSMutableSet *dequeueSet;
    NSMutableArray *listArray;
    
    CGFloat preOffset_Y;
    
    CGFloat datOffSet;
    
    
    NSInteger cellMinNum;
    NSInteger cellMaxNum;
    
    CGFloat The_First_Of_All_Cell_Min_Y;
    CGFloat The_Last_Of_All_Cell_Max_Y;
    
}
@property(nonatomic,strong)UIScrollView *scrollView;
@end

@implementation reuseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    preOffset_Y=0;
    
    cellMinNum=0;
    cellMaxNum=0;
    
    The_First_Of_All_Cell_Min_Y=0;
    The_Last_Of_All_Cell_Max_Y=0;
    listArray=[NSMutableArray array];
    [self reloadListView];
}

-(void)reloadListView{
    NSInteger i=cellMinNum;
    for (; i<[self numberOfRows]; i++) {
        UIView *view=[self cellForRow:i];
        view.frame=CGRectMake(0, i*[self heghtForRow:i],self.scrollView.frame.size.width, [self heghtForRow:i]);
        [self.scrollView addSubview:view];
        [listArray addObject:view];
        The_Last_Of_All_Cell_Max_Y=CGRectGetMaxY(view.frame);
    }
    cellMaxNum= i-1;
}
-(NSInteger)numberOfRows{
    return 15;
}

-(CGFloat)heghtForRow:(NSInteger)row{
    return 30;
}

-(UIView*)cellForRow:(NSInteger)row{
    UILabel *lab=[self getDequeueObjc];
    if (!lab) {
        lab=[self returnLabel];
    }
    lab.text=[NSString stringWithFormat:@"%zi",row];
    return lab;
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if (listArray.count==0) {
        return;
    }
    
    CGFloat Scrreen_OffSet_min_Y=scrollView.contentOffset.y;
    CGFloat Scrreen_OffSet_max_Y=scrollView.contentOffset.y+scrollView.frame.size.height;
    CGFloat up_down= Scrreen_OffSet_min_Y-preOffset_Y;
    preOffset_Y=Scrreen_OffSet_min_Y;
    
    UIView *lastItem= [listArray lastObject];
    The_Last_Of_All_Cell_Max_Y=CGRectGetMaxY(lastItem.frame);
    
    UIView *firstView=[listArray firstObject];
    The_First_Of_All_Cell_Min_Y=CGRectGetMinY(firstView.frame);

    
    if (up_down>0) {
     
        [listArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *Item=(UIView*)obj;
            CGFloat max_Y=CGRectGetMaxY(Item.frame);
            if (max_Y<Scrreen_OffSet_min_Y) {
                [dequeueSet addObject:Item];
                [Item removeFromSuperview];
                [listArray removeObject:Item];
                cellMinNum+=1;
            }
        }];
        BOOL continure=YES;
        while (continure) {
            if (The_Last_Of_All_Cell_Max_Y>Scrreen_OffSet_max_Y) {
                continure=NO;
            }else{
                cellMaxNum+=1;
                UIView *view= [self cellForRow:cellMaxNum];
                view.frame=CGRectMake(0, The_Last_Of_All_Cell_Max_Y, self.scrollView.frame.size.width, [self heghtForRow:1]);
                [self.scrollView addSubview:view];
                [listArray addObject:view];
                The_Last_Of_All_Cell_Max_Y=CGRectGetMaxY(view.frame);
            }
        }
        
    }else{
    
        [listArray enumerateObjectsWithOptions:NSEnumerationReverse usingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            UIView *Item=(UIView*)obj;
            CGFloat min_Y=CGRectGetMinY(Item.frame);
            if (min_Y>Scrreen_OffSet_max_Y) {
                [dequeueSet addObject:Item];
                [Item removeFromSuperview];
                [listArray removeObject:Item];
                cellMaxNum-=1;
            }
        }];
        BOOL continure=YES;
        while (continure) {
            if (The_First_Of_All_Cell_Min_Y<Scrreen_OffSet_min_Y) {
                continure=NO;
            }else{
                cellMinNum-=1;
                CGFloat cellheight=[self heghtForRow:1];
                UIView *view= [self cellForRow:cellMinNum];
                view.frame=CGRectMake(0, The_First_Of_All_Cell_Min_Y-cellheight, self.scrollView.frame.size.width, cellheight);
                [self.scrollView addSubview:view];
                [listArray insertObject:view atIndex:0];
                The_First_Of_All_Cell_Min_Y=CGRectGetMinY(view.frame);
            }
        }
    }
    
    if (listArray.count>0) {
        UIView *justlastItem= [listArray lastObject];
        UIView *justfirstView=[listArray firstObject];

        The_Last_Of_All_Cell_Max_Y=CGRectGetMaxY(justlastItem.frame);
        The_First_Of_All_Cell_Min_Y=CGRectGetMinY(justfirstView.frame);
    }else{
        The_Last_Of_All_Cell_Max_Y=The_First_Of_All_Cell_Min_Y=0;
    }
}


//-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
//    
//    if (listArray.count==0) {
//        return;
//    }
//    
//    CGFloat Scrreen_OffSet_min_Y=scrollView.contentOffset.y;
//    CGFloat Scrreen_OffSet_max_Y=scrollView.contentOffset.y+scrollView.frame.size.height;
//    CGFloat up_down= Scrreen_OffSet_min_Y-preOffset_Y;
//    preOffset_Y=Scrreen_OffSet_min_Y;
//    
//    UIView *lastItem= [listArray lastObject];
//    CGFloat last_min_Y=CGRectGetMinY(lastItem.frame);
//    CGFloat last_max_Y=CGRectGetMaxY(lastItem.frame);
//
//    UIView *firstView=[listArray firstObject];
//    CGFloat first_min_Y=CGRectGetMinY(firstView.frame);
//    CGFloat first_max_Y=CGRectGetMaxY(firstView.frame);
//
//    if (up_down>0) {//上滑
//        if (Scrreen_OffSet_max_Y>=last_min_Y) {
//            
//            UIView *view= [self getDequeueObjc];
//            view.frame=CGRectMake(0, last_max_Y, self.scrollView.frame.size.width, [self heghtForRow:1]);
//            [self.scrollView addSubview:view];
//            [listArray addObject:view];
//        }
//        if (Scrreen_OffSet_min_Y>first_max_Y) {
//            [dequeueSet addObject:firstView];
//            [firstView removeFromSuperview];
//            [listArray removeObject:firstView];
//        }
//    }else{//下滑
//        if (Scrreen_OffSet_min_Y<=first_max_Y) {
//            float heightOfCell= [self heghtForRow:1];
//            UIView *view= [self getDequeueObjc];
//            view.frame=CGRectMake(0, first_min_Y-heightOfCell, self.scrollView.frame.size.width, heightOfCell);
//            [self.scrollView addSubview:view];
//            [listArray insertObject:view atIndex:0];
//        }
//        if (Scrreen_OffSet_max_Y<last_min_Y) {
//            [dequeueSet addObject:lastItem];
//            [lastItem removeFromSuperview];
//            [listArray removeObject:lastItem];
//        }
//    }
//}

//
//-(void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
//
//    
//
//}






//-(UILabel*)returnLabel:(NSInteger)integer{
//
//    UILabel *lab=[[UILabel alloc] init];
//    lab.backgroundColor=[UIColor redColor];
//    lab.text=[NSString stringWithFormat:@"%zi",integer];
//    lab.textColor=[UIColor whiteColor];
//    lab.textAlignment=NSTextAlignmentCenter;
//    return lab;
//
//}

-(UILabel*)returnLabel{
    UILabel *lab=[[UILabel alloc] init];
    lab.backgroundColor=[UIColor redColor];
    lab.textColor=[UIColor whiteColor];
    lab.textAlignment=NSTextAlignmentCenter;
    return lab;
}



-(UIScrollView *)scrollView{
    if (!_scrollView) {
        _scrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(50, 70, 150, 400)];
        _scrollView.delegate=self;
        _scrollView.backgroundColor=[UIColor blueColor];
        _scrollView.scrollEnabled=YES;
        _scrollView.contentSize=CGSizeMake(_scrollView.frame.size.width, 10000);
        [self.view addSubview:_scrollView];
    }
    return _scrollView;
}

-(id)getDequeueObjc{

    if (!dequeueSet) {
        dequeueSet=[NSMutableSet set];
    }
    id objc=[dequeueSet anyObject];
    if (objc) {
        [dequeueSet removeObject:objc];
    }
    return objc;
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
