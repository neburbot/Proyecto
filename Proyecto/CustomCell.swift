import Foundation
import UIKit

class CustomCell: UITableViewCell {
    var name : String?
    var address : String?
    
    var nameView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    var addressView : UITextView = {
        var textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.addSubview(nameView)
        self.addSubview(addressView)
        
        nameView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        nameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        nameView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        nameView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

        addressView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        addressView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        addressView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
        addressView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true

    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        if let name = name {
            nameView.text = name
        }
        if let address = address {
            addressView.text = address
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
