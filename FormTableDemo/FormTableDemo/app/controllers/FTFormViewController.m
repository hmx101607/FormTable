//
//  FTFormViewController.m
//  FormTableDemo
//
//  Created by mason on 2017/7/13.
//
//

#import "FTFormViewController.h"
#import "FTFormView.h"
#import "FTFormModel.h"
#import "FTUtil.h"

@interface FTFormViewController ()

/** 表格<##> */
@property (strong, nonatomic) FTFormView *formView;
/** 表格总数据=表格头+表格内容 */
@property (strong, nonatomic) NSMutableArray *formItemList;
/** 表格头：原数据，未处理 */
@property (strong, nonatomic) NSArray *formTitleList;
/** 表格内容：原数据，未处理
 {
     aid = 270b0971a73d4002a6f61ddb753752f9;
     cll = 0;
     clz = 0;
     dcl = 0;
     rivertp = 1;
     rvnm = "长江";
     tss = 0;
     ycl = 0;
 }
 */
@property (strong, nonatomic) NSMutableArray *formContentList;
/** 表格内容
 <__NSArrayI 0x604000279140>(
     长江,
     0,
     0,
     0,
     0
 )
 */
@property (strong, nonatomic) NSMutableArray *dataSource;

@end

@implementation FTFormViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    FTFormView *formView = [FTFormView new];
    self.formView = formView;
    [self.view addSubview:formView];
    
    NSArray *json = [FTUtil readLocalFileWithName:@"json" fileType:@"txt"];
    [self.formContentList addObjectsFromArray:json];
    [self configFormDataSource];
    //获取第一个model,取出设定的行高，计算出总高度，如果每行的高度不同，则需要循环获取
    FTFormModel *formModel = self.formItemList.firstObject;
    formView.frame = CGRectMake(0, 64.f, SCREEN_WIDTH, formModel.rowHeight * self.formItemList.count);
}

- (void) configFormDataSource {
    for (NSInteger i = 0; i < self.formContentList.count; i++) {
        NSDictionary *formModelDic = self.formContentList[i];
        [self.dataSource addObject:@[formModelDic[@"rvnm"], formModelDic[@"dcl"], formModelDic[@"clz"],formModelDic[@"ycl"], formModelDic[@"cll"]]];
    }
    [self configFormItemDataSource];
}

- (void) configFormItemDataSource {
    [self.formItemList removeAllObjects];
    {
        //处理第一行表头数据
        //外层model:处理行高，边距等整行的外观数据
        FTFormModel *titleFormModel = [[FTFormModel alloc] init];
        titleFormModel.rowHeight = 35.f;
        titleFormModel.index = 0;
        NSMutableArray *titleFormArray = [NSMutableArray array];
        for (NSInteger i = 0; i < self.formTitleList.count; i++) {
            //内层model:处理行内每个小块的样式，如文字居中，颜色，大小等
            FTFormItemModel *formItemModel = [[FTFormItemModel alloc] init];
            NSDictionary *dic = self.formTitleList[i];
            formItemModel.widthRate = [dic[@"widthRate"] integerValue];
            formItemModel.title = dic[@"title"];
            formItemModel.textColor = UIColorHex(3691e5);
            formItemModel.textAlignment = NSTextAlignmentCenter;
            formItemModel.fontSize = 11.f;
            [titleFormArray addObject:formItemModel];
        }
        titleFormModel.formItemArray = [titleFormArray copy];
        [self.formItemList addObject:titleFormModel];
    }
    //+++++++++++++++++++++++++上面与下面在逻辑上其实是一致的：其实可以整合一下，这里为了简单理解，不整合了+++++++++++++++++++++++++
    {
        //除表头外的表格数据
        for (NSInteger j = 0; j < self.dataSource.count; j++) {
            FTFormModel *formModel = [[FTFormModel alloc] init];
            formModel.rowHeight = 35.f;
            formModel.index = 0;
            NSArray *array = self.dataSource[j];
            NSMutableArray *formArray = [NSMutableArray array];
            for (NSInteger i = 0; i < self.formTitleList.count; i++) {
                FTFormItemModel *formItemModel = [[FTFormItemModel alloc] init];
                NSDictionary *dic = self.formTitleList[i];
                formItemModel.widthRate = [dic[@"widthRate"] integerValue];
                formItemModel.title = [NSString stringWithFormat:@"%@",array[i]];
                formItemModel.textColor = UIColorHex(545454);
                formItemModel.textAlignment = NSTextAlignmentCenter;
                formItemModel.fontSize = 11.f;
                [formArray addObject:formItemModel];
            }
            formModel.formItemArray = [formArray copy];
            [self.formItemList addObject:formModel];
        }
    }
    [self.formView setFormModelArray:self.formItemList];
}

- (NSArray *)formTitleList {
    if (!_formTitleList) {
        _formTitleList = @[@{@"title":@"河道名称",@"widthRate":@(1)},
                           @{@"title":@"受理数",@"widthRate":@(1)},
                           @{@"title":@"处理数",@"widthRate":@(1)},
                           @{@"title":@"结案数",@"widthRate":@(1)},
                           @{@"title":@"处理率(%)",@"widthRate":@(1.5)}];
    }
    return _formTitleList;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (NSMutableArray *)formItemList {
    if (!_formItemList) {
        _formItemList = [NSMutableArray array];
    }
    return _formItemList;
}

- (NSMutableArray *)formContentList {
    if (!_formContentList) {
        _formContentList = [NSMutableArray array];
        
    }
    return _formContentList;
}

@end
