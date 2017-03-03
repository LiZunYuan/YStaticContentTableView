//
//  YStaticContentTableViewSection.m
//  Pods
//
//  Created by 李遵源 on 2017/2/7.
//
//

#import "YStaticContentTableViewSection.h"
#import "YStaticContentTableViewCellExtraInfo+Private.h"

@interface YStaticContentTableViewSection()

@property (nonatomic, strong) NSMutableSet<NSString *> *reuseIdentifiers;
@property (nonatomic, strong) NSMutableArray<YStaticContentTableViewCellExtraInfo *> *staticContentCells;

@end

@implementation YStaticContentTableViewSection

- (YStaticContentTableViewCellExtraInfo *)addCell:(YStaticContentTableViewCellBlock)configurationBlock {
    return [self addCell:configurationBlock whenSelected:nil];
}

- (YStaticContentTableViewCellExtraInfo *)addCell:(YStaticContentTableViewCellBlock)configurationBlock whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock {
    return [self insertCell:configurationBlock whenSelected:whenSelectedBlock atIndexPath:[NSIndexPath indexPathForRow:self.staticContentCells.count inSection:0] animated:NO updateView:NO];
}

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
       whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
        atIndexPath:(NSIndexPath *)indexPath
           animated:(BOOL)animated {
    return [self insertCell:configurationBlock whenSelected:whenSelectedBlock atIndexPath:indexPath animated:animated updateView:YES];
}

- (YStaticContentTableViewCellExtraInfo *)insertCell:(YStaticContentTableViewCellBlock)configurationBlock
       whenSelected:(YStaticContentTableViewCellWhenSelectedBlock)whenSelectedBlock
        atIndexPath:(NSIndexPath *)indexPath animated:(BOOL)animated updateView:(BOOL)updateView {
    YStaticContentTableViewCellExtraInfo *staticContentCell = [[YStaticContentTableViewCellExtraInfo alloc] init];
    staticContentCell.configureBlock = configurationBlock;
    staticContentCell.whenSelectedBlock = whenSelectedBlock;
    configurationBlock(staticContentCell, nil, indexPath);
    [self.staticContentCells insertObject:staticContentCell atIndex:indexPath.row];
    
    if (![self.reuseIdentifiers containsObject:staticContentCell.reuseIdentifier]) {
        if (staticContentCell.tableViewCellSubclass) {
            [self.tableView registerClass:staticContentCell.tableViewCellSubclass forCellReuseIdentifier:staticContentCell.reuseIdentifier];
        } else {
            [self.tableView registerNib:staticContentCell.tableViewCellNib forCellReuseIdentifier:staticContentCell.reuseIdentifier];
        }
        [self.reuseIdentifiers addObject:staticContentCell.reuseIdentifier];
    }
    
    if (updateView) {
        if(animated) {
            [self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        } else {
            [self.tableView reloadData];
        }
    }
    return staticContentCell;
}

- (YStaticContentTableViewCellExtraInfo *)addCell:(YStaticContentTableViewCellBlock)configurationBlock
        animated:(BOOL)animated {
    return [self insertCell:configurationBlock whenSelected:nil atIndexPath:[NSIndexPath indexPathForRow:self.staticContentCells.count inSection:0] animated:animated updateView:YES];
}

- (void)reloadCellAtIndex:(NSUInteger)rowIndex {
    [self reloadCellAtIndex:rowIndex animated:YES];
}

- (void)reloadCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated {
    [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:rowIndex inSection:self.sectionIndex]]
                          withRowAnimation:animated ? UITableViewRowAnimationAutomatic : UITableViewRowAnimationNone];
}

- (void)removeCellAtIndex:(NSUInteger)rowIndex {
    [self removeCellAtIndex:rowIndex animated:NO];
}
- (void)removeCellAtIndex:(NSUInteger)rowIndex animated:(BOOL)animated {
    [self.staticContentCells removeObjectAtIndex:rowIndex];
    
    if(animated) {
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowIndex inSection:self.sectionIndex]] withRowAnimation:UITableViewRowAnimationAutomatic];
        [self.tableView performSelector:@selector(reloadData) withObject:nil afterDelay:0.4];
    } else {
        [self.tableView reloadData];
    }
}

- (void)removeAllCells {
    if(self.staticContentCells) {
        [self.staticContentCells removeAllObjects];
    }
}

- (NSString *)description {
    NSMutableString *str = [NSMutableString stringWithString:@"<JMStaticContentTableViewSection"];
    
    [str appendFormat:@" sectionIndex='%ld'", (long)self.sectionIndex];
    if(self.headerTitle) [str appendFormat:@" headerTitle='%@'", self.headerTitle];
    if(self.footerTitle) [str appendFormat:@" footerTitle='%@'", self.footerTitle];
    
    for(YStaticContentTableViewCellExtraInfo *cell in self.staticContentCells) {
        [str appendFormat:@"\n      %@", [cell description]];
    }
    [str appendString:@"\n>"];
    
    return [NSString stringWithString:str];
}

- (NSInteger)numberOfRowInSection {
    return [self staticContentCells].count;
}

- (YStaticContentTableViewCellExtraInfo *)cellForRow:(NSInteger)row
{
    return [self staticContentCells][row];
}

#pragma mark - lazyload
- (NSMutableArray<YStaticContentTableViewCellExtraInfo *> *)staticContentCells
{
    if (_staticContentCells == nil) {
        _staticContentCells = [NSMutableArray array];
    }
    return _staticContentCells;
}

- (NSMutableSet<NSString *> *)reuseIdentifiers
{
    if (_reuseIdentifiers == nil) {
        _reuseIdentifiers = [NSMutableSet set];
    }
    return _reuseIdentifiers;
}

@end
