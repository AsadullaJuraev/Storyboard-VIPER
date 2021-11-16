//
//  CreateViewController.swift
//  StoryboardContact
//
//  Created by Asadulla Juraev on 03/11/21.
//

import UIKit

protocol CreateRequestProtocol {
    func apiContactCreate(contact: Contact)
}

protocol CreateResponseProtocol {
    func onContactCreate(isCreated: Bool)
}

class CreateViewController: BaseViewController, CreateResponseProtocol {
    
    var presenter: CreateRequestProtocol!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleField: UITextField!
    @IBOutlet weak var bodyLabel: UILabel!

    @IBOutlet weak var bodyTextView: UITextField!
    
    var item = Contact()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        // Do any additional setup after loading the view.
    }

    func initViews(){
        configureViper()
        titleLabel.text = "Name"
        bodyLabel.text = "Number"

        let add = UIImage(named: "ic_send")
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: add, style: .plain, target: self, action: #selector(rightTapped))
    }
    func configureViper(){
        let manager = HttpManager()
        let presenter = CreatePresenter()
        let interactor = CreateInteractor()
        let routing = CreateRouting()
        
        presenter.controller = self
        
        self.presenter = presenter
        presenter.interactor = interactor
        presenter.routing = routing
        routing.viewController = self
        interactor.manager = manager
        interactor.response = self
    }
    @objc func rightTapped(){
        if titleField.text != "" && bodyTextView.text != "" {
            presenter.apiContactCreate(contact: Contact(name: titleField.text!, number: bodyTextView.text!))
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "load"), object: nil)
        }
    }
    
    func onContactCreate(isCreated: Bool) {
        if isCreated {
            self.navigationController?.popViewController(animated: true)
        }else{
            
        }
    }
    
}
