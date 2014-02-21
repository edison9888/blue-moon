//
//  HttpRequest.m
//  tz_bluemoon_ios_iphone
//
//  Created by IceBoy on 13-12-23.
//  Copyright (c) 2013年 test. All rights reserved.
//

#import "HttpRequest.h"
#import "AFHTTPClient.h"
#import "JSONKit.h"
#import "LGModelData.h"
@implementation HttpRequest

+(void)requestWithUrl:(NSString *)urlString params:(NSDictionary*)param block:(requestFinishBlock)block{
    NSURL *url                   = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"GET"];
    NSLog(@"%@",url);
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
      
        block(result);
    }];}

+(void)LoginWithID:(NSString *)Id PassWord:(NSString *)passWord Code:(NSString *)code Finsh:(requestFinishBlock)block{
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:Id,@"loginId",passWord,@"loginPassword", nil];
    NSString *jsonStr = [dic JSONString];
 
    NSDictionary *param = [NSDictionary dictionaryWithObjectsAndKeys:jsonStr,@"user", nil];
    AFHTTPClient *requestClient = [[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:@""]];
    [requestClient postPath:@"http://bluemoon/user/login/m" parameters:param success:^(AFHTTPRequestOperation *operation, id responseObject) {
  
        id  result = [responseObject objectFromJSONData];
      
        block(result);

    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    

}

+(void)requestWithUrl:(NSString*)urlString boday:(NSData*)bodayData{
    NSURL *url                   = [NSURL URLWithString:urlString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setTimeoutInterval:30];
    [request setHTTPMethod:@"GET"];
   
    
    [NSURLConnection sendAsynchronousRequest:request queue:[NSOperationQueue currentQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
   
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        NSLog(@"%@",result);
    }];
    
}
    

@end
