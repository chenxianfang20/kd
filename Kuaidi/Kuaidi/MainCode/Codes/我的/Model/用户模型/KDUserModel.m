//
//  KDInfoModel.m
//  Kuaidi
//
//  Created by cxf on 2019/8/20.
//  Copyright © 2019年 ios01. All rights reserved.
//

#import "KDUserModel.h"

@implementation KDUserModel
+(instancetype)ModelWithDict:(NSDictionary *)dict
{
    KDUserModel *model=[[self alloc]init];
    
    model.mobile=dict[@"mobile"];
    model.user_nickname=dict[@"user_nickname"];
    model.score=dict[@"score"];
    model.coin=dict[@"coin"];
    model.balance=dict[@"balance"];
    model.user_login=dict[@"user_login"];
    model.user_status=dict[@"user_status"];
    model.sex=dict[@"sex"];
    model.avatar=dict[@"avatar"];
    model.userId=dict[@"id"];
    return model;
}


-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_token forKey:@"token"];
    [encoder encodeObject:_mobile forKey:@"mobile"];
    [encoder encodeObject:_user_nickname forKey:@"user_nickname"];
    [encoder encodeObject:_score forKey:@"score"];
    [encoder encodeObject:_coin forKey:@"coin"];
    [encoder encodeObject:_balance forKey:@"balance"];
    [encoder encodeObject:_user_login forKey:@"user_login"];
    [encoder encodeObject:_user_status forKey:@"user_status"];
    [encoder encodeObject:_sex forKey:@"sex"];
    [encoder encodeObject:_avatar forKey:@"avatar"];
    [encoder encodeObject:_userId forKey:@"userId"];
}

-(instancetype)initWithCoder:(NSCoder *)decoder
{
    if (self=[super init]) {
        _token=[decoder decodeObjectForKey:@"token"];
        _mobile=[decoder decodeObjectForKey:@"mobile"];
        _user_nickname=[decoder decodeObjectForKey:@"user_nickname"];
        _score=[decoder decodeObjectForKey:@"score"];
        _coin=[decoder decodeObjectForKey:@"coin"];
        _balance=[decoder decodeObjectForKey:@"balance"];
        _user_login=[decoder decodeObjectForKey:@"user_login"];
        _user_status=[decoder decodeObjectForKey:@"user_status"];
        
        _sex=[decoder decodeObjectForKey:@"sex"];
        _avatar=[decoder decodeObjectForKey:@"avatar"];
        _userId=[decoder decodeObjectForKey:@"userId"];
    }
    return self;
}

@end
