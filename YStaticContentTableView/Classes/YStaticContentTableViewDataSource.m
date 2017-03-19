//
//  YStaticContentTableViewDataSource.m
//  Pods
//
//  Created by 李遵源 on 2017/3/6.
//
//

#import "YStaticContentTableViewDataSource.h"
#import "UITableView+YStaticContentTableView.h"
#import "UITableView+YStaticContentTableViewPrivate.h"

@interface YStaticContentTableViewDataSource()

@end

@implementation YStaticContentTableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return tableView.staticContentSections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    YStaticContentTableViewSection *sectionContent = [tableView.staticContentSections objectAtIndex:section];
    return [sectionContent numberOfRowInSection];
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
    YStaticContentTableViewCellExtraInfo *cellContent = [sectionContent cellInfoForRow:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellContent.reuseIdentifier forIndexPath:indexPath];
    
    if (cell == nil) {
        cell = [[[cellContent tableViewCellSubclass] alloc] initWithStyle:cellContent.cellStyle reuseIdentifier:cellContent.reuseIdentifier];
    }
    
    cellContent.configureBlock(cellContent, cell, indexPath);
    
    return cell;
}


@end
