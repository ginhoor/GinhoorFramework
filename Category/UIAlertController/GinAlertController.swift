//
//  GinAlertController.swift
//  demo4iOS8AlertViewController
//
//  Created by JunhuaShao on 15/1/9.
//  Copyright (c) 2015年 JunhuaShao. All rights reserved.
//

import Foundation
import UIKit

extension UIAlertController
{
    
    class func defaultAlert(
        title:String,message:String,
        cancelTitle:String,cancelBlock:(UIAlertAction!) -> Void,
        submitTitle:String,submitBlock:(UIAlertAction!) -> Void,
        completedBlock:()->Void
        )
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // 取消按钮
        let cancel = UIAlertAction(title: cancelTitle, style: .Cancel, handler:cancelBlock)
        // 提交按钮
        let submit = UIAlertAction(title: submitTitle, style: .Default, handler:submitBlock)
        
        // 先加入的在左边
        alertController.addAction(cancel)
        alertController.addAction(submit)

        UIAlertController.lastPresentedViewController()?.presentViewController(alertController, animated: true, completion:completedBlock)
    }
    
    class func defaultAlert(
        title:String,message:String,
        cancelTitle:String,cancelBlock:(UIAlertAction!) -> Void,
        completedBlock:()->Void
        )
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // 取消按钮
        let cancel = UIAlertAction(title: cancelTitle, style: .Cancel, handler:cancelBlock)
        
        // 先加入的在左边
        alertController.addAction(cancel)
        
        self.lastPresentedViewController()?.presentViewController(alertController, animated: true, completion:completedBlock)
    }
    
    class func lastPresentedViewController() -> UIViewController?
    {
        var presentedViewController = self.getChildPresentViewController(UIApplication.sharedApplication().keyWindow?.rootViewController)
        return presentedViewController
    }
    
    class func getChildPresentViewController(parentViewController:UIViewController?) -> UIViewController? {
        if (parentViewController?.presentedViewController == nil) {
            return parentViewController
        } else {
            return self.getChildPresentViewController(parentViewController?.presentedViewController)
        }
    }
    
    
}