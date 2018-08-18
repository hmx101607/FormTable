//
//  FTUtil.m
//  FormTableDemo
//
//  Created by mason on 2018/8/19.
//

#import "FTUtil.h"

@implementation FTUtil

+ (NSArray *)readLocalFileWithName:(NSString *)name fileType:(NSString *)fileType{
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:fileType];
    // 将文件数据化
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    // 对数据进行JSON格式化并返回字典形式
    return [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}

@end
