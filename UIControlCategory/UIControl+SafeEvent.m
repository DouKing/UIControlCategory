//
//  UIControl+SafeEvent.m
//  UIControlCategory
//
//  Created by WuYikai on 15/9/11.
//  Copyright (c) 2015年 secoo. All rights reserved.
//

#import "UIControl+SafeEvent.h"
#import <objc/runtime.h>

static const char *UIControl_acceptEventInterval = "UIControl_acceptEventInterval";
static const char *kIgnoreEventKey = "kIgnoreEventKey";

@implementation UIControl (SafeEvent)

+ (void)load {
  Method a = class_getInstanceMethod(self, @selector(sendAction:to:forEvent:));
  Method b = class_getInstanceMethod(self, @selector(_sendAction:to:forEvent:));
  method_exchangeImplementations(a, b);
}

- (NSTimeInterval)acceptEventInterval {
  return [objc_getAssociatedObject(self, UIControl_acceptEventInterval) doubleValue];
}

- (void)setAcceptEventInterval:(NSTimeInterval)acceptEventInterval {
  objc_setAssociatedObject(self, UIControl_acceptEventInterval, @(acceptEventInterval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)_sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
  if (self.ignoreEvent) { return; }
  if (self.acceptEventInterval > 0) {
    self.ignoreEvent = YES;
    [self performSelector:@selector(setIgnoreEvent:) withObject:@(NO) afterDelay:self.acceptEventInterval];
  }
  [self _sendAction:action to:target forEvent:event];
}

#pragma mark -
- (BOOL)ignoreEvent {
  return [objc_getAssociatedObject(self, kIgnoreEventKey) boolValue];
}

- (void)setIgnoreEvent:(BOOL)ignoreEvent {
  objc_setAssociatedObject(self, kIgnoreEventKey, @(ignoreEvent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}
@end
