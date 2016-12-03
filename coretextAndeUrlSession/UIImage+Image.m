//
//  UIImage+Image.m
//  coretextAndeUrlSession
//
//  Created by zhouhao on 2016/11/15.
//  Copyright © 2016年 zhouhao. All rights reserved.
//

#import "UIImage+Image.h"
#import <objc/runtime.h>
@implementation UIImage (Image)
+(void)load{

    Method imageWithName = class_getClassMethod(self, @selector(imageWithName:));
    Method imageName = class_getClassMethod(self, @selector(imageNamed:));
    method_exchangeImplementations(imageWithName, imageName);
    
}

+(UIImage *)imageWithName:(NSString*)name{

    
    UIImage *image=[self imageWithName:name];
    
    if (image==nil) {
        NSLog(@"空照片");
    }
    
    return image;
}
@end
