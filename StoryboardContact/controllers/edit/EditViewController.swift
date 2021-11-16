//
//  EditViewController.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 03/11/21.
//

import UIKit
protocol EditRequestProtocol {
    func apiCallContact(id: Int)
    func apiEditContact(id: Int, contact: Contact)
}

protocol EditResponseProtocol {
    func onCallContact(contact: Contact)
    func onEditContact(result: Bool)
}

class EditViewController: BaseViewController,EditResponseProtocol {
    
    var presenter: EditRequestProtocol!
    
    @IBOutlet weak var bodyTextView: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var titleLabel: UILabel!
    
    var ContactID: String = "1"
    var Information : Contact = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViper()
        presenter.apiCallContact(id: Int(ContactID) ?? 0)
        // Do any additional setup after loading the view.
    }

    @IBAction func buttonPressed(_ sender: Any) {
      
        presenter.apiEditContact(id: Int(ContactID)!, contact: Contact(name: titleTextField.text!, number: bodyTextView.text!))
    }
    
    func initViews(){
        bodyLabel.text = "Name"
        titleLabel.text = "Number"
        DispatchQueue.main.async {
            self.bodyTextView.text = self.Information.number!
            self.titleTextField.text = self.Information.name!
        }
        
    }
    
    func configureViper(){
        let manager = HttpManager()
        let presenter = EditPresenter()
        let interactor = EditInteractor()
        let routing = EditRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    
    func onCallContact(contact: Contact) {
        self.hideProgress()
        Information = contact
        initViews()
    }
    
    func onEditContact(result: Bool) {
        self.hideProgress()
        if result {
            self.dismiss(animated: true, completion: nil)
        }else{
            
        }
    }
    
}
