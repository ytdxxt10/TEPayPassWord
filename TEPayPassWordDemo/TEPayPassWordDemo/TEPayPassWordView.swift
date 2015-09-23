//
//  TEPayPassWordView.swift
//  TEPayPassWordDemo
//
//  Created by offcn on 15/9/18.
//  Copyright (c) 2015年 Terry. All rights reserved.
//  Swift 1.2

import UIKit
import SnapKit
var KNotification_ValidatePassWord:String = ""
typealias CompleteHandler = (passWord:String)->Void

class TEPayPassWordView: UIView {
    let viewBackgroundColor:UInt = 0x7a7a7c
    let contentViewBackgroundColor:UInt = 0xf0f0f0
    let contentViewLayerCornerRadius:CGFloat = 3.0
    let teTitleLabelFontSize:CGFloat = 12.0
    let textFiledViewLayerCornerRadius:CGFloat = 3.0
    let CancelButtonBackgroundColor:UInt = 0xfbfbfb
    let CertainButtonBackgroundColor:UInt = 0x3b7bf6
    let TNotification_ValidatePassWord:String = "Notification_ValidatePassWord"
    let animationTime:NSTimeInterval = 3.0
    let afterClearTextfiledColor:UInt = 0x000000
    

    var completeHandler:CompleteHandler?
    var textFieldHidden:UITextField?
    var firstTextFiled:UITextField?
    var secondTextFiled:UITextField?
    var thirdTextFiled:UITextField?
    var fourthTextFiled:UITextField?
    var fifthTextFiled:UITextField?
    var sixthTextFiled:UITextField?
    var contentView:UIView?
    var teTitleLabel:UILabel?
    var lineView:UIView?
    var CancelButton:UIButton?
    var CertainButton:UIButton?
    var textFiledView:UIView?
    var textFieldArray:NSMutableArray?
    var passWord:String?
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */
    class var sharedInsstance : TEPayPassWordView {
        struct Static {
            static var onceToken : dispatch_once_t = 0
            static var instanse : TEPayPassWordView?
        }
        dispatch_once(&Static.onceToken, {
            
            Static.instanse = TEPayPassWordView()
        })
        return Static.instanse!
    }
    override init(frame: CGRect) {
       
        super.init(frame: frame)
        self.frame = UIScreen.mainScreen().bounds
        handleUI()
    }
    

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func handleUI() {
        self.backgroundColor = UIColor(rgb: viewBackgroundColor)
        //创建对话框
        if contentView == nil {
           contentView = UIView()
            contentView?.frame = CGRectMake(20, 84, self.frame.size.width-40, 120)
            contentView?.backgroundColor = UIColor(rgb: contentViewBackgroundColor)
            contentView?.layer.cornerRadius = contentViewLayerCornerRadius
            contentView?.layer.masksToBounds = true
            self.addSubview(contentView!)
        
        }
        //创建标题用自动布局
        if teTitleLabel == nil {
           teTitleLabel = UILabel()
           teTitleLabel?.text = "请输入支付密码"
           teTitleLabel?.font = UIFont.systemFontOfSize(teTitleLabelFontSize)
           teTitleLabel?.textAlignment = .Center
           teTitleLabel?.setTranslatesAutoresizingMaskIntoConstraints(false)
            contentView?.addSubview(teTitleLabel!)
            teTitleLabel?.snp_makeConstraints({(make) in
                make.top.equalTo(contentView!.snp_top).offset(5)
                make.centerX.equalTo(contentView!.snp_centerX)
                make.height.equalTo(18)
                make.width.equalTo(100)
            })
        }

        if lineView == nil {
            lineView = UIView.new()
           lineView?.backgroundColor = UIColor.lightGrayColor()
        lineView?.setTranslatesAutoresizingMaskIntoConstraints(false)
        contentView?.addSubview(lineView!)
            lineView?.snp_makeConstraints({(make) in
             make.left.equalTo(contentView!.snp_left).offset(10)
             make.right.equalTo(contentView!.snp_right).offset(-10)
                make.top.equalTo(teTitleLabel!.snp_bottom).offset(5)
                make.height.equalTo(1)
            
            })
        
        }

        if textFiledView == nil {
            textFiledView = UIView.new()
             textFiledView?.backgroundColor = UIColor.clearColor()
            textFiledView?.setTranslatesAutoresizingMaskIntoConstraints(false)
            textFiledView?.layer.cornerRadius = textFiledViewLayerCornerRadius
            textFiledView?.layer.masksToBounds = true
            contentView?.addSubview(textFiledView!)
            textFiledView?.snp_makeConstraints({(make) in
            
                make.left.equalTo(contentView!.snp_left).offset(10)
                make.right.equalTo(contentView!.snp_right).offset(-10)
                //注意：
                make.top.equalTo(lineView!.snp_bottom).offset(5)
                make.height.equalTo(35)
            
            })
        }
//
            if CancelButton == nil {
            
                CancelButton = UIButton.buttonWithType(.Custom) as? UIButton
                CancelButton?.setTitle("Cancel", forState: .Normal)
                CancelButton?.backgroundColor = UIColor(rgb:CancelButtonBackgroundColor)
                CancelButton?.tag = 100
                CancelButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
                CancelButton?.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
                CancelButton?.layer.cornerRadius = contentViewLayerCornerRadius
                CancelButton?.layer.masksToBounds = true
                CancelButton?.setTranslatesAutoresizingMaskIntoConstraints(false)
                contentView?.addSubview(CancelButton!)
         
                CancelButton?.snp_makeConstraints({(make) in
                    make.bottom.equalTo(contentView!.snp_bottom).offset(-5)
                    make.left.equalTo(contentView!.snp_left).offset(10)
                    make.height.equalTo(30)
                
                })
            
            }

            if CertainButton == nil {
            
                CertainButton = UIButton.buttonWithType(.Custom) as? UIButton
                CertainButton?.setTitle("Certain", forState: .Normal)
                CertainButton?.setTitleColor(UIColor.blackColor(), forState: .Normal)
                CertainButton?.backgroundColor = UIColor(rgb: CertainButtonBackgroundColor)
                CertainButton?.tag = 101
                CertainButton?.addTarget(self, action: Selector("btnClick:"), forControlEvents: UIControlEvents.TouchUpInside)
                CertainButton?.setTranslatesAutoresizingMaskIntoConstraints(false)
                CertainButton?.layer.cornerRadius = contentViewLayerCornerRadius
                CertainButton?.layer.masksToBounds = true
                contentView?.addSubview(CertainButton!)
                CertainButton?.snp_makeConstraints({(make) in
                    make.bottom.equalTo(contentView!.snp_bottom).offset(-5)
                    make.height.equalTo(30)
                    make.left.equalTo(CancelButton!.snp_right).offset(10)
                    make.right.equalTo(contentView!.snp_right).offset(-10)
                    make.width.equalTo(CancelButton!.snp_width)
                    
                    })
            
            }

            if firstTextFiled == nil {
                 firstTextFiled = UITextField()
                firstTextFiled?.secureTextEntry = true
                firstTextFiled?.enabled = false
                
                firstTextFiled?.keyboardType = UIKeyboardType.NumberPad
                firstTextFiled?.borderStyle = UITextBorderStyle.Line
                firstTextFiled?.textAlignment = NSTextAlignment.Center
                firstTextFiled?.setTranslatesAutoresizingMaskIntoConstraints(false)
                textFiledView?.addSubview(firstTextFiled!)
                firstTextFiled?.snp_makeConstraints({(make) in
                    make.left.equalTo(textFiledView!.snp_left)
                    make.top.equalTo(textFiledView!.snp_top)
                    make.bottom.equalTo(textFiledView!.snp_bottom)
                    
                    })
            }

            if secondTextFiled == nil {
                secondTextFiled = UITextField()
                secondTextFiled?.secureTextEntry = true
                secondTextFiled?.enabled = false
                secondTextFiled?.keyboardType = UIKeyboardType.NumberPad
                secondTextFiled?.borderStyle = UITextBorderStyle.Line
                secondTextFiled?.textAlignment = NSTextAlignment.Center
                secondTextFiled?.setTranslatesAutoresizingMaskIntoConstraints(false)
                textFiledView?.addSubview(secondTextFiled!)
                secondTextFiled?.snp_makeConstraints({(make) in
                    make.left.equalTo(firstTextFiled!.snp_right)
                    make.width.equalTo(firstTextFiled!.snp_width)
                     make.top.equalTo(textFiledView!.snp_top)
                    make.bottom.equalTo(textFiledView!.snp_bottom)

                    })
            }
            
            if thirdTextFiled == nil {
                thirdTextFiled = UITextField()
                thirdTextFiled?.secureTextEntry = true
                thirdTextFiled?.enabled = false
                thirdTextFiled?.keyboardType = UIKeyboardType.NumberPad
                thirdTextFiled?.borderStyle = UITextBorderStyle.Line
                thirdTextFiled?.textAlignment = NSTextAlignment.Center
                thirdTextFiled?.setTranslatesAutoresizingMaskIntoConstraints(false)
                textFiledView?.addSubview(thirdTextFiled!)
                thirdTextFiled?.snp_makeConstraints({(make) in
                    make.left.equalTo(secondTextFiled!.snp_right)
                    make.width.equalTo(secondTextFiled!.snp_width)
                     make.top.equalTo(textFiledView!.snp_top)
                    make.bottom.equalTo(textFiledView!.snp_bottom)

                    })
            }
            
            if fourthTextFiled == nil {
                fourthTextFiled = UITextField()
                fourthTextFiled?.secureTextEntry = true
                fourthTextFiled?.enabled = false
                fourthTextFiled?.keyboardType = UIKeyboardType.NumberPad
                fourthTextFiled?.borderStyle = UITextBorderStyle.Line
                fourthTextFiled?.textAlignment = NSTextAlignment.Center
                fourthTextFiled?.setTranslatesAutoresizingMaskIntoConstraints(false)
                textFiledView?.addSubview(fourthTextFiled!)
                fourthTextFiled?.snp_makeConstraints({(make) in
                    make.left.equalTo(thirdTextFiled!.snp_right)
                    make.width.equalTo(thirdTextFiled!.snp_width)
                     make.top.equalTo(textFiledView!.snp_top)
                    make.bottom.equalTo(textFiledView!.snp_bottom)

                    })
            }
            
            if fifthTextFiled == nil {
                fifthTextFiled = UITextField()
                fifthTextFiled?.secureTextEntry = true
                fifthTextFiled?.enabled = false
                fifthTextFiled?.keyboardType = UIKeyboardType.NumberPad
                fifthTextFiled?.borderStyle = UITextBorderStyle.Line
                fifthTextFiled?.textAlignment = NSTextAlignment.Center
                fifthTextFiled?.setTranslatesAutoresizingMaskIntoConstraints(false)
                textFiledView?.addSubview(fifthTextFiled!)
                fifthTextFiled?.snp_makeConstraints({(make) in
                    make.left.equalTo(fourthTextFiled!.snp_right)
                    make.width.equalTo(fourthTextFiled!.snp_width)
                     make.top.equalTo(textFiledView!.snp_top)
                    make.bottom.equalTo(textFiledView!.snp_bottom)

                    })
            }
            
            if sixthTextFiled == nil {
                sixthTextFiled = UITextField()
                sixthTextFiled?.secureTextEntry = true
                sixthTextFiled?.enabled = false
                sixthTextFiled?.keyboardType = UIKeyboardType.NumberPad
                sixthTextFiled?.borderStyle = UITextBorderStyle.Line
                sixthTextFiled?.textAlignment = NSTextAlignment.Center
                sixthTextFiled?.setTranslatesAutoresizingMaskIntoConstraints(false)
                textFiledView?.addSubview(sixthTextFiled!)
                sixthTextFiled?.snp_makeConstraints({(make) in
                    make.left.equalTo(fifthTextFiled!.snp_right)
                    make.width.equalTo(fifthTextFiled!.snp_width)
                    make.right.equalTo(textFiledView!.snp_right)
                     make.top.equalTo(textFiledView!.snp_top)
                    make.bottom.equalTo(textFiledView!.snp_bottom)

                    })
            }
        
        textFieldArray = NSMutableArray(array: [firstTextFiled!,secondTextFiled!,thirdTextFiled!,fourthTextFiled!,fifthTextFiled!,sixthTextFiled!])
//
            if textFieldHidden == nil {
               textFieldHidden = UITextField()
                textFieldHidden?.returnKeyType = .Default
                textFieldHidden?.borderStyle = UITextBorderStyle.None
                textFieldHidden?.clearButtonMode = UITextFieldViewMode.Never
                textFieldHidden?.keyboardType = UIKeyboardType.NumberPad
                textFieldHidden?.setTranslatesAutoresizingMaskIntoConstraints(false)
                textFieldHidden!.addTarget(self, action: "textFiledEditChanged:", forControlEvents: UIControlEvents.EditingChanged)
                self.addSubview(textFieldHidden!)
                textFieldHidden?.snp_makeConstraints({(make) in
                    make.left.equalTo(self.snp_left)
                    make.right.equalTo(self.snp_right)
                    make.bottom.equalTo(self.snp_bottom).offset(-50)
                    })
            
            }

            NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("validatePassWordResult:"), name: KNotification_ValidatePassWord, object: nil)
            
        
    
    }
    
    //button的点击事件
    func btnClick(button:UIButton) {
    
        if button.tag == 100 {
        
            self .removePayPassWordView()
        
    }else {
        if completeHandler != nil {
          completeHandler!(passWord: passWord!)
        
        }
        
     }
    
    
    }
    
    //文本框添加方法
    
    func textFiledEditChanged(textfiled:UITextField) {
        
        
        var passWordText:String = textFieldHidden!.text
        if count(passWordText) == textFieldArray!.count {
           textfiled.resignFirstResponder()
        }
        
        for index in 0..<textFieldArray!.count {
            var textitem:UITextField = textFieldArray![index] as! UITextField
            var pwdChar:String!
            if index < count(passWordText) {
                //swift 2.0需要改变
               pwdChar = passWordText.substringWithRange(Range(start: advance(passWordText.startIndex, index), end: advance(passWordText.startIndex, index + 1)))
                textitem.text = pwdChar
            }
            
            if count(passWordText) == 6 {
               passWord = passWordText
                textFieldHidden?.text = ""
            
            
            }
        
        }
    
    
    
    }
    func validatePassWordResult(notification:NSNotification) {
    
        var resultDic:NSDictionary = notification.userInfo!
        if resultDic["validateResult"] as! Int == 1 {
            var alertView:UIAlertView = UIAlertView(title: "提示", message: "支付成功", delegate: nil, cancelButtonTitle: "确定")
            alertView .show()
            removePayPassWordView()
          
        } else {
            var alertView:UIAlertView = UIAlertView(title: "提示", message: "密码错误", delegate: nil, cancelButtonTitle: "Certain")
            alertView.show()
           shakeContentViewWithAnimation()
            clearTextField()
        }
    
    
    }

    //移除对话框
    func removePayPassWordView() {
        UIView.animateWithDuration(animationTime, animations: {
            self.contentView?.alpha = 0
            self.contentView?.transform = CGAffineTransformMakeScale(0.01, 0.01)
            }, completion: {(finished:Bool) in
              self .removeFromSuperview()
            
            })
    }
    
    //显示输入密码对话框
    
    func showPassWordViewInView(mycompleteHandler:CompleteHandler) {
       completeHandler = mycompleteHandler
       clearTextField()
        showPayPassWordView()
    }
    
    func clearTextField() {
    
        textFieldHidden?.becomeFirstResponder()
        firstTextFiled?.textColor = UIColor(rgb: afterClearTextfiledColor)
        secondTextFiled?.textColor = UIColor(rgb:afterClearTextfiledColor)
        thirdTextFiled?.textColor = UIColor(rgb:afterClearTextfiledColor)
        fourthTextFiled?.textColor = UIColor(rgb:afterClearTextfiledColor)
        fifthTextFiled?.textColor = UIColor(rgb:afterClearTextfiledColor)
        sixthTextFiled?.textColor = UIColor(rgb:afterClearTextfiledColor)
        firstTextFiled?.text = ""
        secondTextFiled?.text = ""
        thirdTextFiled?.text = ""
        fourthTextFiled?.text = ""
        fifthTextFiled?.text = ""
        sixthTextFiled?.text = ""
    
    }
    //显示对话框
    func showPayPassWordView() {
    
        var keyWindow : UIWindow = UIApplication.sharedApplication().delegate!.window!!
        keyWindow.addSubview(self)
        contentView?.alpha = 0
        contentView?.transform = CGAffineTransformMakeScale(0.01, 0.01)
        UIView.animateWithDuration(animationTime, animations: {
            
              self.contentView!.alpha = 0.75
            self.contentView!.transform = CGAffineTransformMakeScale(1.0, 1.0)
            
            })
    
    }
    //加入抖动动画
    func shakeContentViewWithAnimation() {
       var keyAnimation = CAKeyframeAnimation(keyPath: "position.x")
        keyAnimation.values = [0,12,-12,0]
        keyAnimation.keyTimes = [0,(1/6.0),(3/6.0),(5/6.0),1]
        keyAnimation.duration = 0.5
        keyAnimation.additive = true
        contentView?.layer.addAnimation(keyAnimation, forKey: "shakeAnimate")
    
    
    }
    

}
extension UIColor {
    convenience init(rgb: UInt) {
    self.init(
        red: CGFloat((rgb & 0xFF0000) >> 16) / 255.0,
        green: CGFloat((rgb & 0x00FF00) >> 8) / 255.0,
        blue: CGFloat(rgb & 0x0000FF) / 255.0,
        alpha: CGFloat(1.0)
    )
    }
}

