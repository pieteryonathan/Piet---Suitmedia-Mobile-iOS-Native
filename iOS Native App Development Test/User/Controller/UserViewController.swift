//
//  UserViewController.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 12/06/22.
//

import UIKit

protocol UserViewControllerDelegate{
    func getDataUserForHome(userData: UserData)
}

protocol UserViewControllerDelegateMap{
    func getDataUserForMap(userData: [UserInfoMap])
}


class UserViewController: UIViewController {
    //IBOutlet
    @IBOutlet weak var userTableView: UITableView!
    //Declaration
    var infoUser = [DataUser]()
    var delegate: UserViewControllerDelegate?
    var delegateForMap: UserViewControllerDelegateMap?
    var temp: [UserInfoMap] = []
    let locationPins = [
        AnnotationPin(title: "", subtitle: "", latitude: -6.276254446787058, longitude: 106.8246424837679),
        AnnotationPin(title: "", subtitle: "", latitude: -6.276759975483882, longitude: 106.82591189881447),
        AnnotationPin(title: "", subtitle: "", latitude: -6.276583009644629, longitude: 106.82305649726977),
        AnnotationPin(title: "", subtitle: "", latitude: -6.261904006320388, longitude: 106.83057292512237),
        AnnotationPin(title: "", subtitle: "", latitude: -6.265877895729093, longitude: 106.82452368878401),
        AnnotationPin(title: "", subtitle: "", latitude: -6.269381167872703, longitude: 106.81621256407568),
        AnnotationPin(title: "", subtitle: "", latitude: -6.27162952416491, longitude: 106.82110455520147),
        AnnotationPin(title: "", subtitle: "", latitude: -6.256413714622644, longitude: 106.81442409420174),
        AnnotationPin(title: "", subtitle: "", latitude: -6.275446478921028, longitude: 106.83709557995674),
        AnnotationPin(title: "", subtitle: "", latitude: -6.262113159148686, longitude: 106.845827521106)
    ]
    let mapViewController = MapViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setup()
        pullToRefresh()
        delegateForMap = mapViewController
    }
    
    //Map View
    func addMapViewController(){
        delegateForMap?.getDataUserForMap(userData: temp)
        self.view.addSubview(mapViewController.view)
        self.addChild(mapViewController)
        mapViewController.didMove(toParent: self)
        }
    
    func removeMapViewController(){
        mapViewController.willMove(toParent: nil)
        mapViewController.view.removeFromSuperview()
        mapViewController.removeFromParent()
    }
    
    func pullToRefresh(){
        userTableView.refreshControl = UIRefreshControl()
        userTableView.refreshControl?.addTarget(self, action: #selector(didPullToRefresh), for: .valueChanged)
    }
    
    @objc private func didPullToRefresh(){
        getData()
    }
    
    func setup(){
        userTableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        navigationItem.title = "Users"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_show_map"), style: .plain, target: self, action: #selector(mapDidTapped))
    }
    
    @objc func mapDidTapped(){
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_show_list"), style: .plain, target: self, action: #selector(listDidTapped))
        self.addMapViewController()
    }
    
    @objc func listDidTapped(){
        self.removeMapViewController()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "ic_show_map"), style: .plain, target: self, action: #selector(mapDidTapped))
        
        
    }
    
    func getData(){
        infoUser.removeAll()
        ApiManager().parsingJson{ data in
            self.infoUser = data
            for (index, data) in self.infoUser.enumerated(){
                let userData = UserInfoMap(website: "https://suitmedia.com/", email: data.email, first_name: data.first_name, last_name: data.last_name, avatar: data.avatar, annotation: self.locationPins[index])
                self.temp.append(userData)
            }
            DispatchQueue.main.async {
                self.userTableView.refreshControl?.endRefreshing()
                self.userTableView.reloadData()
            }
        }
    }
}
    

extension UserViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoUser.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! UserTableViewCell
        let imageURL = URL(string: infoUser[indexPath.row].avatar ?? "")
        cell.imageUser.downloaded(from: imageURL!)
        cell.firstNameUser.text = infoUser[indexPath.row].first_name
        cell.lastNameUser.text = infoUser[indexPath.row].last_name
        cell.emailUser.text = infoUser[indexPath.row].email
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.getDataUserForHome(userData: UserData(website: "https://suitmedia.com/", email: infoUser[indexPath.row].email, first_name: infoUser[indexPath.row].first_name, last_name: infoUser[indexPath.row].last_name, avatar: infoUser[indexPath.row].avatar))
        navigationController?.popViewController(animated: true)
    }
}
