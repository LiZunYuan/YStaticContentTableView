//
//  JMStaticContentTableViewBlocks.h
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import <Foundation/Foundation.h>
//#import <CoreGraphics/CoreGr>

@class YStaticContentTableViewSection, YStaticContentTableViewCell;

typedef void(^YStaticContentTableViewCellBlock)(YStaticContentTableViewCell *staticContentCell, id cell, NSIndexPath *indexPath);
typedef void(^YStaticContentTableViewCellWhenSelectedBlock)(NSIndexPath *indexPath);

typedef void(^YStaticContentTableViewControllerAddSectionBlock)(YStaticContentTableViewSection *section, NSUInteger sectionIndex);

