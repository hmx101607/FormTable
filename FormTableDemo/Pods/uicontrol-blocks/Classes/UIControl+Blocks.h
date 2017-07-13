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
//  UIControl+Blocks.h
//
//  Created by Klaus-Peter Dudas on 11/07/2012.
//

#import <UIKit/UIKit.h>

typedef void(^UIControlBlocksActionBlock)(UIControl *sender, UIEvent *event);

@interface UIControl (Blocks)

/**
 * Adds an action for the passed \c controlEvents unsing the passed \c block.
 * This method may be called multiple times and does not override the existing actions, just as
 * \c -addTarget:action:forControlEvents: behaves.
 * @param controlEvents The \c UIControlEvents for which the \c block should be executed.
 * @param block The block to execute.
 * @returns An opaque handler to remove an action again. This is retained internally and may be
 * assigned to a weak variable. As per Cocoa naming conventions,
 * ownership is *NOT* transfered to the caller.
 */
- (id)addActionForControlEvents:(UIControlEvents)controlEvents
                     usingBlock:(UIControlBlocksActionBlock)block;

/**
 * Removes all actions that have previously been added.
 */
- (void)removeAllActions;

/**
 * Removes a specific action for all associated \c UIControlEvents.
 * @param An object returned from \c -addActionForControlEvents:usingBlock:.
 */
- (void)removeAction:(id)action;

@end
