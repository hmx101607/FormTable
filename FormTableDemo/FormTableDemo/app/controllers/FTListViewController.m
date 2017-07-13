//
//  FTListViewController.m
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import "FTListViewController.h"
#import "FTListTableViewCell.h"

@interface FTListViewController ()
<
UITableViewDelegate,
UITableViewDataSource
>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation FTListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.rowHeight = 80.f;
    [self.tableView registerNib:[FTListTableViewCell nib] forCellReuseIdentifier:[FTListTableViewCell reuseIdentifier]];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FTListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[FTListTableViewCell reuseIdentifier] forIndexPath:indexPath];
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
