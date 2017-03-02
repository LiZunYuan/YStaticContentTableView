#import "YStaticContentTableViewCell.h"
#import "objc/runtime.h"
#import "YStaticContentTableViewCell+Private.h"

@implementation YStaticContentTableViewCell

- (id)init {
	self = [super init];
	if(!self) return nil;

	self.cellHeight = UITableViewAutomaticDimension;
	self.tableViewCellSubclass = [UITableViewCell class];
	self.cellStyle = UITableViewCellStyleDefault;

    self.editingStyle = UITableViewCellEditingStyleNone;
    self.editable = NO;
    self.moveable = NO;
    
    self.layoutType = YStaticContentLayoutTypeFrame;
    self.heightCacheType = YStaticContentHeightCacheTypeIndexPath;

	return self;
}

- (NSString *)description {
    NSMutableString *str = [NSMutableString stringWithString:@"<YStaticContentTableViewCell"];

    [str appendFormat:@" reuseIdentifier='%@'", self.reuseIdentifier];
    [str appendFormat:@" tableViewCellSubclass='%@'", self.tableViewCellSubclass];
    [str appendFormat:@" cellHeight='%f'", self.cellHeight];
    [str appendString:@">"];

    return [NSString stringWithString:str];
}

- (NSString *)reuseIdentifier
{
    if (!_reuseIdentifier) {
        _reuseIdentifier = [NSString stringWithFormat:@"YStaticContentTableViewCell-%@",NSStringFromClass(self.tableViewCellSubclass)];
    }
    return _reuseIdentifier;
}

- (NSIndexPath *)indexPath
{
     return objc_getAssociatedObject(self, &YStaticContentTableViewCellIndexPathKey);
}

@end
