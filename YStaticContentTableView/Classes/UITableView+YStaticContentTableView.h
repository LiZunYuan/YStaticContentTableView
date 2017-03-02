//
//  UITableView+YStaticContentTableView.h
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import <UIKit/UIKit.h>
#import "YStaticContentTableViewSection.h"

@interface UITableView (YStaticContentTableView) <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSString *headerText;
@property (nonatomic, strong) NSString *footerText;

- (void)enableStaticTableView;
- (void)enableMixStaticTableView:(id<UITableViewDelegate,UITableViewDataSource>)delegate;

- (YStaticContentTableViewSection *)addSection:(YStaticContentTableViewControllerAddSectionBlock)b;

- (YStaticContentTableViewSection *)insertSection:(YStaticContentTableViewControllerAddSectionBlock)b
               atIndex:(NSUInteger)sectionIndex;

- (YStaticContentTableViewSection *)insertSection:(YStaticContentTableViewControllerAddSectionBlock)b
               atIndex:(NSUInteger)sectionIndex
              animated:(BOOL)animated;

- (YStaticContentTableViewSection *)insertSection:(YStaticContentTableViewControllerAddSectionBlock)b
               atIndex:(NSUInteger)sectionIndex animated:(BOOL)animated
            updateView:(BOOL)updateView;

- (void)removeAllSections;

- (void)removeSectionAtIndex:(NSUInteger)sectionIndex;
- (void)removeSectionAtIndex:(NSUInteger)sectionIndex animated:(BOOL)animated;

- (void)reloadSectionAtIndex:(NSUInteger)sectionIndex;
- (void)reloadSectionAtIndex:(NSUInteger)sectionIndex animated:(BOOL)animated;

- (YStaticContentTableViewSection *)sectionAtIndex:(NSUInteger)sectionIndex;

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
        atIndexPath:(NSIndexPath *)indexPath
           animated:(BOOL)animated;

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
       whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
        atIndexPath:(NSIndexPath *)indexPath
           animated:(BOOL)animated;


- (id<UITableViewDelegate,UITableViewDataSource>)staticTableViewDelegate;

@end
