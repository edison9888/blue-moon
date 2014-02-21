

#import <Foundation/Foundation.h>

@interface ActivityModel : NSObject

@property (nonatomic,strong)NSString *ID;
@property (nonatomic,strong)NSString *title;
@property (nonatomic,strong)NSString *addr;
@property (nonatomic,strong)NSString *time;
@property (nonatomic,strong)NSString *host;
@property (nonatomic,strong)NSString *phone;
@property (nonatomic,strong)NSString *logo;
@property (nonatomic,strong)NSString *style;
@property (nonatomic,strong)NSString *num;
@property (nonatomic,strong)NSString *introduce;



@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *cover;
@property (nonatomic,strong)NSString *c_ID;
@property (nonatomic,strong)NSString *c_name;





-(id)initWithData:(id)data;
@end
