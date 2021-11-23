//
//  Ex.swift
//  FantasyUI
//
//  Created by Liseami on 2021/11/23.
//

import Foundation
import SwiftUI
import StoreKit

extension UIApplication {
    //获取顶级试图
    class func topViewController(controller: UIViewController? = UIApplication.shared.windows.filter {$0.isKeyWindow}.first?.rootViewController) -> UIViewController? {
        if let navigationController = controller as? UINavigationController {
            return topViewController(controller: navigationController.visibleViewController)
        }
        if let tabController = controller as? UITabBarController {
            if let selected = tabController.selectedViewController {
                return topViewController(controller: selected)
            }
        }
        if let presented = controller?.presentedViewController {
            return topViewController(controller: presented)
        }
        return controller
    }
}




//View转Uiimage
extension View {
   public func takeScreenshot(origin: CGPoint, size: CGSize) -> UIImage {
        let window = UIWindow(frame: CGRect(origin: origin, size: size))
        let hosting = UIHostingController(rootView: self)
        hosting.view.frame = window.frame
        window.addSubview(hosting.view)
        window.makeKeyAndVisible()
        return hosting.view.screenShot
  }
}

//View转Uiimage
extension UIView {
    public var screenShot: UIImage {
       let rect = self.bounds
       UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
       let context: CGContext = UIGraphicsGetCurrentContext()!
       self.layer.render(in: context)
       let capturedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
       UIGraphicsEndImageContext()
       return capturedImage
   }
}



///价格本地化
extension SKProduct {
    public  var localizedPrice: String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        if let str =  formatter.string(from: price){
            return str
        }else {
            return "价格异常..."
        }
    }
    
    
    public  var HeightPriceString : String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = priceLocale
        let heightprice = price.multiplying(by: NSDecimalNumber.init(value: 1.618 * 3))
        if let str = formatter.string(from: heightprice){
            return str
        }else
        {
            return "价格异常..."
        }
    }
}

