//
//  HomePageViewController.swift
//  WeatherApp
//
//  Created by HarshitSharma on 30/06/22.
//

import UIKit

class HomePageViewController: UIViewController {
  
  @IBOutlet weak var tblView: UITableView!
  private let viewModel = HomePageViewModel()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupUI()
  }
  
  private func setupUI() {
    tblView.delegate = self
    tblView.dataSource = self
    tblView.register(UINib(nibName: viewModel.getCellIdetifier(), bundle: nil), forCellReuseIdentifier: viewModel.getCellIdetifier())
    tblView.tableFooterView = UIView()
    self.title = NavigationConstant.Home.rawValue
  }
}

extension HomePageViewController: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return viewModel.getCellHeight()
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return viewModel.getCityCount()
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: viewModel.getCellIdetifier()) as? HomePageTableViewCell else {return UITableViewCell()}
    cell.lblTitle.text = viewModel.getCityName(indexPath)
    return cell
  }
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    guard let vc = UIStoryboard(name: StringConstant.main, bundle: nil).instantiateViewController(withIdentifier: ControllerConstant.WeatherDetailsViewController.getId()) as? WeatherDetailsViewController else {return}
    vc.viewModel.cityName = viewModel.getCityName(indexPath)
    self.navigationController?.pushViewController(vc, animated: true)
  }
}
