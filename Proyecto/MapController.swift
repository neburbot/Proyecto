import UIKit
import MapKit

struct CellData {
    let name : Any?
    let address : Any?
}

class MapController: UIViewController, UISearchBarDelegate, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tablePlaces: UITableView!
    @IBOutlet weak var myMapView: MKMapView!

    var places = [CellData]()
    var city:String?
    var addButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        places = [CellData.init(name: "nombre", address: "dirección")]
        self.navigationItem.hidesBackButton = true

        NotificationCenter.default.addObserver(self, selector: #selector(actualiza), name: NSNotification.Name(rawValue: "places"), object: nil)
        
        self.tablePlaces.register(CustomCell.self, forCellReuseIdentifier: "custom")
        
//        addButton = UIBarButtonItem(title:"test", style: .bordered, target: self, action: #selector(addButtonAction(_:)))
//        self.navigationItem.rightBarButtonItem = self.addButton

    }

//    @objc func addButtonAction(_ sender: UIBarButtonItem){
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchBar.delegate = self
//        present(searchController,animated: true, completion: nil)
//    }
    
    @IBAction func searchButton(_ sender: UIBarButtonItem) {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.delegate = self
        present(searchController,animated: true, completion: nil)

    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar){
        UIApplication.shared.beginIgnoringInteractionEvents()
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        searchBar.resignFirstResponder()
        dismiss(animated: true, completion: nil)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = searchBar.text
        
        let activeSearch = MKLocalSearch(request:searchRequest)
        activeSearch.start{
            (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil {
                print("Error")
            }else{
                //Remove annotations
                let annotations = self.myMapView.annotations
                self.myMapView.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = searchBar.text
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myMapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.myMapView.setRegion(region, animated: true)
                
                self.city = searchBar.text
                
                print(self.city!)
                let cityFixed = searchBar.text!.replacingOccurrences(of: " ", with: "+")

                let conexionMaps = Connection(api: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=lugares+de+interes+en+\(cityFixed ?? "Morelia" )&key=AIzaSyB_EXMo9hTI9fwOMhgrroH7qTIg9gRrfNU")
                
//                conexionMaps.conectaMaps()
            }
        }
    }
    
    func sehenswurdigkeiten(placeName : String, placeAddress : String ){
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.style = UIActivityIndicatorView.Style.gray
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        self.view.addSubview(activityIndicator)
        
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = placeAddress
        
        let activeSearch = MKLocalSearch(request:searchRequest)
        activeSearch.start{
            (response, error) in
            activityIndicator.stopAnimating()
            UIApplication.shared.endIgnoringInteractionEvents()
            if response == nil {
                print("Error")
            }else{
                //Remove annotations
                let annotations = self.myMapView.annotations
                self.myMapView.removeAnnotations(annotations)
                
                //Getting data
                let latitude = response?.boundingRegion.center.latitude
                let longitude = response?.boundingRegion.center.longitude
                
                //Create annotation
                let annotation = MKPointAnnotation()
                annotation.title = placeName
                
                annotation.coordinate = CLLocationCoordinate2DMake(latitude!, longitude!)
                self.myMapView.addAnnotation(annotation)
                
                //Zooming in on annotation
                let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude!, longitude!)
                let span = MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1)
                let region = MKCoordinateRegion(center: coordinate, span: span)
                self.myMapView.setRegion(region, animated: true)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return places.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "celdaComplejo")
        
        let place = places[indexPath.row]
        
        cell.textLabel?.text = place.name as? String
        cell.detailTextLabel?.text = place.address as? String
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let place = self.places[indexPath.row]
        sehenswurdigkeiten(placeName: place.name! as! String, placeAddress: place.address! as! String)
    }
    
    @objc
    private func actualiza(notification: Notification){
        guard let places = notification.userInfo!["places"] else {return}
        
        DispatchQueue.main.async {
            let placesList = places as! Array<[String:Any]>
            for place in placesList{
                self.places.append(CellData.init(name: place["name"]!, address: place["formatted_address"]!))
            self.tablePlaces.reloadData()
//                print(place["name"]!)
//                print(place["formatted_address"]!)

            }

        }
    }

    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "dateTicketSegue" {
            let obj = segue.destination as! FlightController
            obj.destiny = self.city!
        }
    }

}
