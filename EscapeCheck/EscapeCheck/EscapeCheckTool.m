//
//  EscapeCheckTool.m
//  EscapeCheck
//
//  Created by vivi on 16/6/19.
//  Copyright © 2016年 vivi. All rights reserved.
//

#import "EscapeCheckTool.h"
#import <UIKit/UIKit.h>
#import <sys/stat.h>
#import <dlfcn.h>
#import <mach-o/dyld.h>

@implementation EscapeCheckTool


#pragma mark - 越狱检测
+(BOOL)isJailbroken{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Applications/Cydia.app"]){
        return YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/MobileSubstrate/MobileSubstrate.dylib"]){
        return YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/bin/bash"]){
        return YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/sbin/sshd"]){
        return YES;
    }
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/etc/apt"]){
        return YES;
    }
    
    return NO;
}

+(BOOL)isJailbroken2{
    
    if([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"cydia://package/com.example.package"]]){
        NSLog(@"NO2,Device is jailbroken");
        return YES;
    }  

    return NO;
}

+(BOOL)isJailbroken3{
    
    struct stat stat_info;
    if (0 == stat("/Applications/Cydia.app", &stat_info)) {
        NSLog(@"NO3,Device is jailbroken");
        return YES;
    }
    
    return NO;
}


+(BOOL)isJailbroken4{
    
    int ret ;
    Dl_info dylib_info;
    int (*func_stat)(const char *, struct stat *) = stat;
    if ((ret = dladdr(func_stat, &dylib_info))) {
        NSLog(@"NO4,lib :%s", dylib_info.dli_fname);
        
        NSString *str = [NSString stringWithCString:dylib_info.dli_fname encoding:NSUTF8StringEncoding];
        if ([str isEqualToString:@"/usr/lib/system/libsystem_kernel.dylib"]) {
            return NO;
        }else{
            return YES;
        }

    }
    
    return NO;
}


+(BOOL)isJailbroken5{
    
    uint32_t count = _dyld_image_count();
    for (uint32_t i = 0 ; i < count; ++i) {
        NSString *name = [[NSString alloc]initWithUTF8String:_dyld_get_image_name(i)];
        NSLog(@"NO5,--%@", name);
        if([name containsString:@"Library/MobileSubstrate/MobileSubstrate.dylib"])return YES;
    }
    
    return NO;
}

+(BOOL)isJailbroken6{
    
    char *env = getenv("DYLD_INSERT_LIBRARIES");
    NSLog(@"NO6,%s", env);
    
    if (env==NULL||env==nil) {
        return NO;
    }else{
        return YES;
    }
    

}

+(BOOL)isJailbroken7{
    
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/User/Applications/"]){
        
        NSArray *applist = [[NSFileManager defaultManager] contentsOfDirectoryAtPath:@"/User/Applications/"
                                                                               error:nil];
        NSLog(@"NO7,applist = %@",applist);
        if (applist.count>0) {
            return YES;
        }else{
            return NO;
        }
    }
    
    return NO;
}



@end
