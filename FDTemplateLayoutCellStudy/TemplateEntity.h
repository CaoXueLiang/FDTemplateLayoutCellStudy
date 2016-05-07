//
//  TemplateEntity.h
//  FDTemplateLayoutCellStudy
//
//  Created by 曹学亮 on 16/5/7.
//  Copyright © 2016年 xueliang cao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TemplateEntity : NSObject

@property (nonatomic,copy) NSString *identifier;
@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *content;
@property (nonatomic,copy) NSString *userName;
@property (nonatomic,copy) NSString *time;
@property (nonatomic,copy) NSString *imageName;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
