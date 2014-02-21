

#import "ActivityModel.h"

@implementation ActivityModel
-(id)initWithData:(id)data{
    if (self = [super init]) {
        self.name = [[data objectForKey:@"clazz"] objectForKey:@"name"];
        self.c_name = [[data objectForKey:@"course"]objectForKey:@"name"];

    }
    return self;
}
@end
