import UIKit
import Firebase
import GoogleMaps

class MenuPrincipalViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true

        
    }
    
    override func loadView() {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        let camera = GMSCameraPosition.camera(withLatitude: 19.72, longitude: -101.18, zoom: 15)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 19.72, longitude: -101.18)
        marker.title = "Morelia"
        marker.snippet = "México"
        marker.map = mapView
    }
    
    @IBAction func cerrarSesionButtonItem(_ sender: UIBarButtonItem) {
        do {
            try Auth.auth().signOut()
            view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        catch let signOutError as NSError {
            print ("Error al cerrar sesión: %@", signOutError)
        }
        
    }
    
}
