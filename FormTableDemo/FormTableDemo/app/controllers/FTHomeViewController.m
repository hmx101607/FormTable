//
//  FTHomeViewController.m
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import "FTHomeViewController.h"
#import "FTFormViewController.h"
#import "FTListViewController.h"
#import "FTCollectionViewController.h"

@interface FTHomeViewController ()

@end

@implementation FTHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)formAction:(UIButton *)sender {
    FTFormViewController *homeVC = [FTFormViewController create];
    
    [self.navigationController pushViewController:homeVC animated:YES];
    
}

- (IBAction)listAction:(UIButton *)sender {
    FTListViewController *listVC = [FTListViewController create];
    
    [self.navigationController pushViewController:listVC animated:YES];
}

- (IBAction)collectionViewAction:(UIButton *)sender {
    FTCollectionViewController *collectionVC = [FTCollectionViewController new];
    
    [self.navigationController pushViewController:collectionVC animated:YES];
}


@end
