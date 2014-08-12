//
//  IndexModel.h
//  YDNetwork
//
//  Created by _liuty_ on 14-8-12.
//  Copyright (c) 2014年 _liuty_. All rights reserved.
//

#import "JSONModel.h"

@protocol TopModel
@end

@interface TopModel : JSONModel
@property (nonatomic, strong) NSString *abtest;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *url;
@property (nonatomic, strong) NSString *summary;
@end

@protocol DataModel
@end

@interface DataModel : JSONModel
@property (nonatomic, strong) NSString<Optional> *abtest;
@property (nonatomic, strong) NSString *style;
@property (nonatomic, strong) NSString *dataID;
//@property (nonatomic) NSString *url;
@property (nonatomic, strong) NSString<Optional> *summary;
@property (nonatomic, strong) NSString<Optional> *title;
@property (nonatomic, strong) NSString<Optional> *type;
@end

@interface IndexModel : JSONModel

@property (nonatomic, strong) NSArray<DataModel, ConvertOnDemand> *data;
@property (nonatomic, strong) NSArray<TopModel, ConvertOnDemand> *top;

@end
