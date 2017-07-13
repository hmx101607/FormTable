//
//  FTCollectionViewController.m
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import "FTCollectionViewController.h"
#import "FTFormView.h"
#import "FTFormModel.h"

@interface FTCollectionViewController ()

/** <##> */
@property (strong, nonatomic) FTFormView *formView;

/** <##> */
@property (strong, nonatomic) NSMutableArray *itemArray;

@end

@implementation FTCollectionViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    FTFormView *formView = [FTFormView new];
    FTFormModel *formModel = self.itemArray.firstObject;
    formView.frame = CGRectMake(0, 64.f, SCREEN_WIDTH, formModel.rowHeight * self.itemArray.count);
    formView.formModelArray = [self.itemArray copy];
    [self.view addSubview:formView];
}


- (NSMutableArray *)itemArray {
    if (!_itemArray) {
        _itemArray = [NSMutableArray array];
        
        for (NSInteger j = 0; j < 10; j++) {
            FTFormModel *formModel = [[FTFormModel alloc] init];
            formModel.rowHeight = 40.f;
            NSMutableArray *formArray = [NSMutableArray array];
            for (NSInteger i = 0; i < 4; i++) {
                FTFormItemModel *formItemModel = [[FTFormItemModel alloc] init];
                formItemModel.widthRate = i + 1;
                formItemModel.title = [NSString stringWithFormat:@"%li",i];
                if (j == 0) {
                    formItemModel.textColor = [UIColor blueColor];
                }
                [formArray addObject:formItemModel];
            }
            formModel.formItemArray = [formArray copy];
            [_itemArray addObject:formModel];
        }
    }
    return _itemArray;
}


@end
