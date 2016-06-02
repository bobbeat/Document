//
//  mallocTest.m
//  allocTest
//
//  Created by gaozhimin on 14-4-20.
//  Copyright (c) 2014年 autonavi. All rights reserved.
//

#import "mallocTest.h"

@interface mallocTest()
{
    char* p1;
    char* p2;
    char* p[100];
}

@end


@implementation mallocTest


- (void)malloc
{
    //    if (p1)
    //    {
    //        free(p1);
    //    }
    //    if (p2)
    //    {
    //        free(p2);
    //        p2 = NULL;
    //    }
    for (int i = 0; i < 100; i++)
    {
        if (p[i])
        {
            free(p[i]);
            //            p[i] = NULL;
        }
    }
    for (int i = 0; i < 100; i++)
    {
        p[i] = (char *)malloc(1024);
    }
    //    p1 = (char *)malloc(1024*20);
    //
    //    p2 = (char *)malloc(1024*30);
}

- (void)free
{
    for (int i = 0; i < 50; i++)
    {
        [self malloc];
    }
    
    //    free(p1);
    //    free(p2);
    
}

@end
