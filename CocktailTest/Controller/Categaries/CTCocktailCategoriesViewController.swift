

import UIKit
import SwiftUI

class CTCocktailCategoriesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var categoryView: CTCocktailCategoriesView!
    private let refreshControl = UIRefreshControl()
    var vSpinner: UIView?
    private var categoryModel: CTCocktailCategoriesModel
    private var drinkModel : CTDrinksModel
    private var cellId = CTConstants.cellId
    
    init() {
        self.categoryModel = CTCocktailCategoriesModel()
        self.drinkModel = CTDrinksModel()
        super.init(nibName: "CTCocktailCategoriesViewController", bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setupController()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        self.getCocktailCategories()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: -Private Funcs
    
    private func setupController() {
        self.setupTable()
        self.title = "Categories"
        //self.navigationController?.navigationBar.barTintColor = CTConstants.greenColor
        // self.navigationController?.navigationBar.tintColor = CTConstants.greenColor
    }
    
    private func setupTable() {
        self.categoryView.categoriesTableView.delegate = self
        self.categoryView.categoriesTableView.dataSource = self
        self.categoryView.categoriesTableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(getCocktailCategories), for: .valueChanged)
    }
    
    @objc private func getCocktailCategories() {
        CTAPI.getCocktailCategories { [weak self] (success, failure) in
            if let this = self {
                if let catList = success {
                     DispatchQueue.main.async {
                         this.categoryModel.setCategoriesList(catList: catList.getCategoriesList())
                         this.categoryModel.categeriesList.remove(at: 2)
                         this.refreshControl.endRefreshing()
                         this.categoryView.categoriesTableView.reloadData()
                     }
                }
                if let error = failure {
                    print("Error: \(error.description)")
                }
            }
        }
    }
    
    
    private func getDrinksByCategory(name: String, _ completion: @escaping () -> Void) {
        CTAPI.getDrinksByCategory (name: name){ [weak self] (categoryList, failure) in
            if let this = self {
                if let catList = categoryList {
                    this.drinkModel.setDrinksList(catList: catList.getDrinksList())
                    completion()
                }
                if let error = failure {
                    print("Error: \(error.description)")
                }
            }
        }
    }
    
    //MARK: -UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.categoryModel.getCategoriesListCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .default, reuseIdentifier: cellId)
        cell.textLabel?.text = self.categoryModel.getCategoryForIndex(indexPath.row)?.getCategory()
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let select = self.categoryModel.getCategoryForIndex(indexPath.row)?.getCategory() {
            if #available(iOS 13.0, *) {
                showSpinner(onView: self.view)
                self.getDrinksByCategory(name: select) { [weak self] in
                    if let drinkList = self?.drinkModel.drinkList {
                        let swiftUIController = UIHostingController(rootView: CTDrinksDetails(drinks: drinkList, title: select))
                        self?.removeSpinner()
                        self?.present(swiftUIController, animated: true, completion: nil)
                    }
                }
            } else {
                // not work SwiftUI
                let alert = UIAlertController(title: CTConstants.attentionSwiftUI,message: CTConstants.messageSwiftUI,preferredStyle:.alert)
                let ok = UIAlertAction(title: CTConstants.okActionSwifUI, style: .default)
                alert.addAction(ok)
                self.present(alert, animated: true,completion: nil)
            }
        }
    }
}

extension CTCocktailCategoriesViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(activityIndicatorStyle: .large)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async    {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            self.vSpinner?.removeFromSuperview()
            self.vSpinner = nil
        }
    }
}
