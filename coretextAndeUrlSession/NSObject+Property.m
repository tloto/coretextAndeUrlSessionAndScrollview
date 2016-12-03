//
//  NSObject+Property.m
//  coretextAndeUrlSession
//
//  Created by zhouhao on 2016/11/15.
//  Copyright © 2016年 zhouhao. All rights reserved.
//

#import "NSObject+Property.h"
#import <objc/runtime.h>
#import <objc/message.h>
static const char *key = "name";
@implementation NSObject (Property)

-(NSString *)name{
    return objc_getAssociatedObject(self, key);
}


-(void)setName:(NSString *)name{
    return objc_setAssociatedObject(self, key, name, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


@end
