//
//  HZIncidentStatisticsInfoModel.m
//  Pods
//
//  Created by mason on 2017/8/25.
//
//

#import "HZIncidentStatisticsInfoModel.h"

@implementation HZIncidentStatisticsInfoModel

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper {
    return @{
             @"riverName" : @"rvnm",
             @"riverType" : @"rivertp",
             @"addressVcd" : @"addvcd",
             @"startTime" : @"stm",
             @"endTime" : @"etm"
             };
}



@end
