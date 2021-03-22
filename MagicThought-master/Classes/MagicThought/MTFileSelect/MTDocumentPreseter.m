//
//  MTDocumentPreseter.m
//  SimpleProject
//
//  Created by monda on 2019/6/17.
//  Copyright © 2019 monda. All rights reserved.
//

#import "MTDocumentPreseter.h"
#import "MTCloud.h"
#import "MTDocument.h"

@interface MTDocumentPreseter ()<UIDocumentBrowserViewControllerDelegate, UIDocumentPickerDelegate>

@property (nonatomic,weak) UIViewController* controller;

@property (nonatomic,copy) void (^completion)(BOOL, MTFileModel *);

@end


@implementation MTDocumentPreseter

+(instancetype)preseter {
    static MTDocumentPreseter *singleton = nil;
    if (!singleton)
    {
        singleton = [super manager];
        singleton.controller = [MTCloud shareCloud].currentViewController;
    }
    return singleton;
}

-(void)showWithCompletion:(void (^)(BOOL, MTFileModel *))completion
{
    self.completion = completion;
    if (@available(iOS 11.0, *)) {
        [self.controller presentViewController:self.browserController animated:YES completion:nil];
    } else{
//        @"com.adobe.pdf"
        UIDocumentPickerViewController* vc = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[] inMode:UIDocumentPickerModeOpen];
        if (@available(iOS 11.0, *)) {
            vc.allowsMultipleSelection = false;
        }
        vc.delegate = self;
        [self.controller presentViewController:vc animated:YES completion:nil];
    }
}

-(void)afterSelecterFileAtURL:(NSURL *)url
{
    //调用Document
    MTDocument *docu = [[MTDocument alloc]initWithFileURL:url];
    
    //开启
    __weak __typeof(self) weakSelf = self;
    [docu openWithCompletionHandler:^(BOOL success) {
        
         __strong typeof(self) strongSelf = weakSelf;
        
        if (success) {
            __weak typeof(self) weakSelf2 = strongSelf;
            MTFileModel* fileModel = [MTFileModel setupPropertyWithDocument:docu];
            
            //关闭
            [docu closeWithCompletionHandler:^(BOOL success) {
                
                if(weakSelf2.completion)
                    weakSelf2.completion(success, fileModel);
                weakSelf2.completion = nil;
                
                [weakSelf2.controller dismissViewControllerAnimated:YES completion:nil];
            }];
        } else {
            [strongSelf.controller dismissViewControllerAnimated:YES completion:nil];
        }
    }];
}

#pragma mark - UIDocumentPickerDelegate代理

- (void)documentPickerWasCancelled:(UIDocumentPickerViewController *)controller
{
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}

- (void)documentPicker:(UIDocumentPickerViewController *)controller didPickDocumentAtURL:(NSURL *)url
{
    [self afterSelecterFileAtURL:url];
}

#pragma mark - UIDocumentBrowserViewControllerDelegate代理

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentURLs:(NSArray <NSURL *> *)documentURLs
API_AVAILABLE(ios(11.0)){
    
    [self afterSelecterFileAtURL:documentURLs.firstObject];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller didPickDocumentsAtURLs:(NSArray <NSURL *> *)documentURLs
API_AVAILABLE(ios(11.0)){
    
    [self afterSelecterFileAtURL:documentURLs.firstObject];
}

- (void)documentBrowser:(UIDocumentBrowserViewController *)controller failedToImportDocumentAtURL:(NSURL *)documentURL error:(NSError * _Nullable)error
API_AVAILABLE(ios(11.0)){
    
    [self.controller dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - 懒加载

-(UIDocumentBrowserViewController *)browserController
API_AVAILABLE(ios(11.0)){
    if(!_browserController)
    {
        if (@available(iOS 11.0, *)) {
            UIDocumentBrowserViewController* vc = [UIDocumentBrowserViewController new];
            vc.delegate = self;
            vc.allowsDocumentCreation = NO;//不让文件管理器创建新文件
            vc.allowsPickingMultipleItems = NO;//不让多点选择
            //添加一个取消按钮
            UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc]initWithTitle:@"取消" style:UIBarButtonItemStylePlain target:self action:@selector(back)];
            vc.additionalLeadingNavigationBarButtonItems = @[buttonItem];
            
            _browserController = vc;
        }
    }
    
    return _browserController;
}

@end
