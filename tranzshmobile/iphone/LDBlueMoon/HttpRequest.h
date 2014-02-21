
#import <Foundation/Foundation.h>

typedef void(^requestFinishBlock)(id result);
@interface HttpRequest : NSObject

//上传头像
+(void)requestWithUrl:(NSString*)urlString boday:(NSData*)data;
+(void)requestWithUrl:(NSString *)urlString params:(NSDictionary*)param block:(requestFinishBlock)block;
+(void)LoginWithID:(NSString*)Id PassWord:(NSString*)passWord Code:(NSString*)code Finsh:(requestFinishBlock)block;//用户名 密码 验证码；
@end
