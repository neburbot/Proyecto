import UIKit

class FlightController: UIViewController {

    @IBOutlet weak var flightDatePicker: UIDatePicker!
    var origin = "Morelia"
    var destiny : String?
    var placeId1 = ""
    var placeId2 = ""
    var carriers : Array<[String:Any]> = []
    var flightDate : String?

    override func viewDidLoad() {
        NotificationCenter.default.addObserver(self, selector: #selector(actualizaCity1), name: NSNotification.Name(rawValue: "placeId1"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actualizaCity2), name: NSNotification.Name(rawValue: "placeId2"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(actualizaFlight), name: NSNotification.Name(rawValue: "flight"), object: nil)
        
        let destinyFixed = destiny!.replacingOccurrences(of: " ", with: "+")

        let conexionPlace1 = Connection(api: "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/MX/MXN/en-US/?query=\(origin)")
        let conexionPlace2 = Connection(api: "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/autosuggest/v1.0/MX/MXN/en-US/?query=\(destinyFixed)")

        conexionPlace1.conectaCity1()
        conexionPlace2.conectaCity2()
    }
    
    @objc
    private func actualizaCity1(notification: Notification){
        guard let placeId1 = notification.userInfo!["placeId1"] else {return}
        DispatchQueue.main.async {
            self.placeId1 = "\(placeId1)"
            print(self.placeId1)

        }
    }
    @objc
    private func actualizaCity2(notification: Notification){
        guard let placeId2 = notification.userInfo!["placeId2"] else {return}
        DispatchQueue.main.async {
            self.placeId2 = "\(placeId2)"
            print(self.placeId2)
            
        }
    }
    @objc
    private func actualizaFlight(notification: Notification){
        guard let carriersList = notification.userInfo!["carriers"] else {return}
        guard let minPrice = notification.userInfo!["minPrice"] else {return}
        guard let carrierId:Int = notification.userInfo!["carrierId"] as? Int else {return}

        DispatchQueue.main.async {
            let carriersTemp = carriersList as! Array<[String:Any]>
            for c in carriersTemp{
                self.carriers.append(c)
            }
            for carrier in self.carriers{
                print(carrier["Name"]!)
                print(carrier["CarrierId"]!)
                let carId = carrier["CarrierId"]! as! Int
                if carrierId == carId{
                    print(carrier["Name"]!)
                }
            }
            print(minPrice)
            print("api")

        }
    }

    @IBAction func confirmDate(_ sender: UIButton) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        flightDate = dateFormatter.string(from: flightDatePicker.date)
        
//        let conexionFlight = Connection(api: "https://skyscanner-skyscanner-flight-search-v1.p.rapidapi.com/apiservices/browsequotes/v1.0/US/USD/en-US/\(placeId1)/\(placeId2)/\(flightDate)")
//        
//        conexionFlight.conectaFlights()
//        super.performSegue(withIdentifier: "ticketSegue", sender : self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ticketSegue" {
            let obj = segue.destination as! TicketsController
            for carrier in self.carriers{
                print(carrier["Name"]!)
                print(carrier["CarrierId"]!)
            }
            print("segue")
            obj.flightDate = flightDate
            obj.destiny = destiny
            obj.placeId1 = placeId1
            obj.placeId2 = placeId2
        }
    }

}

