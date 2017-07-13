//  Copyright (c) Hypercrypt Solutions Ltd. and individual contributors.
//  
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without modification,
//  are permitted provided that the following conditions are met:
//  
//      1. Redistributions of source code must retain the above copyright notice, 
//         this list of conditions and the following disclaimer.
//      
//      2. Redistributions in binary form must reproduce the above copyright 
//         notice, this list of conditions and the following disclaimer in the
//         documentation and/or other materials provided with the distribution.
//  
//      3. Neither the name of Django nor the names of its contributors may be used
//         to endorse or promote products derived from this software without
//         specific prior written permission.
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
//  ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//
//  UIControl+Blocks.m
//
//  Created by Klaus-Peter Dudas on 11/07/2012.
//

#import <objc/runtime.h>

#import "UIControl+Blocks.h"

static NSString * const UIControlBlocksControlEventsKey = @"UIControlBlocksControlEventsKey";
static NSString * const UIControlBlocksSelectorKey      = @"UIControlBlocksSelectorKey";

static inline const char *uuid() {
    
    return [[[NSUUID UUID] UUIDString] UTF8String];
}

#pragma mark - Private Helper Categoty
@interface NSObject (Blocks_Private)

@property (atomic, readonly) BOOL Blocks_supportsBlocks;

@end

@implementation NSObject (Blocks_Private)

- (BOOL)Blocks_supportsBlocks
{
    return NO;
}

@end

#pragma mark - Action Object

@interface HCSBlockAction : NSObject

@property (nonatomic, readonly) SEL selector;
@property (nonatomic, readonly) UIControlEvents controlEvents;

+ (instancetype)actionWithSelector:(SEL)selector controlEvents:(UIControlEvents)controlEvents;

@end

@implementation HCSBlockAction

+ (instancetype)actionWithSelector:(SEL)selector controlEvents:(UIControlEvents)controlEvents
{
    HCSBlockAction *action = [[self alloc] init];
    
    if (action) {
        action->_controlEvents = controlEvents;
        action->_selector = selector;
    }
    
    return action;
}

@end

#pragma mark - IMPs

static Class returnSuperClassIMP(id self, SEL _cmd)
{
    return class_getSuperclass(object_getClass(self));
}

static BOOL returnYesIMP(id self, SEL _cmd)
{
    return YES;
}

static void nop2IMP(id self, SEL _cmd, __unused id _1, __unused id _2) {}

#pragma mark -

@implementation UIControl (Blocks)

- (NSMutableArray *)actionsArray
{
    NSMutableArray *actionsArray = objc_getAssociatedObject(self, _cmd);
    
    if (!actionsArray)
    {
        actionsArray = [NSMutableArray array];
        objc_setAssociatedObject(self, _cmd, actionsArray, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    return actionsArray;
}
    
- (id)addActionForControlEvents:(UIControlEvents)controlEvents
                     usingBlock:(UIControlBlocksActionBlock)block
{
    static const char *CommonPart = "UIControlBlocks";
    
    if (![self Blocks_supportsBlocks])
    {
        char *newClassName;
        asprintf(&newClassName,
                 "%s_%s", object_getClassName(self), CommonPart);
        
        Class newClass = objc_allocateClassPair([self class], newClassName, 0);
        
        if (newClass)
        {
            objc_registerClassPair(newClass);
        }
        else
        {
            newClass = objc_lookUpClass(newClassName);
        }
        
        free(newClassName);

        if (newClass)
        {
            object_setClass(self, newClass);
            
            // Hide the subclassing
            class_addMethod(newClass, @selector(class),                 (IMP)returnSuperClassIMP, "#@:");
            class_addMethod(newClass, @selector(Blocks_supportsBlocks), (IMP)returnYesIMP,        "c@:");
        }
    }
    
    char *actionString;
    asprintf(&actionString,
             "%s_action_%s:forEvent:", CommonPart, uuid());
    
    SEL selector = sel_getUid(actionString);
    
    free(actionString);
    
    IMP imp = imp_implementationWithBlock(^(id _self, UIControl *sender, UIEvent *event){ block(sender, event); });
    
    if (class_addMethod(object_getClass(self), selector, imp, "v@:@@"))
    {
        [self addTarget:self action:selector forControlEvents:controlEvents];
        
        id actionIdentifier = [HCSBlockAction actionWithSelector:selector
                                                   controlEvents:controlEvents];
        
        [self.actionsArray addObject:actionIdentifier];
        
        return actionIdentifier;
    }
    else
    {
        return nil;
    }
}

- (void)removeAllActions
{
    for (id action in [self.actionsArray copy])
    {
        [self removeAction:action];
    }
}

- (void)removeAction:(HCSBlockAction *)action
{
    NSParameterAssert([action isMemberOfClass:[HCSBlockAction class]]);
    
    @try
    {
        [self removeTarget:self
                    action:action.selector
          forControlEvents:action.controlEvents];
        
        Method method = class_getInstanceMethod(object_getClass(self), action.selector);
        IMP currentIMP = method_getImplementation(method);
        
        imp_removeBlock(currentIMP);
        method_setImplementation(method, (IMP)nop2IMP);
        
        [self.actionsArray removeObject:action];
        
        if (self.actionsArray.count == 0)
        {
            object_setClass(self, [self class]);
        }
    }
    @catch (NSException *exception) {}
}

- (void)dealloc
{
    [self removeAllActions];
}

@end
