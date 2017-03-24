//
//  UITableView+YStaticContentTableViewPrivate.h
//  Pods
//
//  Created by 李遵源 on 2017/3/6.
//
//

#import <UIKit/UIKit.h>
#import "YStaticContentTableViewSection.h"

@interface UITableView (YStaticContentTableViewPrivate)

- (NSMutableArray<YStaticContentTableViewSection *> *)y_staticContentSections;

@end
