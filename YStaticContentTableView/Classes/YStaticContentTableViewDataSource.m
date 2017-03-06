//
//  YStaticContentTableViewDataSource.m
//  Pods
//
//  Created by 李遵源 on 2017/3/6.
//
//

#import "YStaticContentTableViewDataSource.h"
#import "UITableView+FDTemplateLayoutCell.h"
#import "UITableView+YStaticContentTableView.h"
#import "UITableView+YStaticContentTableViewPrivate.h"

@interface YStaticContentTableViewDataSource()<UITableViewDataSource>

@end

@implementation YStaticContentTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView.staticContentSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YStaticContentTableViewSection *sectionContent = [tableView.staticContentSections objectAtIndex:section];
    return [sectionContent numberOfRowInSection];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[indexPath.section];
    YStaticContentTableViewCellExtraInfo *cellContent = [sectionContent cellForRow:indexPath.row];
    
    if (cellContent.cellHeight == -1) {
        if (tableView.rowHeight == -1) {
            // Hit cache
            if (cellContent.heightCacheType == YStaticContentHeightCacheTypeIndexPath) {
                if ([tableView.fd_indexPathHeightCache existsHeightAtIndexPath:indexPath]) {
                    return [tableView.fd_indexPathHeightCache heightForIndexPath:indexPath];
                }
            } else {
                if ([tableView.fd_keyedHeightCache existsHeightForKey:cellContent.reuseIdentifier]) {
                    return [tableView.fd_keyedHeightCache heightForKey:cellContent.reuseIdentifier];
                }
            }
            CGFloat cellHeight = [tableView fd_heightForCellWithIdentifier:cellContent.reuseIdentifier configuration:^(UITableViewCell *cell) {
                cellContent.configureBlock(nil, cell, indexPath);
                //如果一个约束都没事 就变成frameLayout
                if (cell.constraints.count == 0) {
                    cell.fd_enforceFrameLayout = YES;
                } else {
                    if (cellContent.layoutType == YStaticContentLayoutTypeFrame) {
                        cell.fd_enforceFrameLayout = YES;
                    } else {
                        cell.fd_enforceFrameLayout = NO;
                    }
                }
            }];
            
            if (cellContent.heightCacheType == YStaticContentHeightCacheTypeIndexPath) {
                [tableView.fd_indexPathHeightCache cacheHeight:cellHeight byIndexPath:indexPath];
            } else {
                [tableView.fd_keyedHeightCache cacheHeight:cellHeight byKey:cellContent.reuseIdentifier];
            }
            return cellHeight;
        }
        return tableView.rowHeight;
    }
    return cellContent.cellHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[section];
    UIView *headerView = sectionContent.headerView;
    if (headerView) {
        return CGRectGetHeight(headerView.frame);
    }
    
    return UITableViewAutomaticDimension;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[section];
    UIView *footerView = sectionContent.footerView;
    if (footerView) {
        return CGRectGetHeight(footerView.frame);
    }
    
    return UITableViewAutomaticDimension;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[section];
    return sectionContent.headerTitle;
}
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[section];
    return sectionContent.footerTitle;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[section];
    return sectionContent.headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[section];
    return sectionContent.footerView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[indexPath.section];
    YStaticContentTableViewCellExtraInfo *cellContent = [sectionContent cellForRow:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellContent.reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[cellContent tableViewCellSubclass] alloc] initWithStyle:cellContent.cellStyle reuseIdentifier:cellContent.reuseIdentifier];
    }
    
    cellContent.configureBlock(cellContent, cell, indexPath);
    
    return cell;
}


@end
