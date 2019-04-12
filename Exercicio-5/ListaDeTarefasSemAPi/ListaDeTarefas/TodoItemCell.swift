//  Created by @marciovcampos

import UIKit

class TodoItemCell: UITableViewCell {
    
    var isCompleted: Bool = false{
        didSet {
            guard let currentText = textLabel?.text else { return }
            
            let strikeStyle = isCompleted ? NSNumber(value: NSUnderlineStyle.single.rawValue) : NSNumber(value: 0)
            let strokeEffect: [NSAttributedString.Key: Any] = [.strikethroughStyle: strikeStyle, .strikethroughColor: UIColor.black]
            
            textLabel?.attributedText = NSAttributedString(string: currentText, attributes: strokeEffect)
        }
    }
}
