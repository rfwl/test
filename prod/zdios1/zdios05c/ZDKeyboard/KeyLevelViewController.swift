//
//  KeyLevelViewController.swift
//  zidian_ios_01
//
//  Created by Richard Feng on 12/10/2016.
//  Copyright © 2016 Richard Feng. All rights reserved.
//
import Foundation
import UIKit

class KeyLevelViewController: UIViewController {
   
    var commander:Commander?
    //=================================================================
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.        
        clearKeyLevels()        
    } // end of class

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //=================================================================
    // Draw Key Level
    let textRowHeight:CGFloat = 50
    var curCellStartX:CGFloat=0
    var curCellStartY:CGFloat=0
    
    func clearKeyLevels(){
        for v in self.view.subviews {v.removeFromSuperview()}
    }
    func drawKeyLevelArray(_ keyLevelArray:[KeyLevel]?){
        self.view.removeAllSubviews()
        curCellStartX=0
       	curCellStartY=0
        
        //var minTextWidth:CGFloat = getStringWidth("zh") // ? font must be considered here.
        var minTextWidth:CGFloat = 50
        let colCount:CGFloat=floor(self.view.bounds.size.width / minTextWidth) // floor is defined in Foundation lib.
        //let remainder:CGFloat=Int(self.view.bounds.size.width) % Int(minTextWidth)
        let remainder:CGFloat = 20.0
        minTextWidth+=remainder/colCount-1 // Distribute extra width to each cell in a row
        var requiredHeight:CGFloat = 0.0
        if let childArray = keyLevelArray  {   // Only draw children now, not favor children yet.
            for lvl in childArray {
                let lvlText:String=lvl.text
                //----------------------------------------------------------------------------
                // Calculate real width used in drawing
                var txtWidthActual:CGFloat
                txtWidthActual = getStringWidth(lvlText)
                if 	txtWidthActual < minTextWidth {
                    txtWidthActual = minTextWidth
                }
                let drawnWidth:CGFloat = ceil(txtWidthActual/minTextWidth)*minTextWidth
                //----------------------------------------------------------------------------
                // Check if go to next row
                if curCellStartX+drawnWidth > self.view.bounds.size.width { // Goto next row
                    curCellStartX=0;
                    curCellStartY+=textRowHeight
                }
                
                let cellLeft:CGFloat = curCellStartX
                let cellTop:CGFloat = curCellStartY
                //----------------------------------------------------------------------------
                // Create and add a button for the child level
                let frm:CGRect = CGRect(x:cellLeft, y:cellTop, width:drawnWidth, height:textRowHeight)
                addKeyLevelButton(title:lvlText,frame:frm,keyLevel:lvl)
                
                //----------------------------------------------------------------------------
                // Record location and size back into the child key level
                lvl.x=curCellStartX
                lvl.y=curCellStartY
                lvl.height=textRowHeight
                lvl.width=drawnWidth
                curCellStartX+=drawnWidth
                //----------------------------------------------------------------------------
                if requiredHeight < curCellStartY + textRowHeight {
                    requiredHeight = curCellStartY + textRowHeight + 2
                }
            }
            let width = self.view.frame.size.width
            if let sui:UIScrollView = self.view as?UIScrollView {
                sui.contentSize = CGSize(width:width,height:requiredHeight)
            }
            
        }else { // No child found, just do nothing
            
        }
    } //end of func
    
    func getStringWidth (_ text: String) -> CGFloat{
        //let font = NSFont.userFontOfSize(NSFont.systemFontSize())
        //let attributes = NSDictionary(object: font!, forKey:NSFontAttributeName)
        ///let sizeOfText = text.sizeWithAttributes((attributes as! [String : AnyObject]))
        //return sizeOfText.width
        
        return CGFloat(25 * text.characters.count)
    }
    //=================================================================
    // Add Button
    private func addKeyLevelButton(title: String, frame:CGRect, keyLevel:KeyLevel) {
        let lvlButton = KeyLevelButton(frame: frame)
        lvlButton.contentVC = self
        lvlButton.parentKeyLevel = keyLevel
       	lvlButton.setTitle(title, for: .normal)
        lvlButton.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        self.view.addSubview(lvlButton)
    }
    
    func didTapButton(sender: AnyObject?) {
        
        //let button = sender as! KeyLevelButton
        //let title = button.title(for:.normal)
        //let proxy = textDocumentProxy as UITextDocumentProxy
        //proxy.insertText(title!)
        //txtField.text! += title!
        //let klvl = button.parentKeyLevel
        //clearKeyLevels()
        //drawKeyLevel(klvl)
    }
    //==========================================================
    // Report Touches 
    /*
    func reportTouches1(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let location = touch?.location(in: self.view) 
        let found:UIView? = self.view.hitTest(location!,with:event!)
        if found == nil {return}
        if let klvlBtn = found as? KeyLevelButton {
            let klvl = klvlBtn.parentKeyLevel
        	if touch?.phase == UITouchPhase.began {
        		//print("KB-" + klvl.text)
                commander?.reportKeyLevelTouchBegan(klvl)
        	} else if touch?.phase == UITouchPhase.ended {
        		//print("KE-" + klvl.text)
                commander?.reportKeyLevelTouchEnded(klvl)
        	} else if touch?.phase == UITouchPhase.cancelled {
        		//print("KC-" + klvl.text)
                commander?.reportKeyLevelTouchCancelled(klvl)
        	} 
 
        } else {
        	// Ignore that only buttons will be considerred here
        }  
    }
    //=================================================================
    var touchDownLoc:CGPoint?    
    func reportTouches2(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        if touch?.phase == UITouchPhase.began {
            touchDownLoc = touch?.location(in: self.view)
        } else if touch?.phase == UITouchPhase.moved {
            let location = touch?.location(in: self.view)
            let offsetY = location!.y - touchDownLoc!.y
            let scrView = self.view as? UIScrollView
            let trans : CGAffineTransform = CGAffineTransform(translationX: 0.0, y: offsetY)
            scrView?.contentOffset = (scrView?.contentOffset.applying(trans))!
            touchDownLoc = touch?.location(in: self.view)
            
        } else if touch?.phase == UITouchPhase.cancelled {
            
        }
    } */
    //=================================================================
    var downTouchLoc:CGPoint? 
    var downTouchTime:Date = Date()   
    var lastTouchLoc:CGPoint?   
     
    func reportTouches(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch = touches.first
        
        if touch?.phase == UITouchPhase.began {
           	//------------------------------------------- Touch Begin
           	downTouchLoc = touch?.location(in: self.view)
           	downTouchTime = Date()
           	lastTouchLoc = downTouchLoc 
        } else if touch?.phase == UITouchPhase.moved {
            //------------------------------------------- Touch Move: scroll content
            let moveTouchLoc = touch?.location(in: self.view)
            
            
            let scrView = self.view as! UIScrollView
            let contentY = scrView.contentOffset.y
            let maxOffsetY = (scrView.contentSize.height) - (scrView.frame.size.height)
            if maxOffsetY <= 0 { return }
            
            var offsetY = lastTouchLoc!.y - moveTouchLoc!.y
            var adjusted:Bool = false
            if contentY + offsetY > maxOffsetY {offsetY = maxOffsetY - contentY; adjusted = true}
            else if offsetY < -contentY {offsetY = -contentY ; adjusted = true}
            
            if abs(offsetY) > 20 || adjusted  {
                //print("off=\(offsetY) move=\(moveTouchLoc!.y) last=\(lastTouchLoc!.y)" )
            	//let trans : CGAffineTransform = CGAffineTransform(translationX: 0.0, y: offsetY)
            	//scrView.contentOffset = (scrView.contentOffset.applying(trans))
                //scrView.contentOffset.y -= offsetY
                lastTouchLoc =  moveTouchLoc
            }
            
            
        } else if touch?.phase == UITouchPhase.ended {
            //------------------------------------------- Touch Ended
            // Moving Part
             /*
             let moveTouchLoc = touch?.location(in: self.view)
            
            
            let scrView = self.view as! UIScrollView
            let contentY = scrView.contentOffset.y
            let maxOffsetY = (scrView.contentSize.height) - (scrView.frame.size.height)
            if maxOffsetY <= 0 { return }
            
            var offsetY = lastTouchLoc!.y - moveTouchLoc!.y
            var adjusted:Bool = false
            if contentY + offsetY > maxOffsetY {offsetY = maxOffsetY - contentY; adjusted = true}
            else if offsetY < -contentY {offsetY = -contentY ; adjusted = true}
            
            if abs(offsetY) > 20 || adjusted  {
                //print("off=\(offsetY) move=\(moveTouchLoc!.y) last=\(lastTouchLoc!.y)" )
            	let trans : CGAffineTransform = CGAffineTransform(translationX: 0.0, y: offsetY)
            	scrView.contentOffset = (scrView.contentOffset.applying(trans))
                //scrView.contentOffset.y -= offsetY
                lastTouchLoc =  moveTouchLoc
            }
            */
            //-------------------------------------------
            // ending part.
            let endTouchLoc = touch?.location(in: self.view)
            let dist = max(abs((endTouchLoc?.x)! - (downTouchLoc?.x)!), abs((endTouchLoc?.y)! - (downTouchLoc?.y)!)) 
            if dist < 10 {
            	//-------------------------------------- A tap found.
            	let found:UIView? = hitTest_disabled(touch!,with:event!)  //self.view.hitTest(endTouchLoc!,with:event!)
        		if found == nil {return}
        		if let klvlBtn = found as? KeyLevelButton {
            		let klvl = klvlBtn.parentKeyLevel
            		let upTouchTime = Date()
            		let milliSecondsBetween = upTouchTime.timeIntervalSince(downTouchTime)
            		if milliSecondsBetween > 0.4 {
            			commander?.reportLongPressKeyLevel(klvl)
            		} else {
            			commander?.reportTapKeyLevel(klvl)
            		}
        		}	
            
            } 
        } else if touch?.phase == UITouchPhase.cancelled {
            //------------------------------------------- Touch Cancelled 
        }
    } // end of func
    
    func hitTest_disabled(_ touch: UITouch, with event: UIEvent?) -> UIView?{
        
        for sv in self.view.subviews {
            let point = touch.location(in: sv)
            if sv.point(inside:point,with: event)  {
                return sv
            }
        }
        return nil
    }
    //=================================================================
    

} //end of class

extension UIView {
    func removeAllSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}//end of extension


/*
-------------------------------------------------------------------------------
Creating a Date and Time in Swift
In Swift, dates and times are stored in a 64-bit floating point number measuring the number of seconds since the reference date of January 1, 2001 at 00:00:00 UTC. 
This is expressed in the Date struct. 

The following would give you the current date and time:
let currentDateTime = Date()

Creating other date-times, 
Method 1

If you know the number of seconds before or after the 2001 reference date, you can use that.
let someDateTime = Date(timeIntervalSinceReferenceDate: -123456789.0) // Feb 2, 1997, 10:26 AM

Method 2
use years, months, days and hours 
// Specify date components
var dateComponents = DateComponents()
dateComponents.year = 1980
dateComponents.month = 7
dateComponents.day = 11
dateComponents.timeZone = TimeZone(abbreviation: "JST") // Japan Standard Time
dateComponents.hour = 8
dateComponents.minute = 34
// Create date from components
let userCalendar = Calendar.current // user calendar
let someDateTime = userCalendar.date(from: dateComponents)
Other time zone abbreviations can be found here. If you leave that blank, then the default is to use the user's time zone.

Method 3
The most succinct way (but not necessarily the best) could be to use DateFormatter.
let formatter = DateFormatter()
formatter.dateFormat = "yyyy/MM/dd HH:mm"
let someDateTime = formatter.date(from: "2016/10/08 22:31")

Method 4:
The Unicode technical standards show other formats that DateFormatter supports.
class Date {

    class func from(#year:Int, month:Int, day:Int) -> NSDate {
        var c = NSDateComponents()
        c.year = year
        c.month = month
        c.day = day

        var gregorian = NSCalendar(identifier:NSCalendarIdentifierGregorian)
        var date = gregorian!.dateFromComponents(c)
        return date!
    }

    class func parse(dateStr:String, format:String="yyyy-MM-dd") -> NSDate {
        var dateFmt = NSDateFormatter()
        dateFmt.timeZone = NSTimeZone.defaultTimeZone()
        dateFmt.dateFormat = format
        return dateFmt.dateFromString(dateStr)!
    }
}
var date = Date.parse("2014-05-20")
var date = Date.from(year: 2014, month: 05, day: 20)


Method 5: 

extension NSDate
{
    convenience
      init(dateString:String) {
      let dateStringFormatter = NSDateFormatter()
      dateStringFormatter.dateFormat = "yyyy-MM-dd"
      dateStringFormatter.locale = NSLocale(localeIdentifier: "en_US_POSIX")
      let d = dateStringFormatter.dateFromString(dateString)!
      self.init(timeInterval:0, sinceDate:d)
    }
 }
Now you can create an NSDate from Swift just by doing:
NSDate(dateString:"2014-06-06")

-------------------------------------------------------------------------------
Difference between Dates:

Sample 1>
The NSDate function timeIntervalSinceDate: will give you the difference of two dates in seconds.
 NSDate* date1 = someDate;
 NSDate* date2 = someOtherDate;
 NSTimeInterval distanceBetweenDates = [date1 timeIntervalSinceDate:date2];
 double secondsInAnHour = 3600;
 NSInteger hoursBetweenDates = distanceBetweenDates / secondsInAnHour;

Sample 2>

NSCalendar *c = [NSCalendar currentCalendar];
NSDate *d1 = [NSDate date];
NSDate *d2 = [NSDate dateWithTimeIntervalSince1970:1340323201];//2012-06-22
NSDateComponents *components = [c components:NSHourCalendarUnit fromDate:d2 toDate:d1 options:0];
NSInteger diff = components.minute;

NSDayCalendarUnit|NSHourCalendarUnit|NSMinuteCalendarUnit

Sample 3>

-(NSMutableString*) timeLeftSinceDate: (NSDate *) dateT {

    NSMutableString *timeLeft = [[NSMutableString alloc]init];

    NSDate *today10am =[NSDate date];

    NSInteger seconds = [today10am timeIntervalSinceDate:dateT];

    NSInteger days = (int) (floor(seconds / (3600 * 24)));
    if(days) seconds -= days * 3600 * 24;

    NSInteger hours = (int) (floor(seconds / 3600));
    if(hours) seconds -= hours * 3600;

    NSInteger minutes = (int) (floor(seconds / 60));
    if(minutes) seconds -= minutes * 60;

    if(days) {
        [timeLeft appendString:[NSString stringWithFormat:@"%ld Days", (long)days*-1]];
    }

    if(hours) {
        [timeLeft appendString:[NSString stringWithFormat: @"%ld H", (long)hours*-1]];
    }

    if(minutes) {
        [timeLeft appendString: [NSString stringWithFormat: @"%ld M",(long)minutes*-1]];
    }

    if(seconds) {
        [timeLeft appendString:[NSString stringWithFormat: @"%lds", (long)seconds*-1]];
    }

    return timeLeft;
}



Sample 4>

class func hoursBetweenDates(date1: NSDate, date2: NSDate) -> Int {
    let secondsBetween = abs(Int(date1.timeIntervalSinceDate(date2)))
    let secondsInHour = 3600

    return secondsBetween / secondsInHour
}


-------------------------------------------------------------------------------
Get milliseconds:
These functions (dateWithTimeIntervalSince1970, dateWithTimeIntervalSinceReferenceDate, dateWithTimeIntervalSinceNow) accept parameter in seconds.

NSDate *date = [NSDate dateWithTimeIntervalSince1970:(ms / 1000.0)];
You should pass 1273636800.000
NSDate *date = [NSDate dateWithTimeIntervalSince1970:(1273636800 / 1000.0)];

func dateFromMilliseconds(ms: NSNumber) -> NSDate {
    return NSDate(timeIntervalSince1970:Double(ms) / 1000.0)
}

-------------------------------------------------------------------------------
// let lower = min(17, 42) // 17
// let upper = max(17, 42) // 42
// let a = abs(-10) // 10

*/
