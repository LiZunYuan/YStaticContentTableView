//
//  YStaticContentTableViewBlocks.h
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import <Foundation/Foundation.h>

@class YStaticContentTableViewSection, YStaticContentTableViewCellExtraInfo;

typedef void(^YStaticContentTableViewCellBlock)(YStaticContentTableViewCellExtraInfo *staticContentCell, id cell, NSIndexPath *indexPath);
typedef void(^YStaticContentTableViewCellWhenSelectedBlock)(NSIndexPath *indexPath);

typedef void(^YStaticContentTableViewControllerAddSectionBlock)(YStaticContentTableViewSection *section, NSUInteger sectionIndex);

typedef void(^TTT)(NSIndexPath *indexPath);
