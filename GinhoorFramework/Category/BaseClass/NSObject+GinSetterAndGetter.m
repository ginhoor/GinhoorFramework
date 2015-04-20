//
//  NSObject+SetterAndGetter.m
//  FrameworkDemo
//
//  Created by JunhuaShao on 15/4/16.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

#import "NSObject+GinSetterAndGetter.h"

@implementation NSObject (GinSetterAndGetter)

/**
 
 enum {
 OBJC_ASSOCIATION_ASSIGN = 0,           < Specifies a weak reference to the associated object.
 OBJC_ASSOCIATION_RETAIN_NONATOMIC = 1, < Specifies a strong reference to the associated object.
 The association is not made atomically.
 OBJC_ASSOCIATION_COPY_NONATOMIC = 3,   < Specifies that the associated object is copied.
 *   The association is not made atomically.
 OBJC_ASSOCIATION_RETAIN = 01401,       < Specifies a strong reference to the associated object.
 *   The association is made atomically.
 OBJC_ASSOCIATION_COPY = 01403          < Specifies that the associated object is copied.
 *   The association is made atomically.
 };
 
 */
- (void)setValue:(id)value key:(NSString *)key policy:(NSInteger)policy owner:(id)owner
{
    if (value != [self getValueForKey:key]) {
        [self willChangeValueForKey:key];
        
        objc_setAssociatedObject(owner, (__bridge const void *)(key),
                                 value,
                                 OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        [self didChangeValueForKey:key];
        
    }
}

- (id)getValueForKey:(NSString *)key
{
    return objc_getAssociatedObject(self, (__bridge const void *)(key));
}

@end
