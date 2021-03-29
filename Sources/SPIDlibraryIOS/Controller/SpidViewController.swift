// 
// SPDX-FileCopyrightText: 2021 Istituto Nazionale Previdenza Sociale
//
// SPDX-License-Identifier: BSD-3-Clause

import Foundation
import UIKit


public class SpidViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var infoBtn: UIButton!
    @IBOutlet weak var requestSpidBtn: UIButton!
    
    var spidDelegate: SpidDelegate?
    var spidConfig: SpidConfig?
    var randomProviders: [Provider] = []
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.estimatedRowHeight = UITableView.automaticDimension
        self.tableView.rowHeight = UITableView.automaticDimension
        
        infoBtn.setTitle("info_text".localized(), for: .normal)
        requestSpidBtn.setTitle("request_spid_text".localized(), for: .normal)
        
        infoBtn.titleLabel?.underline()
        requestSpidBtn.titleLabel?.underline()
        
        if let error = ErrorManager.init(spidConfig: spidConfig).checkError() {
            self.dismiss(animated: true, completion: {
                self.spidDelegate?.onError(error: error)
            })
        }
        
        if let identityProviderKeys = spidConfig?.identityProviderKeys {
            let idpViewModel = IdentityProviderViewModel(identityProviderKeys: identityProviderKeys)
            randomProviders = idpViewModel.generateProviders()
        }
    }
    
    // MARK: - Action
    
    @IBAction func dismiss(_ sender: Any){
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapInfo(_ sender: Any){
        if let urlSpidPageInfoString = spidConfig?.spidPageInfoUrl,
           let url = URL(string: urlSpidPageInfoString){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    @IBAction func tapRequestSpid(_ sender: Any){
        if let urlRequestSpidPageString = spidConfig?.requestSpidPageUrl,
           let url = URL(string: urlRequestSpidPageString){
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        }
    }
    
    public static func present(delegate: SpidDelegate, spidConfig: SpidConfig) {
        if let viewController = delegate as? UIViewController,
           let spidViewController = SpidViewController.instance(){
            spidViewController.spidDelegate = delegate
            spidViewController.spidConfig = spidConfig
            DispatchQueue.main.async {
                let navigationController = UINavigationController.init(rootViewController: spidViewController)
                navigationController.isNavigationBarHidden = true
                navigationController.modalPresentationStyle = .fullScreen
                viewController.present(navigationController, animated: true, completion: nil)
            }
        }        
    }
    
    static func instance() -> SpidViewController? {
        let storyboard = UIStoryboard(name: "Provider", bundle: .module)
        let spidViewController = storyboard.instantiateInitialViewController() as? SpidViewController
        return spidViewController
    }
}

// MARK: - UITableView Delegate

extension SpidViewController: UITableViewDelegate {
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(Reachability.isConnectedToNetwork()){
            let currentProvider = randomProviders[indexPath.row]
            guard self.spidDelegate != nil && self.spidConfig != nil else { return }
            guard let loginViewController = LoginViewController.instance(),
                  let spidDelegate = spidDelegate,
                  let spidConfig = spidConfig else {
                self.dismiss(animated: true, completion: {
                    self.spidDelegate?.onError(error: .NotPresent(className: LoginViewController.identifier))
                })
                return
            }
            loginViewController.provider = currentProvider
            loginViewController.spidDelegate = spidDelegate
            loginViewController.spidConfig = spidConfig
            DispatchQueue.main.async {
                self.navigationController?.pushViewController(loginViewController, animated: true)
            }
        } else {
            self.dismiss(animated: true, completion: {
                self.spidDelegate?.onError(error: .NoInternet)
            })
            return
        }
        
    }
    
}

// MARK: - UITableView DataSource

extension SpidViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return randomProviders.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // Creating cell from current provider
        let cell: ProviderCell = tableView.dequeueReusableCell(withIdentifier: ProviderCell.identifier) as! ProviderCell
        let currentProvider = randomProviders[indexPath.row]
        cell.providerImage?.image = UIImage(named: currentProvider.name, in: .module, compatibleWith: nil)
        return cell
    }
    
}
