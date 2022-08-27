//
//  HHFileManager.m
//  HHCommon
//
//  Created by yufeng on 2022/5/17.
//

#import "HHFileManager.h"

@implementation HHFileManager

+ (NSString *)pathForDocumentsDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    
    return path;
}

+ (NSString *)pathForDocumentsDirectoryWithPath:(NSString *)path {
    return [[self pathForDocumentsDirectory] stringByAppendingPathComponent:path];
}

+ (NSString *)pathForLibraryDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    
    return path;
}

+ (NSString *)pathForLibraryDirectoryWithPath:(NSString *)path {
    return [[self pathForLibraryDirectory] stringByAppendingPathComponent:path];
}

+ (NSString *)pathForTemporaryDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        path = NSTemporaryDirectory();
    });
    
    return path;
}

+ (NSString *)pathForTemporaryDirectoryWithPath:(NSString *)path {
    return [[self pathForTemporaryDirectory] stringByAppendingPathComponent:path];
}

+ (NSString *)pathForCachesDirectory {
    static NSString *path = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
        path = [paths lastObject];
    });
    
    return path;
}

+ (NSString *)pathForCachesDirectoryWithPath:(NSString *)path {
    return [[self pathForCachesDirectory] stringByAppendingPathComponent:path];
}

+ (NSString *)pathForMainBundleDirectory {
    return [NSBundle mainBundle].resourcePath;
}

+ (NSString *)pathForMainBundleDirectoryWithPath:(NSString *)path {
    return [[self pathForMainBundleDirectory] stringByAppendingPathComponent:path];
}

+ (BOOL)moveItemAtPath:(NSString *)path toPath:(NSString *)toPath overwrite:(BOOL)overwrite {
    if (path.length == 0 || toPath.length == 0) {
        return NO;
    }
    if (![self existItemAtPath:path]) {
        return NO;
    }
    if (![self existItemAtPath:toPath] || (overwrite && [self removeItemAtPath:toPath])) {
        return ([self createDirectoriesForFilePath:toPath] && [[NSFileManager defaultManager] moveItemAtPath:path toPath:toPath error:nil]);
    } else {
        return NO;
    }
}

+ (BOOL)copyItemAtPath:(NSString *)path toPath:(NSString *)toPath overwrite:(BOOL)overwrite {
    if (path.length == 0 || toPath.length == 0) {
        return NO;
    }
    if (![self existItemAtPath:path]) {
        return NO;
    }
    if (![self existItemAtPath:toPath] || (overwrite && [self removeItemAtPath:toPath])) {
        if ([self createDirectoriesForFilePath:toPath]) {
            return [[NSFileManager defaultManager] copyItemAtPath:path toPath:toPath error:nil];;
        } else {
            return NO;
        }
    } else {
        return NO;
    }
}

+ (BOOL)existItemAtPath:(NSString *)path {
    if (path.length == 0) {
        return NO;
    }
    return [[NSFileManager defaultManager] fileExistsAtPath:path];
}

+ (BOOL)existFileAtPath:(NSString *)path {
    if (path.length == 0) {
        return NO;
    }
    BOOL isDirectory = NO;
    BOOL existFile = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return existFile && !isDirectory;
}

+ (BOOL)existDirectoryAtPath:(NSString *)path {
    if (path.length == 0) {
        return NO;
    }
    BOOL isDirectory = NO;
    BOOL existFile = [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDirectory];
    return existFile && isDirectory;
}

+ (BOOL)removeItemAtPath:(NSString *)path {
    if (path.length == 0) {
        return NO;
    }
    return [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
}

+ (BOOL)removeItemsAtDirectory:(NSString *)path {
    if (path.length == 0) {
        return NO;
    }
    if ([self existDirectoryAtPath:path] == NO) {
        return NO;
    }
    NSArray<NSString *> *subPathArray = [self listFilesInDirectoryAtPath:path];
    if (subPathArray.count == 0) {
        return NO;
    }
    for (NSString *resultPath in subPathArray) {
        [self removeItemAtPath:resultPath];
    }
    return true;
}

+ (BOOL)clearCachesDirectory {
    return [self removeItemsAtDirectory:[self pathForCachesDirectory]];
}

+ (BOOL)clearTemporaryDirectory {
    return [self removeItemsAtDirectory:[self pathForTemporaryDirectory]];
}

+ (nullable NSArray<NSString *> *)listFilesInDirectoryAtPath:(NSString *)path {
    if (path.length == 0) {
        return nil;
    }
    if ([self existDirectoryAtPath:path] == NO) {
        return nil;
    }
    NSArray *relativeSubpaths = [[NSFileManager defaultManager] subpathsOfDirectoryAtPath:path error:nil];
    NSMutableArray *absoluteSubpaths = [[NSMutableArray alloc] init];
    for (NSString *relativeSubpath in relativeSubpaths) {
        NSString *absoluteSubpath = [path stringByAppendingPathComponent:relativeSubpath];
        [absoluteSubpaths addObject:absoluteSubpath];
    }
    return absoluteSubpaths.copy;
}

+ (long long)fileSizeAtPath:(NSString *)path {
    if (path.length == 0) {
        return 0;
    }
    if ([self existFileAtPath:path] == NO){
        return 0;
    }
    return [[[NSFileManager defaultManager] attributesOfItemAtPath:path error:nil] fileSize];
}

+ (long long)fileSizeAtDirectoryPath:(NSString *)path {
    if (path.length == 0) {
        return 0;
    }
    if ([self existDirectoryAtPath:path] == NO) {
        return 0;
    }
    NSArray<NSString *> *listArray = [self listFilesInDirectoryAtPath:path];
    long long resultSize = 0;
    for (NSString *resultPath in listArray) {
        resultSize += [self fileSizeAtPath:resultPath];
    }
    return resultSize;
}

#pragma mark - private
+ (BOOL)createDirectoriesForFilePath:(NSString *)path {
    if (path.length == 0) {
        return NO;
    }
    NSString *resultPath = [path stringByDeletingLastPathComponent];
    return [[NSFileManager defaultManager] createDirectoryAtPath:resultPath withIntermediateDirectories:YES attributes:nil error:nil];
}

@end
