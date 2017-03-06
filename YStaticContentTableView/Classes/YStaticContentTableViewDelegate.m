//
//  YStaticContentTableViewDelegate.m
//  Pods
//
//  Created by 李遵源 on 2017/3/6.
//
//

#import "YStaticContentTableViewDelegate.h"
#import "UITableView+YStaticContentTableViewPrivate.h"
#import "UITableView+YStaticContentTableView.h"

@interface YStaticContentTableViewDelegate()<UITableViewDelegate>

@end

@implementation YStaticContentTableViewDelegate

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[indexPath.section];
    YStaticContentTableViewCellExtraInfo *cellContent = [sectionContent cellForRow:indexPath.row];
    
    return cellContent.editingStyle;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[indexPath.section];
    YStaticContentTableViewCellExtraInfo *cellContent = [sectionContent cellForRow:indexPath.row];
    
    return cellContent.editable;
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[indexPath.section];
    YStaticContentTableViewCellExtraInfo *cellContent = [sectionContent cellForRow:indexPath.row];
    
    return cellContent.moveable;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    YStaticContentTableViewSection *sectionContent = tableView.staticContentSections[indexPath.section];
    YStaticContentTableViewCellExtraInfo *cellContent = [sectionContent cellForRow:indexPath.row];
    
    if(cellContent.whenSelectedBlock) {
        cellContent.whenSelectedBlock(indexPath);
    }
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [scrollView endEditing:YES];
}


@end
