import UIKit

class TicketsController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var carriers:Array<[String:Any]>?
    var destiny:String?

    @IBOutlet weak var tableTickets: UITableView!
    var placeId1 = ""
    var placeId2 = ""
    var flightDate : String?
    var minPrice = 0
    var minPriceCarrierId : Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(actualiza), name: NSNotification.Name(rawValue: "clima"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actualizaFlight), name: NSNotification.Name(rawValue: "flight"), object: nil)

        //forecast en lugar de weather
//        let conexionMaps = Connection(api: "https://maps.googleapis.com/maps/api/place/textsearch/json?query=lugares+de+interes+en+Morelia&key=AIzaSyCXAG0G2ATiBnYFYLJMLedNKH4UpNjByIA")
//        let conexionWeather = Connection(api: "https://api.openweathermap.org/data/2.5/forecast?q=\(destiny!)&appid=482908afe699aa51ee57f93cea23ca0e&lang=es&units=metric")
//        conexionMaps.conectaMaps()
//        conexionWeather.conectaWeather()
        print("tickets")
        print(placeId1)
        print(placeId2)
        print(flightDate)
        let conexionFlight = Connection(api: "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/US/MXN/en-US/\(placeId1)/\(placeId2)/\(flightDate!)")

        conexionFlight.conectaFlights()
    }
    

    @objc
    private func actualizaFlight(notification: Notification){
        guard let carriersList = notification.userInfo!["carriers"] else {return}
        guard let minPrice:Int = notification.userInfo!["minPrice"] as! Int else {return}
        guard let carrierId:Int = notification.userInfo!["carrierId"] as? Int else {return}
        
        DispatchQueue.main.async {
            self.carriers = carriersList as! Array<[String:Any]>
            self.minPrice = minPrice
            self.minPriceCarrierId = carrierId
            for carrier in self.carriers!{
                print(carrier["Name"]!)
                print(carrier["CarrierId"]!)
                let carId = carrier["CarrierId"]! as! Int
                if carrierId == carId{
                    print(carrier["Name"]!)
                }
            }
            print(minPrice)
            self.tableTickets.reloadData()
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return carriers?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "ticketCell")
        
        let carrier = carriers![indexPath.row]
        
        cell.textLabel?.text = carrier["Name"] as? String
        if minPriceCarrierId! == carrier["CarrierId"] as! Int{
            cell.detailTextLabel?.text = "$ \(minPrice) MXN"
        }
        cell.accessoryType = UITableViewCell.AccessoryType.disclosureIndicator
        
        return cell

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let resultViewController = storyBoard.instantiateViewController(withIdentifier: "ConfirmTicketsController") as! ConfirmTicketsController
        let carrier = carriers![indexPath.row]

        let selectedCarrier = carrier["Name"] as! String
        let selectedPrice = minPrice
        resultViewController.carrier = selectedCarrier
        resultViewController.price = selectedPrice
        resultViewController.destiny = destiny
        resultViewController.flightDate = flightDate
        
        if tableView.cellForRow(at: indexPath)?.textLabel?.text != nil{
            self.navigationController?.pushViewController(resultViewController, animated: true)
        }
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "boletoSegue"{
//            _ = segue.destination as! BoletosController
//        }
//    }

}
