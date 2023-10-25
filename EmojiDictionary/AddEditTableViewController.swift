//
//  AddEditTableViewController.swift
//  EmojiDictionary
//
//  Created by Lars Dansie on 10/17/23.
//

import UIKit

class AddEditTableViewController: UITableViewController {

    var emoji: Emoji?
    
    @IBOutlet weak var usageTextField: UITextField!
    @IBOutlet weak var descriptionTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var symbolTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let emoji = emoji {
            symbolTextField.text = emoji.symbol
            nameTextField.text = emoji.name
            descriptionTextField.text = emoji.description
            usageTextField.text = emoji.usage
            title = "Edit Emoji"
        } else {
            title = "Add emoji"
        }
        updateSaveButtonState()
    }

    
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    init?(coder: NSCoder, emoji: Emoji?) {
        self.emoji = emoji
        super.init(coder: coder)
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBAction func textEditingChange(_ sender: UITextField) {
        updateSaveButtonState()
    }
    
    private func containsSingleEmoji(_ textField: UITextField) -> Bool {
        guard let text = textField.text, text.count == 1 else { return false }
        
        let isCombinedIntoEmoji = text.unicodeScalars.count > 1 && text.unicodeScalars.first?.properties.isEmoji ?? false
        let isEmojiPresentation = text.unicodeScalars.first?.properties.isEmojiPresentation ?? false
        
        
        return isCombinedIntoEmoji || isEmojiPresentation
    }
    
    private func updateSaveButtonState() {
        let symbolText = symbolTextField.text ?? ""
        let name = nameTextField.text ?? ""
        let usage = usageTextField.text ?? ""
        let description = descriptionTextField.text ?? ""
        
        saveButton.isEnabled = !symbolText.isEmpty && !name.isEmpty && !usage.isEmpty && !description.isEmpty && containsSingleEmoji(symbolTextField)
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "saveUnwind" else { return }
        let symbol = symbolTextField.text!
        let name = nameTextField.text!
        let description = descriptionTextField.text!
        let usage = usageTextField.text!
        
        emoji = Emoji(symbol: symbol, name: name, description: description, usage: usage)
    }
}
