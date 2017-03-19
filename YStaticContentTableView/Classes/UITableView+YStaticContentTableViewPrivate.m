//
//  UITableView+YStaticContentTableViewPrivate.m
//  Pods
//
//  Created by 李遵源 on 2017/3/6.
//
//

#import "UITableView+YStaticContentTableViewPrivate.h"
#import <objc/runtime.h>

@implementation UITableView (YStaticContentTableViewPrivate)

- (NSMutableArray<YStaticContentTableViewSection *> *)staticContentSections {
    static void *staticContentSectionsKey;
    NSMutableArray *_staticContentSections = objc_getAssociatedObject(self, &staticContentSectionsKey);
    if (!_staticContentSections) {
        objc_setAssociatedObject(self, &staticContentSectionsKey, [NSMutableArray array], OBJC_ASSOCIATION_RETAIN);
    }
    return _staticContentSections;
}

@end
