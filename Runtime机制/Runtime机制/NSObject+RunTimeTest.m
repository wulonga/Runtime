//
//  NSObject+RunTimeTest.m
//  Runtime机制
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 Gooou. All rights reserved.
//

#import "NSObject+RunTimeTest.h"
#import <objc/runtime.h>
#import "CustomClass.h"

@implementation NSObject (RunTimeTest)
-(id)testRunTime:(NSString*)classname age:(NSString*)age
{
    //成员属性的数量
    unsigned int propertyCount=0;
    //objc_property_t为opaque类型，表示OC中的属性
    //class_copyPropertyList为得到一个类中的属性
    objc_property_t* propertList=class_copyPropertyList([self class], &propertyCount);
    
    for (unsigned int i=0; i<propertyCount; i++) {
        objc_property_t* thisProperty=&propertList[i];
        const char* propertyName=property_getName(*thisProperty);
        NSLog(@"属性为:'%s'",propertyName);
    }
    
    //获取所有的成员变量
    unsigned int methodCount=0;
    Ivar *ivars=class_copyIvarList([self class],&methodCount);
    for (unsigned int i=0; i<methodCount; i++) {
        Ivar ivar=ivars[i];
        const char *name=ivar_getName(ivar);
        const char *type=ivar_getTypeEncoding(ivar);
        NSLog(@"成员变量为%s,名字为%s",type,name);
    }
    free(ivars);
    //获取方法列表
     unsigned int count=0;
    Method *methodList = class_copyMethodList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        Method method = methodList[i];
        NSLog(@"method---->%@", NSStringFromSelector(method_getName(method)));
    }
    
    //获取协议列表
    __unsafe_unretained Protocol **protocolList = class_copyProtocolList([self class], &count);
    for (unsigned int i=0; i<count; i++) {
        Protocol *myProtocal = protocolList[i];
        const char *protocolName = protocol_getName(myProtocal);
        NSLog(@"protocol---->%@", [NSString stringWithUTF8String:protocolName]);
    }
    
    //动态创建类
    Class cls=objc_allocateClassPair([self class], "MySubClass", 0);
    //增加实例变量
    //"@"--对象，静态类型，或者id类型
    BOOL isSuccess=class_addIvar(cls, "test", sizeof(NSString*), 0, "@");
    isSuccess?NSLog(@"添加变量成功"):NSLog(@"添加变量失败");
    //添加方法
    class_addMethod(cls, @selector(addMethodForMyClass:), (IMP)addMethodForMyClass, "V@:");
    return nil;
}
//必须写方法才能够被调用
- (void)addMethodForMyClass:(NSString *)string {
}
static void addMethodForMyClass(id self, SEL _cmd, NSString *test) {
    // 获取类中指定名称实例成员变量的信息
    Ivar ivar = class_getInstanceVariable([self class], "test");
    // 返回名为test的ivar变量的值
    id obj = object_getIvar(self, ivar);
    NSLog(@"%@",obj);
    NSLog(@"addMethodForMyClass:参数：%@",test);
    NSLog(@"ClassName：%@",NSStringFromClass([self class]));
}
@end
