//
//  YStaticContentTableViewCellExtraInfo+Private.m
//  Pods
//
//  Created by 李遵源 on 2017/3/2.
//
//

#import "YStaticContentTableViewCellExtraInfo+Private.h"
#import "objc/runtime.h"


NSString * const YStaticContentTableViewCellIndexPathKey = @"YStaticContentTableViewCellIndexPathKey";

@implementation YStaticContentTableViewCellExtraInfo (Private)

- (void)y_setIndexPath:(NSIndexPath *)indexPath
{
    objc_setAssociatedObject(self, &YStaticContentTableViewCellIndexPathKey, indexPath, OBJC_ASSOCIATION_COPY);
}

@end
