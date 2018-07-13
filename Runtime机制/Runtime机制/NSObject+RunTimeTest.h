//
//  NSObject+RunTimeTest.h
//  Runtime机制
//
//  Created by mac on 2018/7/12.
//  Copyright © 2018年 Gooou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RunTimeTest)
//动态创建一个类，之后为这个类的age属性赋值
-(id)testRunTime:(NSString*)classname age:(NSString*)age;
@end
