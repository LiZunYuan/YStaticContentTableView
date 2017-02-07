//
//  YStaticContentTableViewSection.m
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import "YStaticContentTableViewSection.h"

@interface YStaticContentTableViewSection()


@property (nonatomic, strong) NSMutableArray<YStaticContentTableViewCell *> *staticContentCells;

@end

@implementation YStaticContentTableViewSection

- (void)addCell:(YStaticContentTableViewCellBlock)configurationBlock {
    [self addCell:configurationBlock whenSelected:nil];
}

- (void)addCell:(YStaticContentTableViewCellBlock)configurationBlock whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock {
    YStaticContentTableViewCell *staticContentCell = [[YStaticContentTableViewCell alloc] init];
    staticContentCell.configureBlock = configurationBlock;
    staticContentCell.whenSelectedBlock = whenSelectedBlock;
    configurationBlock(staticContentCell, nil, nil);
    [self.staticContentCells addObject:staticContentCell];
    [self _updateCellIndexPaths];
}

- (void)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
       whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
        atIndexPath:(NSIndexPath *)indexPath
           animated:(BOOL)animated {
    [self insertCell:configurationBlock whenSelected:whenSelectedBlock atIndexPath:indexPath animated:animated updateView:YES];
}

- (void)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
       whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
        atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated updateView:(BOOL)updateView {
    YStaticContentTableViewCell *staticContentCell = [[YStaticContentTableViewCell alloc] init];
    staticContentCell.configureBlock = configurationBlock;
    staticContentCell.whenSelectedBlock = whenSelectedBlock;
    staticContentCell.indexPath = indexPath;
    configurationBlock(staticContentCell, nil, indexPath);
    [self.staticContentCells insertObject:staticContentCell atIndex:indexPath.row];
    [self _updateCellIndexPaths];
    
    if (updateView) {
        if(animated) {
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [self.tableView reloadData];
        }
    }
}

- (void)addCell:(YStaticContentTableViewCellBlock)configurationBlock
        animated:(BOOL)animated {
    YStaticContentTableViewCell *staticContentCell = [[YStaticContentTableViewCell alloc] init];
    staticContentCell.configureBlock = configurationBlock;
    staticContentCell.indexPath = [NSIndexPath indexPathForRow:[self.staticContentCells count] inSection:self.sectionIndex];
    configurationBlock(staticContentCell, nil, staticContentCell.indexPath);
    [self.staticContentCells addObject:staticContentCell];
    
    if(animated) {
        [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:staticContentCell.indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
    } else {
        [self.tableView reloadData];
    }
}

- (void)reloadCellAtIndex:(NSUInteger)rowIndex {
    [self reloadCellAtIndex:rowIndex animated:YES];
}

- (void)reloadCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated {
    [self _updateCellIndexPaths];
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowIndex inSection:self.sectionIndex]]
                          withRowAnimation:animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone];
}

- (void)removeCellAtIndex:(NSUInteger)rowIndex {
    [self removeCellAtIndex:rowIndex animated:YES];
}
- (void)removeCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated {
    NSMutableArray *cells = [self.staticContentCells mutableCopy];
    [cells removeObjectAtIndex:rowIndex];
    self.staticContentCells = [NSArray arrayWithArray:cells];
    
    if(animated) {
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowIndex inSection:self.sectionIndex]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.4];
    } else {
        [self.tableView reloadData];
    }
}

- (void) removeAllCells {
    if(self.staticContentCells) {
        self.staticContentCells = nil;
        self.staticContentCells = [NSArray array];
    }
}

- (NSString *)description {
    NSMutableString *str = [NSMutableString stringWithString:@"<JMStaticContentTableViewSection"];
    
    [str appendFormat:@" sectionIndex='%ld'", (long)self.sectionIndex];
    if(self.headerTitle) [str appendFormat:@" headerTitle='%@'", self.headerTitle];
    if(self.footerTitle) [str appendFormat:@" footerTitle='%@'", self.footerTitle];
    
    for(YStaticContentTableViewCell *cell in self.staticContentCells) {
        [str appendFormat:@"\n      %@", [cell description]];
    }
    
    [str appendString:@"\n>"];
    
    return [NSString stringWithString:str];
}

- (void)_updateCellIndexPaths {
    NSInteger updatedRowIndex = 0;
    for(YStaticContentTableViewCell *cell in self.staticContentCells) {
        cell.indexPath = [NSIndexPath indexPathForRow:updatedRowIndex inSection:self.sectionIndex];
        updatedRowIndex++;
    }
}

- (NSInteger)numberOfRowInSection {
    return [self staticContentCells].count;
}

- (YStaticContentTableViewCell *)cellForRow:(NSInteger)row
{
    return [self staticContentCells][row];
}

#pragma mark - lazyload
- (NSMutableArray<YStaticContentTableViewCell *> *)staticContentCells
{
    if (_staticContentCells == nil) {
        _staticContentCells = [NSMutableArray array];
    }
    return _staticContentCells;
}

@end
