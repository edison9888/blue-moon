

#import <Foundation/Foundation.h>

@interface BaseDataModel : NSObject
-(id)initWithData:(id)data;
@end

@interface SchoolModel : BaseDataModel

@property (nonatomic,strong)NSString *logoUrl;
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *nature;
@property (nonatomic,strong)NSString *phoneNum;

@end
@interface TeacherModel : BaseDataModel
@property(nonatomic,strong)NSString *actorUrl;
@property(nonatomic,strong)NSString *name;
@property(nonatomic,strong)NSString *sex;
@property(nonatomic,strong)NSString *age;
@property(nonatomic,strong)NSString *className;
@property(nonatomic,strong)NSString *phoneNO;
@property(nonatomic,strong)NSString *flowers;

@end


@interface ClassModel : BaseDataModel
@property(nonatomic,retain)NSNumber *model_id;
@property(nonatomic,retain)NSString *title;    //标题
@property(nonatomic,retain)NSString *time;     //
@property(nonatomic,retain)NSString *nowPrice; //
@property(nonatomic,retain)NSString *oldPrice; //
@property(nonatomic,retain)NSString *addr;     //
@property(nonatomic,retain)NSString *photoUrl; //
@property(nonatomic,retain)NSString *num;      //
@property(nonatomic,strong)NSString *logoUrl;


@property(nonatomic,retain)NSString *content;  //
@property(nonatomic,retain)NSString *classStyle;
//为数据模型赋值
@end
