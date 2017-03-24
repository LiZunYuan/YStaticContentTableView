//
//  UITableView+YStaticContentTableView.h
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import <UIKit/UIKit.h>
#import "YStaticContentTableViewSection.h"

@interface UITableView (YStaticContentTableView)

- (void)y_enableStaticTableView;
- (void)y_enableMixStaticTableView:(id <UITableViewDelegate>)delegate dataSource:(id<UITableViewDataSource>)dataSource;

- (YStaticContentTableViewSection *)y_addSection:(YStaticContentTableViewControllerAddSectionBlock)b;

- (YStaticContentTableViewSection *)y_insertSection:(YStaticContentTableViewControllerAddSectionBlock)b
                                            atIndex:(NSUInteger)sectionIndex;

- (YStaticContentTableViewSection *)y_insertSection:(YStaticContentTableViewControllerAddSectionBlock)b
                                            atIndex:(NSUInteger)sectionIndex
                                           animated:(BOOL)animated;

- (YStaticContentTableViewSection *)y_insertSection:(YStaticContentTableViewControllerAddSectionBlock)b
                                            atIndex:(NSUInteger)sectionIndex animated:(BOOL)animated
                                         updateView:(BOOL)updateView;

- (void)y_removeAllSections;

- (void)y_removeSectionAtIndex:(NSUInteger)sectionIndex;
- (void)y_removeSectionAtIndex:(NSUInteger)sectionIndex animated:(BOOL)animated;

- (void)y_reloadSectionAtIndex:(NSUInteger)sectionIndex;
- (void)y_reloadSectionAtIndex:(NSUInteger)sectionIndex animated:(BOOL)animated;

- (YStaticContentTableViewSection *)y_sectionAtIndex:(NSUInteger)sectionIndex;

- (YStaticContentTableViewCellExtraInfo *)y_insertCell:(YStaticContentTableViewCellBlock)configurationBlock
                                           atIndexPath:(NSIndexPath *)indexPath
                                              animated:(BOOL)animated;

- (YStaticContentTableViewCellExtraInfo *)y_insertCell:(YStaticContentTableViewCellBlock)configurationBlock
                                          whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
                                           atIndexPath:(NSIndexPath *)indexPath
                                              animated:(BOOL)animated;


- (id<UITableViewDataSource>)y_staticTableViewDataSource;
- (id<UITableViewDelegate>)y_staticTableViewDelegate;

@end
