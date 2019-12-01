//
//  DKNetFileParam.h
//  DaKaXingQiu
//
//  Created by ljp on 2018/10/30.
//  Copyright © 2018年 Micro credit information technology co., LTD. Shenzhen Qianhai. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface DKNetFileParam : NSObject
/**
 *  上传文件的二进制数
 */
@property (nonatomic, strong) NSData *data;
/**
 *  上传的参数名称
 */
@property (nonatomic, copy) NSString *name;
/**
 *  上传文件的 服务器名称
 */
@property (nonatomic, copy) NSString *fileName;
/**
 *  上传文件的类型
 */
@property (nonatomic, copy) NSString *mimeType;

@end

NS_ASSUME_NONNULL_END
