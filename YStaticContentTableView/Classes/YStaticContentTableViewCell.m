#import "YStaticContentTableViewCell.h"

@implementation YStaticContentTableViewCell


@synthesize cellHeight = _cellHeight;
@synthesize cellStyle = _cellStyle;
@synthesize tableViewCellSubclass = _tableViewCellSubclass;

@synthesize configureBlock = _configureBlock;
@synthesize whenSelectedBlock = _whenSelectedBlock;

@synthesize editingStyle = _editingStyle;
@synthesize editable = _editable;
@synthesize moveable = _moveable;

- (id)init {
	self = [super init];
	if(!self) return nil;

	self.cellHeight = UITableViewAutomaticDimension;
	self.tableViewCellSubclass = [UITableViewCell class];
	self.cellStyle = UITableViewCellStyleDefault;

    self.editingStyle = UITableViewCellEditingStyleNone;
    self.editable = NO;
    self.moveable = NO;

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

@end
