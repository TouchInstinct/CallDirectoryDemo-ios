import UIKit
import CallKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addContacts(_ sender: Any) {
        let numbers = ["79214203692",
                       "79640982354",
                       "79982434663"]
        
        let titles = ["Иванов Петр Петрович",
                      "Сергеев Иван Николаевич",
                      "Николаев Андрей Михайлович"]
        
        writeFileForCallDirectory(numbers: numbers, titles: titles)
    }
    
    fileprivate func writeFileForCallDirectory(numbers: [String], titles: [String]) {
        guard let fileUrl = FileManager.default
            .containerURL(forSecurityApplicationGroupIdentifier: "group.ru.touchin.TouchInApp")?
            .appendingPathComponent("contacts") else { return }
        
        var string = ""
        for (number, title) in zip(numbers, titles) {
            string += "\(number),\(title)\n"
        }
        
        try? string.write(to: fileUrl, atomically: true, encoding: .utf8)
        CXCallDirectoryManager.sharedInstance.reloadExtension(withIdentifier: "ru.touchin.TouchInApp.TouchInCallExtension")
    }
    
}

