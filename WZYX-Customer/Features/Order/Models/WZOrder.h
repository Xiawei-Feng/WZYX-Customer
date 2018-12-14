//
//  WZOrder.h
//  WZYX-Customer
//
//  Created by 祈越 on 2018/11/30.
//  Copyright © 2018 WZYX. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, WZOrderState) {
    WZOrderStateAllState,               // 所有状态
    WZOrderStateWaitingPayment,         // 待付款
    WZOrderStateWaitingParticipation,   // 待参与
    WZOrderStateWaitingComment,         // 待评价
    WZOrderStateOverdue,                // 已过期
    WZOrderStateCanceled,               // 已取消
    WZOrderStateRefunding,              // 退款中
    WZOrderStateRefunded,               // 已退款
    WZOrderStateFinished,               // 已完成
};

typedef NS_ENUM(NSUInteger, WZOrderPaymentMethod) {
    WZOrderPaymentMethodAlipay,
    WZOrderPaymentMethodWeChatPay,
    WZOrderPaymentMethodUnionPay,
};

@interface WZOrder : NSObject <NSCoding>

@property (copy, nonatomic) NSString *orderId;                      // 订单ID
@property (copy, nonatomic) NSString *orderTimeStamp;               // 订单时间戳
@property (assign, nonatomic) WZOrderState orderState;              // 订单状态

@property (copy, nonatomic) NSString *sponsorId;                    // 主办方ID
@property (copy, nonatomic) NSString *sponsorName;                  // 主办方名称

@property (copy, nonatomic) NSString *eventId;                      // 活动ID
@property (copy, nonatomic) NSString *eventAvatar;                  // 活动图片
@property (copy, nonatomic) NSString *eventTitle;                   // 活动标题
@property (copy, nonatomic) NSString *eventSeason;                  // 活动场次
@property (copy, nonatomic) NSString *eventPrice;                   // 活动单价

@property (copy, nonatomic) NSString *purchaseCount;                // 购买数量
@property (copy, nonatomic) NSString *orderDiscount;                // 订单优惠
@property (copy, nonatomic) NSString *orderAmount;                  // 订单总价

@property (assign, nonatomic) WZOrderPaymentMethod paymentMethod;   // 支付手段
@property (copy, nonatomic) NSString *paymentTimeStamp;             // 支付时间戳

@property (copy, nonatomic) NSString *certificationNumber;          // 凭证
@property (copy, nonatomic) NSString *myCommentId;                  // 我的评价ID

- (instancetype)initWithDataDictionary:(NSDictionary *)dataDictionary;

+ (void)loadOrderListWithOrderState:(WZOrderState)orderState success:(void (^)(NSMutableArray *orders))successBlock failure:(void (^)(NSString *userInfo))failureBlock;

+ (void)loadOrderWithId:(NSString *)orderId success:(void (^)(WZOrder *order))successBlock failure:(void (^)(NSString *userInfo))failureBlock;

+ (void)payOrder:(WZOrder *)order success:(void (^)(void))successBlock failure:(void (^)(NSString *userInfo))failureBlock;

+ (void)cancelOrder:(WZOrder *)order success:(void (^)(void))successBlock failure:(void (^)(NSString *userInfo))failureBlock;

+ (void)applyRefundWithOrder:(WZOrder *)order success:(void (^)(void))successBlock failure:(void (^)(NSString *userInfo))failureBlock;

+ (void)deleteOrder:(WZOrder *)order success:(void (^)(void))successBlock failure:(void (^)(NSString *userInfo))failureBlock;

// 仅测试用
+ (void)prepareTestData;
+ (void)addTestData;
+ (void)dropTestData;

@end

NS_ASSUME_NONNULL_END