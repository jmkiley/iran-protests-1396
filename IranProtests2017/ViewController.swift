//
//  ViewController.swift
//  IranProtests2017
//
//  Created by Jordan Kiley on 1/2/18.
//  Copyright © 2018 Jordan Kiley. All rights reserved.
//

import Mapbox

class ViewController: UIViewController, MGLMapViewDelegate {
    
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    var mapView : MGLMapView!
    var layer : MGLCircleStyleLayer!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MGLMapView(frame: view.bounds, styleURL: MGLStyle.darkStyleURL())
        mapView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        mapView.delegate = self
    mapView.setCenter(CLLocationCoordinate2D(latitude: 32.4356, longitude: 53.8330), zoomLevel: 4, animated: false)
        view.insertSubview(mapView, belowSubview: segmentedControl)
        
        segmentedControl.addTarget(self, action: #selector(toggledDate(_:)), for: .valueChanged)
    }

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        if let url = URL(string: "mapbox://jordankiley.cjbwwp8u32q0431mnee2hdvv7-8t5y5") {
            let source = MGLVectorSource(identifier: "protests", configurationURL: url)
            style.addSource(source)
            
            layer = MGLCircleStyleLayer(identifier: "protests-layer", source: source)
            layer.sourceLayerIdentifier = "iran-protests"
            layer.circleRadius = MGLStyleValue(rawValue: 8)
            
            let colorStops = ["7-Dey" : MGLStyleValue(rawValue: UIColor(red:0.93, green:0.89, blue:0.05, alpha:1.0)),
                              "8-Dey" : MGLStyleValue(rawValue: UIColor.orange),
                              "9-Dey" : MGLStyleValue(rawValue: UIColor(red:0.73, green:0.23, blue:0.25, alpha:1.0)),
                              "10-Dey" : MGLStyleValue(rawValue: UIColor.purple),
                              "11-Dey" : MGLStyleValue(rawValue: UIColor(red:0.19, green:0.30, blue:0.80, alpha:1.0)),
                              "12-Dey" : MGLStyleValue(rawValue: UIColor(red:0.15, green:0.58, blue:0.38, alpha:1.0))
            ]
            layer.circleColor = MGLStyleValue(interpolationMode: .categorical, sourceStops: colorStops, attributeName: "first-protest", options: nil)
            for styleLayer in style.layers {
                if styleLayer.isKind(of: MGLSymbolStyleLayer.self) {
                    style.insertLayer(layer, below: styleLayer)
                    break
                }
            }
            segmentedControl.isHidden = false
        }
    }
    
    @objc func toggledDate(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            layer.circleOpacity = MGLStyleValue(interpolationMode: .categorical, sourceStops: ["true" : MGLStyleValue<NSNumber>(rawValue: 1)], attributeName: "7-Dey", options: [.defaultValue : MGLStyleValue<NSNumber>(rawValue: 0)])
        case 1:
            layer.circleOpacity = MGLStyleValue(interpolationMode: .categorical, sourceStops: ["true" : MGLStyleValue<NSNumber>(rawValue: 1)], attributeName: "8-Dey", options: [.defaultValue : MGLStyleValue<NSNumber>(rawValue: 0)])
        case 2:
            layer.circleOpacity = MGLStyleValue(interpolationMode: .categorical, sourceStops: ["true" : MGLStyleValue<NSNumber>(rawValue: 1)], attributeName: "9-Dey", options: [.defaultValue : MGLStyleValue<NSNumber>(rawValue: 0)])
        case 3:
            layer.circleOpacity = MGLStyleValue(interpolationMode: .categorical, sourceStops: ["true" : MGLStyleValue<NSNumber>(rawValue: 1)], attributeName: "10-Dey", options: [.defaultValue : MGLStyleValue<NSNumber>(rawValue: 0)])
        case 4:
            layer.circleOpacity = MGLStyleValue(interpolationMode: .categorical, sourceStops: ["true" : MGLStyleValue<NSNumber>(rawValue: 1)], attributeName: "11-Dey", options: [.defaultValue : MGLStyleValue<NSNumber>(rawValue: 0)])
        case 5:
            layer.circleOpacity = MGLStyleValue(interpolationMode: .categorical, sourceStops: ["true" : MGLStyleValue<NSNumber>(rawValue: 1)], attributeName: "12-Dey", options: [.defaultValue : MGLStyleValue<NSNumber>(rawValue: 0)])
        default:
            layer.circleOpacity = MGLStyleValue(rawValue: 1)
        }
    }

}

