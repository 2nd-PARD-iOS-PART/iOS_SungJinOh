//
//  ViewController.swift
//  URLSession_server
//
//  Created by 김하람 on 2023/11/02.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    var pardData: PardData? //초기값을 모르기 때문에 옵셔널 ? 붙여준다.
    let urlLink = "http://3.35.236.83/pard/all" // 서버 주소 _ read를 위한
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout() // UICollectionViewFlowLayout의 인스턴스
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.register(UrlCollectionViewCell.self, forCellWithReuseIdentifier: "UrlCollectionViewCell") // UrlCollectionViewCell)을 컬렉션 뷰에 등록, 나중에 셀을 대기열에서 가져올 때 사용
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUi()
        getData() // 서버에서 데이터를 가져오는 메서드
        setupCollectionView() // 컬렉션 뷰를 설정하는 메서드
        // notificationCenter에 observer 추가하기
        NotificationCenter.default.addObserver(self, selector: #selector(reloadCollectionView), name: .addNotification, object: nil) //NotificationCenter에 현재 뷰 컨트롤러를 옵저버로 추가, .addNotification이라는 이름의 특정 노티피케이션을 받을 때마다 reloadCollectionView() 메서드를 실행
    }
    
    @objc func reloadCollectionView() {
        DispatchQueue.main.async { // UI 업데이트는 주로 main thread에서 이루어짐 -> main thread에서 비동기적으로 작업을 수행하기 위해 DispatchQueue를 사용
            self.getData() // 서버에서 새로운 데이터를 가져옴.
            self.collectionView.reloadData() // 컬렉션 뷰를 다시 로드 -> 컬렉션 뷰의 데이터가 변경되었음을 시스템에 알리고, UI를 갱신하여 새로운 데이터를 반영
        }
    }
    
    // notification 해제
    deinit {
        NotificationCenter.default.removeObserver(self) // deinit에서 옵저버를 제거 -> 해당 뷰 컨트롤러가 메모리에서 해제될 때 옵저버도 함께 정리되고 메모리 누수를 방지함.
    }
    
    func setUi(){
        let title: UILabel = {
            let label = UILabel()
            label.text = "UrlSession"
            label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
            return label
        }()
        let addButton: UIButton = {
            let button = UIButton(type: .custom)
            button.setTitle("추가", for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
            button.setTitleColor(.systemBlue, for: .normal)
            button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
            return button
        }()
        view.addSubview(title)
        view.addSubview(addButton)
        
        title.translatesAutoresizingMaskIntoConstraints = false
        addButton.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: view.topAnchor, constant: 100 ),
            title.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            addButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            addButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // add버튼 추가 시, 추가하기 위한 모달창이 뜬다.
    @objc func addButtonTapped(){ // "추가" 버튼이 눌리면 CreateViewController()이 모달 형식으로 열림.
        let addDataVC = CreateViewController()
        print("button tapped")
        self.present(addDataVC, animated: true, completion: nil)
    }
    
    // collectionView 설정을 위한 함수
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 150),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 20),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    // 서버에 저장 돼 있는 데이터를 불러온다.
    func getData(){
        if let url = URL(string: urlLink) {
            let session = URLSession(configuration: .default)
            // 지정된 URL의 내용을 검색하는 작업을 만든(create)다음, 완료 시 handler(클로저)를 호출
            // 클로저 앞에 @escaping이 있으면 함수의 작업이 완료된 후에 클로저가 호출된다.
                // data: 서버에서 반환된 데이터
                // response: HTTP 헤더 및 상태 코드와 같은 응답 메타 데이터를 제공하는 객체
                // error: 요청이 실패한 이유
            // 작업 후에는 반드시 resume()를 호출해야 한다.
                // 작업이 일시중단된 경우 다시 시작하는 것
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                // JSON data를 가져온다. optional 풀어줘야 함
                if let JSONdata = data {
                    let dataString = String(data: JSONdata, encoding: .utf8) //얘도 확인을 위한 코드임
                    print(dataString!)
                    // JSONDecoder 사용하기
                    let decoder = JSONDecoder() // initialize

                    // .self를 붙이는 것 = static metatype을 .self 라고 한다. 꼭 넣어줘야 한다.
                    // 자료형이 아닌 변수 값을 써줘야 하므로 .self를 붙여준다.
                    // try catch문을 사용해야 함
                    do { //json형식으로 디코딩 한다.
                        let decodeData = try decoder.decode(PardData.self, from: JSONdata)
                        self.pardData = decodeData
                        // 데이터를 가져온 후 collectionView를 메인 스레드에서 리로드_반드시 해야 화면에서 보임.
                        DispatchQueue.main.async {
                            // reloadData를 써주면 된다. 다시 로드하기 위함.
                            self.collectionView.reloadData()
                        }
                    } catch let error as NSError {
                        print("🚨", error)
                    }
                }
            }
            // task가 준비만 하고 멈춰있기 때문.
            task.resume()
        }
    }
    
    // MARK: - 여기부터는 collectionView를 위한 설정들
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { // 각 컬렉션 뷰의 섹션에 표시할 아이템의 개수
        return  pardData?.data.count ?? 0 // pardData가 옵셔널 형태일 때, data 배열의 아이템 개수를 반환하거나 pardData가 nil일 경우 0을 반환 -> 데이터 소스가 옵셔널일 때 안전하게 접근 가능./
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UrlCollectionViewCell", for: indexPath) as! UrlCollectionViewCell // 재사용 큐에서 셀을 가져오거나 새로 생성, UrlCollectionViewCell 클래스로 캐스팅하여 해당 셀
        let nameData = pardData?.data[indexPath.row] // pardData에서 해당 인덱스의 데이터를 가져온다 -> 이 데이터는 컬렉션 뷰에 표시될 개별 아이템.
        cell.nameLabel.text = nameData?.name // 데이터에서 가져온 이름 정보를 셀의 레이블에 설정
        
        if let urlString = nameData?.imgURL, let url = URL(string: urlString) // // 데이터에서 이미지 URL을 가져와 URL 객체로 변환
        {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    DispatchQueue.main.async {
                        cell.images.image = UIImage(data: data)
                    }
                }
            }.resume() // 비동기적으로 이미지를 다운로드하고 해당 셀의 이미지 뷰에 설정.
        }
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 200)
    } // 각 셀의 크기를 폭 160, 높이 200으로 설정
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    } // 섹션에 대한 상하좌우로 10의 여백을 설정
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    } // 섹션 내의 아이템(셀) 간의 최소 수평 간격을 10으로 설정
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedData = pardData?.data[indexPath.row] {
            let detailVC = DetailViewController(data: selectedData)
            present(detailVC, animated: true, completion: nil)
        }
    } // 선택한 셀의 데이터를 가져와 DetailViewController를 해당 데이터로 초기화한 후, 모달로 화면에 표시
}


