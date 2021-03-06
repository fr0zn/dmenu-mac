//
//  Created by Jose Pereira on 2/14/16.
//  Copyright © 2016 fidalgo.io. All rights reserved.
//

import Cocoa

class ResultsView: NSView {
    let rectFillPadding:CGFloat = 5
    var _list = [URL]()
    
    var _selectedAppIndex: Int = 0
    var selectedAppIndex: Int {
        get {
            return _selectedAppIndex
        }
        set {
            if newValue < 0 || newValue >= _list.count {
                return
            }
            
            _selectedAppIndex = newValue
            needsDisplay = true;
        }
    }
    
    var list: [URL] {
        get {
            return _list
        }
        set {
            _selectedAppIndex = 0
            _list = newValue;
            needsDisplay = true;
        }
    }
    
    var selectedApp: URL? {
        get {
            if _selectedAppIndex < 0 || _selectedAppIndex >= _list.count {
                return nil
            } else {
                return _list[_selectedAppIndex]
            }
        }
    }
    
    func clear() {
        _list.removeAll()
        needsDisplay = true;
    }
    
    override func draw(_ dirtyRect: NSRect) {
        var textX = CGFloat(rectFillPadding)
        for i in 0 ..< list.count {
            let appName = (_list[i].deletingPathExtension().lastPathComponent) as NSString
            let size = appName.size(withAttributes: [NSAttributedString.Key: Any]())
            let textY = (frame.height - size.height) / 2
            
            if _selectedAppIndex == i {
                NSColor.selectedTextBackgroundColor.setFill()
                __NSRectFill(NSRect(
                    x: textX - rectFillPadding,
                    y: textY - rectFillPadding,
                    width: size.width + rectFillPadding * 2,
                    height: size.height + rectFillPadding * 2))
            }
            
            appName.draw(in: NSRect(
                x: textX,
                y: textY,
                width: size.width,
                height: size.height), withAttributes: [
                    NSAttributedString.Key.foregroundColor: NSColor.textColor
                ])
            
            textX += 10 + size.width;
            
            //stop drawing if we passed the visible frame
            if textX > frame.width {
                break;
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
