//
//  TemplateEntity.m
//  FDTemplateLayoutCellStudy
//
//  Created by 曹学亮 on 16/5/7.
//  Copyright © 2016年 xueliang cao. All rights reserved.
//

#import "TemplateEntity.h"

@implementation TemplateEntity

- (instancetype)initWithDictionary:(NSDictionary *)dictionary{
    self = [super init];
    if (self) {
        _identifier = [self uniqueIdentifier];
        _title = dictionary[@"title"];
        _content = dictionary[@"content"];
        _time = dictionary[@"time"];
        _userName = dictionary[@"username"];
        _imageName = dictionary[@"imageName"];
    }
    return self;
}

- (NSString *)uniqueIdentifier{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}

@end
