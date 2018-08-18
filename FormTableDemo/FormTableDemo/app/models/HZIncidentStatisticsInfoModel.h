//
//  HZIncidentStatisticsInfoModel.h
//  Pods
//
//  Created by mason on 2017/8/25.
//
//

#import <Foundation/Foundation.h>

@interface HZIncidentStatisticsInfoModel : NSObject<YYModel>

/** aid */
@property (strong, nonatomic) NSString *aid;
/** 河流名称 */
@property (strong, nonatomic) NSString *riverName;
/** 河流类型 */
@property (strong, nonatomic) NSString *riverType;
/** 地址编码 */
@property (strong, nonatomic) NSString *addressVcd;
/** 开始时间 */
@property (strong, nonatomic) NSString *startTime;
/** 结束时间 */
@property (strong, nonatomic) NSString *endTime;
/** <##> */
@property (strong, nonatomic) NSString *tss;
/** <##> */
@property (strong, nonatomic) NSString *ycl;
/** <##> */
@property (strong, nonatomic) NSString *clz;
/** <##> */
@property (strong, nonatomic) NSString *dcl;
/** <##> */
@property (strong, nonatomic) NSString *cll;



@end













