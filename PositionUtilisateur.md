# Localisation de l'utilisateur





## Description

La fonctionnalité bonus choisie est la présentation des conditions météorologiques pour la ville dans laquelle se trouve l'utilisateur au moment où il en fait la demande.



Nous utilisons le framework [Core Location](https://developer.apple.com/documentation/corelocation) d'Apple pour intégrer cette fonctionnalité.



_N.B. : Les numéros d'entrées des commentaires du code font référence aux lignes de code._



## Intégration

+ Création d'une instance de CLLocationManager afin d'accéder au framework :

```swift
let locationManager = CLLocationManager()
```





+ Création d'une demande d'autorisation d'accès à la position de l'utilisateur, dans info.plist. (La description est présentée à l'utilisateur dans une fenêtre pop-up).

![infoPlist_auth_localisation](/Users/morgan/Documents/OpenClassrooms/P9_Le_Baluchon/infoPlist_auth_localisation.png)





+ Dans viewDidLoad() :

```swift
locationManager.requestWhenInUseAuthorization()
startReceivingLocationChanges()
```

1. Lorsque la vue des conditions météorologiques est chargée en mémoire lors de la première utilisation de l'application, la demande d'autorisation est présentée à l'utilisateur.
2. Le système commence à mettre à jour la position de l'utilisateur (sous réserve de l'accord de l'utilisateur).





+ Dans viewWillAppear() :

```swift
override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)

    if CLLocationManager.authorizationStatus() != .denied {
        setUpDisplay()
        if Places.cities.count != 1 { callService() } else { return }
    } else {
        locationAuthorizationAlert()
    }
}
```

4. Vérification de l'autorisation d'accès à la position de l'utilisateur, mise à jour de l'interface et lancement des appels réseaux.

8. Présentation d'une fenêtre pour informer l'utilisateur que sans son autorisation, les conditions météorologiques pour la ville dans laquelle il se trouve ne seront pas présentées.

   



+ Création d'une extension au ViewController :

```swift
extension WeatherViewController {

    private func startReceivingLocationChanges() {
        locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        locationManager.distanceFilter = 1000.0  // In meters.
        locationManager.delegate = self
        locationManager.startUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager,  didUpdateLocations locations: [CLLocation]) {
        let lastLocation = locations.last!
        locationManager.stopUpdatingLocation()

        Places.addCurrentLocation((lastLocation.coordinate.latitude, lastLocation.coordinate.longitude))

        callService()
        }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .notDetermined:
            break
        case .authorizedWhenInUse:
            // If authorized when in use
            manager.startUpdatingLocation()
            break
        case .authorizedAlways:
            // If always authorized
            manager.startUpdatingLocation()
            break
        case .restricted:
            // If restricted by e.g. parental controls. User can't enable Location Services
            break
        case .denied:
            locationAuthorizationAlert()
            break
        default:
            break
        }
    }

}
```

4. La précision de la position de l'utilisateur est au kilomètre près (cette précision est largement suffisante car en effet, nous souhaitons connaître la ville dans laquelle se trouve l'utilisateur).

5. La mise à jour de la position est déclenchée lorsque la nouvelle position de l'utilisateur excède un rayon de 1000 mètres par rapport à la position précédente.
6. Le weatherViewController est le délégué de locationManager.
7. Le système met à jour la position de l'utilisateur.



11. Création de la dernière position connue.

12. Arrêt de la mise à jour de la position.


14. Ajout des coordonnées de position au tableau Places (cf Model/Weather/Places).



16. Lancer un appel réseau pour chaque lieu de Places


19. Le système est notifié du changement de statut de l'autorisation d'utiliser la position de l'utilisateur. Cela permet de lancer la mise à jour de la position, de prévenir l'utilisateur des conséquences de son refus, etc.