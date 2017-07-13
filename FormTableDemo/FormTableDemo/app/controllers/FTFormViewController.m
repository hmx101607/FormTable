//
//  FTFormViewController.m
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import "FTFormViewController.h"
#import "FTFormTableViewCell.h"

@interface FTFormViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>

@property (strong, nonatomic) UITableView *tableView;

@end

@implementation FTFormViewController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupTableView];
}

- (void)setupTableView {
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT) style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    self.tableView = tableView;
    tableView.delegate = self;
    tableView.dataSource = self;
    [tableView registerClass:[FTFormTableViewCell class] forCellReuseIdentifier:NSStringFromClass([FTFormTableViewCell class])];
    tableView.tableFooterView = [UIView new];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTFormTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([FTFormTableViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell = [[FTFormTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([FTFormTableViewCell class])];
    }
    cell.backgroundColor = indexPath.row % 2 == 0 ? [UIColor greenColor] : [UIColor blueColor];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.f;
}








- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
