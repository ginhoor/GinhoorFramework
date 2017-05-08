//
//  GinCameraCaptureManager.m
//  GinCamera
//
//  Created by JunhuaShao on 2017/4/6.
//  Copyright © 2017年 GinhoorHome. All rights reserved.
//

#import "GinCameraCaptureManager.h"

@implementation GinCameraCaptureManager

- (AVCaptureDevice *)cameraWithPosition:(AVCaptureDevicePosition)position
{
    NSArray *devices = [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo];
    for ( AVCaptureDevice *device in devices )
        if ( device.position == position )
            return device;
    return nil;
}


- (void)switchCameraDevice:(AVCaptureSession *)session completion:(void(^)(AVCaptureDeviceInput *newInput, AVCaptureDevicePosition position))completion
{
    NSArray *inputs = session.inputs;
    
    AVCaptureDevicePosition position = -1;
    AVCaptureDevice *newCamera = nil;
    AVCaptureDeviceInput *newInput = nil;
    
    for (AVCaptureDeviceInput *input in inputs) {
        
        AVCaptureDevice *device = input.device;
        if ([device hasMediaType:AVMediaTypeVideo]) {
            position = device.position;
            newCamera = nil;
            newInput = nil;
            
            if (position == AVCaptureDevicePositionFront) {
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionBack];
            } else {
                newCamera = [self cameraWithPosition:AVCaptureDevicePositionFront];
                // 前置摄像头不支持闪光灯
            }
            
            newInput = [AVCaptureDeviceInput deviceInputWithDevice:newCamera error:nil];
            
            [session beginConfiguration];
            [session removeInput:input];
            [session addInput:newInput];
            [session commitConfiguration];
            
            break;
        }
    }
    
    if (completion) {
        completion(newInput, position);
    }
}


- (AVCaptureConnection *)getVideoConnection:(AVCaptureOutput *)captureOutput
{
    return [captureOutput connectionWithMediaType:AVMediaTypeVideo];
//    AVCaptureConnection *videoConnection = nil;
//    
//    for (AVCaptureConnection *connection in captureOutput.connections) {
//        for (AVCaptureInputPort *port in [connection inputPorts]) {
//            if ([[port mediaType] isEqual:AVMediaTypeVideo] ) {
//                videoConnection = connection;
//                break;
//            }
//        }
//        if (videoConnection) {
//            break;
//        }
//    }
//    return videoConnection;
}


//获取授权
- (void)getVideoAuthorization:(void(^)())successBlock failture:(void(^)())failtureBlock
{
    //此处获取摄像头授权
    switch ([AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo])
    {
        case AVAuthorizationStatusAuthorized:       //已授权，可使用    The client is authorized to access the hardware supporting a media type.
        {
            if (successBlock) {
                successBlock();
            }
            break;
        }
        case AVAuthorizationStatusNotDetermined:    //未进行授权选择     Indicates that the user has not yet made a choice regarding whether the client can access the hardware.
        {
            //则再次请求授权
            [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
                if(granted){    //用户授权成功
                    if (successBlock) {
                        successBlock();
                    }
                    return;
                } else {        //用户拒绝授权
                    if (failtureBlock) {
                        failtureBlock();
                    }
                    return;
                }
            }];
            break;
        }
        default:                                    //用户拒绝授权/未授权
        {
            if (failtureBlock) {
                failtureBlock();
            }
            break;
        }
    }
    
}


@end


