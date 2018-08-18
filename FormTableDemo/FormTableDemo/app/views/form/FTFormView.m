//
//  FTFormView.m
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import "FTFormView.h"
#import "FTFormTableViewCell.h"

@interface FTFormView()
<
UITableViewDelegate,
UITableViewDataSource
>
/** tableView */
@property (strong, nonatomic) UITableView *tableView;

@end

@implementation FTFormView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor redColor];
        [self setupTableView];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.backgroundColor = [UIColor redColor];
    [self setupTableView];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    CGFloat margin = 0;//1.f / [UIScreen mainScreen].scale;
    self.tableView.frame = CGRectMake(margin, margin, self.width - 2 * margin, self.height - 2 * margin);
}

- (void)setFormModelArray:(NSArray<FTFormModel *> *)formModelArray {
    _formModelArray = formModelArray;
    [self.tableView reloadData];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    [self addSubview:tableView];
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.scrollEnabled = NO;
    tableView.contentInset = UIEdgeInsetsMake(0, 0, 0, 0);
    [tableView registerClass:[FTFormTableViewCell class] forCellReuseIdentifier:[FTFormTableViewCell reuseIdentifier]];
    tableView.separatorColor = UIColorHex(dedcd7);
    self.tableView = tableView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.formModelArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FTFormTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[FTFormTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[FTFormTableViewCell reuseIdentifier]];
    }
    cell.formModel = self.formModelArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTFormModel *formModel = self.formModelArray[indexPath.row];
    return formModel.rowHeight;
}


-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    FTFormModel *formModel = self.formModelArray[indexPath.row];
    CGFloat padding = tableView.width - formModel.separateLineWidth;
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, padding, 0, 0)];
    }
    
    if ([cell respondsToSelector:@selector(setPreservesSuperviewLayoutMargins:)]) {
        [cell setPreservesSuperviewLayoutMargins:NO];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setSeparatorInset:UIEdgeInsetsMake(0, padding, 0, 0)];
    }
}
@end
