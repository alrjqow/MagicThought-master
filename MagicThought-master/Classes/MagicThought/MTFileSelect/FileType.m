//
//  FileType.m
//  DocumentBasesApp
//
//  Created by 李晓璐 on 2017/12/4.
//  Copyright © 2017年 onmmc. All rights reserved.
//

#import "FileType.h"

@implementation FileType

//判断文件格式
+(NSArray *)fieldType:(NSURL *)fieldType{
    NSArray *array = [[NSString stringWithFormat:@"%@",fieldType] componentsSeparatedByString:@"."]; //字符串按照【分隔成数组
    NSString *contentStr = array.lastObject;
    //---------------------------图片类型-----------------------
    if ([contentStr containsString:@"png"]||[contentStr containsString:@"jpg"]||[contentStr containsString:@"jpeg"]||[contentStr containsString:@"gif"]||[contentStr containsString:@"bmp"]||[contentStr containsString:@"pic"]||[contentStr containsString:@"tif"]) {//图片
        return @[@(ENUM_Image), @"Image", contentStr];
    }
    //---------------------------音频类型-----------------------
    if ([contentStr containsString:@"mp3"]||[contentStr containsString:@"wav"]||[contentStr containsString:@"ram"]||[contentStr containsString:@"aif"]||[contentStr containsString:@"au"]||[contentStr containsString:@"wma"]||[contentStr containsString:@"mmf"]||[contentStr containsString:@"amr"]||[contentStr containsString:@"aac"]||[contentStr containsString:@"flac"]) {//音频
        return @[@(ENUM_Audio), @"Audio", contentStr];
    }
    //---------------------------视频类型-----------------------
    if ([contentStr containsString:@"mp4"]||[contentStr containsString:@"avi"]||[contentStr containsString:@"mov"]||[contentStr containsString:@"rmvb"]||[contentStr containsString:@"rm"]||[contentStr containsString:@"mpg"]||[contentStr containsString:@"swf"]) {//视频
        return @[@(ENUM_Video), @"Video", contentStr];
    }
    //---------------------------文档类型-----------------------
    //-----Windows----
    if ([contentStr containsString:@"ppt"]) {//windows_PPT
        return @[@(ENUM_Ppt), @"Document", contentStr];
    }
    if ([contentStr containsString:@"doc"]) {//windows_Word
        return @[@(ENUM_Word), @"Document", contentStr];
    }
    if ([contentStr containsString:@"xls"]) {//windows_Excel
        return @[@(ENUM_Excel), @"Document", contentStr];
    }
    if ([contentStr containsString:@"txt"]) {//windows_TXT
        return @[@(ENUM_Txt), @"Document", contentStr];
    }
    //------Mac------
    if ([contentStr containsString:@"rtf"]) {//Mac_Rtf
        return @[@(ENUM_Rtf), @"Document", contentStr];
    }
    if ([contentStr containsString:@"numbers"]) {//Mac_Numbers
        return @[@(ENUM_Numbers), @"Document", contentStr];
    }
    if ([contentStr containsString:@"pages"]) {//Mac_Pages
        return @[@(ENUM_Pages), @"Document", contentStr];
    }
    if ([contentStr containsString:@"key"]) {//Mac_KeyNote
        return @[@(ENUM_KeyNote), @"Document", contentStr];
    }
    //------WPS------
    if ([contentStr containsString:@"wps"]) {//windows_TXT
        return @[@(ENUM_Wps), @"Document", contentStr];
    }
    //------其他-----
    if ([contentStr containsString:@"html"]) {//Web_Html
        return @[@(ENUM_Html), @"Document", contentStr];
    }
    if ([contentStr containsString:@"md"]) {//MarkDown_Md
        return @[@(ENUM_MarkDown), @"Document", contentStr];
    }
    if ([contentStr containsString:@"pdf"]) {//PDF
        return @[@(ENUM_PDF), @"Document", contentStr];
    }
    //---------------------------压缩类型-----------------------
    if ([contentStr containsString:@"zip"]) {//Zip
        return @[@(ENUM_Zip), @"Compression", contentStr];
    }
    if ([contentStr containsString:@"rar"]) {//Rar
        return @[@(ENUM_Rar), @"Compression", contentStr];
    }
    if ([contentStr containsString:@"iso"]) {//Iso
        return @[@(ENUM_Iso), @"Compression", contentStr];
    }
    if ([contentStr containsString:@"exe"]) {//Exe
        return @[@(ENUM_Exe), @"Compression", contentStr];
    }
    if ([contentStr containsString:@"dmg"]) {//Dmg
        return @[@(ENUM_Dmg), @"Compression", contentStr];
    }
    if ([contentStr containsString:@"ipa"]) {//Ipa
        return @[@(ENUM_Ipa), @"Compression", contentStr];
    }
    if ([contentStr containsString:@"apk"]) {//Apk
        return @[@(ENUM_Apk), @"Compression", contentStr];
    }
    //---------------------------其他类型-----------------------
    return @[@(ENUM_UnKnow), @"Other", contentStr];
}

@end
