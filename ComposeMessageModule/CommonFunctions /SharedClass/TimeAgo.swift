
import Foundation

//Get current Time ()
public func currentTime(_ type : Int) -> (String , String){
    var date = Date()
    let dateFormatter = DateFormatter()
    if type == 1 {
        date = date.addingTimeInterval(3600)
    }
    dateFormatter.dateFormat = "h:mm a"
    let milliSec = (date.hour * 3600 + date.minute * 60) * 1000
    return (dateFormatter.string(from: date) , milliSec.toString)
}

public func calculateTimeSince(time : String) -> String {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    guard let locationDate: NSDate =  dateFormatter.date(from: time) as NSDate? else { return "" }
    print(locationDate)
    return  timeAgoSinceDate(date: locationDate,numericDates: true)
}

public func dateConvert(time : Date) -> String{
    let dateFormatter : DateFormatter = DateFormatter()
    dateFormatter.dateFormat = "h:mm a"
    let date = dateFormatter.string(from: time)
    return date
}

func  millisecToTimeFormat(milliSec : String  , is24HrFormat : Bool?) -> String{
    guard let sec = milliSec.toDouble() else {return String()}
    let date = Date(timeIntervalSince1970: Double(sec / 1000))
    let formatter = DateFormatter()
    formatter.timeZone = NSTimeZone(name: "UTC")! as TimeZone
    formatter.dateFormat = /is24HrFormat == false ? "h:mm a" : "HH:mm"
    return formatter.string(from: date as Date)
}


public func dateConvertFull(time : String) -> String{
    let dateFormatter : DateFormatter = DateFormatter()
    let dateFormatter1 : DateFormatter = DateFormatter()

    dateFormatter.dateFormat = "h:mm a"
    let date = dateFormatter.date(from: time)
    dateFormatter1.dateFormat = "HH:mm"
    let dateNew = dateFormatter.string(from: date ?? Date())
    return dateNew
}

public func calculateDate(time : String) -> String {
    let dateFormatter: DateFormatter = DateFormatter()
    dateFormatter.timeZone = TimeZone(abbreviation: "GMT")
    dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
    guard let locationDate: Date =  dateFormatter.date(from: time) as Date? else { return "" }
    print(locationDate)
    dateFormatter.dateFormat = "EEE, MMM d, yyyy - h:mm a"
    dateFormatter.timeZone = NSTimeZone.local
    let timeStamp = dateFormatter.string(from: locationDate)
    print(timeStamp)
    return  timeStamp
}
public func timeAgoSinceDate(date:NSDate, numericDates:Bool) -> String {
    let calendar = NSCalendar.current
    let unitFlags: Set<Calendar.Component> = [.minute, .hour, .day, .weekOfYear, .month, .year, .second]
    let now = NSDate()
    let earliest = now.earlierDate(date as Date)
    let latest = (earliest == now as Date) ? date : now
    let components = calendar.dateComponents(unitFlags, from: earliest as Date,  to: latest as Date)
    
    if (components.year! >= 2) {
        return "\(components.year!) years ago"
    } else if (components.year! >= 1){
        if (numericDates){
            return "1 year ago"
        } else {
            return "Last year"
        }
    } else if (components.month! >= 2) {
        return "\(components.month!) months ago"
    } else if (components.month! >= 1){
        if (numericDates){
            return "1 month ago"
        } else {
            return "Last month"
        }
    } else if (components.weekOfYear! >= 2) {
        return "\(components.weekOfYear!) weeks ago"
    } else if (components.weekOfYear! >= 1){
        if (numericDates){
            return "1 week ago"
        } else {
            return "Last week"
        }
    } else if (components.day! >= 2) {
        return "\(components.day!) days ago"
    } else if (components.day! >= 1){
        if (numericDates){
            return "1 day ago"
        } else {
            return "Yesterday"
        }
    } else if (components.hour! >= 2) {
        return "\(components.hour!) hours ago"
    } else if (components.hour! >= 1){
        if (numericDates){
            return "1 hour ago"
        } else {
            return "An hour ago"
        }
    } else if (components.minute! >= 2) {
        return "\(components.minute!) minutes ago"
    } else if (components.minute! >= 1){
        if (numericDates){
            return "1 minute ago"
        } else {
            return "A minute ago"
        }
    } else if (components.second! >= 3) {
        return "\(components.second!) seconds ago"
    } else {
        return "Just now"
    }
    
}
