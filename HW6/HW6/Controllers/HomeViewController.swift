import UIKit

class HomeViewController: UIViewController{
    
    let sectionTitles = MovieName.sectionTitles
    let movies = MovieName.movies

    
    //HomeViewController 클래스 내에서 tableView라는 이름의 private 속성을 선언하고, 이를 초기화하는 부분
    private let tableView: UITableView = {
        let table = UITableView(frame: .zero, style: .grouped ) // tableView는 UITableView 클래스의 인스턴스이다, 초기화할 때 frame을 .zero로 설정하고, style을 .grouped로 설정한다.
        table.register(CollectionViewTableViewCell.self,  forCellReuseIdentifier: CollectionViewTableViewCell.identifier) // register 메서드를 사용하여 CollectionViewTableViewCell 클래스를 identifier로 등록한다. --> 나중에 테이블 뷰의 셀을 재사용할 때 사용된다.
        return table //이렇게 초기화된 테이블 뷰를 tableView 상수에 할당한다.
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor  = .black
        tableView.backgroundColor = .black
        view.addSubview(tableView) // 현재 뷰 컨트롤러 위에 tableView를 서브뷰로 추가한다 -> 테이블 뷰가 화면에 나타난다.
        
        // 뷰 컨트롤러가 테이블 뷰의 동작과 데이터를 관리할 수 있도록 델리게이트(delegate)와 데이터 소스(data source)를 현재 뷰 컨트롤러 자체로 설정한다.
        tableView.delegate = self
        tableView.dataSource = self
        
        configureNavBar() // configureNavBar() 메서드를 호출하여 네비게이션 바를 설정
        
        let headerView = HeroHeaderUIView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height: 500)) //HeroHeaderUIView 클래스의 인스턴스를 설정하고, 해당 뷰의 프레임을 설정한다 -> 테이블 뷰의 헤더 뷰
        tableView.tableHeaderView = headerView // 위에서 생성한 headerView를 테이블 뷰의 tableHeaderView에 설정한다. 이로써 테이블 뷰의 위쪽에 헤더 뷰가 나타나게 된다.
        
    }
    
    private func configureNavBar() {
        // Create a custom title view with labels
        let titleView = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 70)) // 네비게이션 바에 추가될 타이틀 뷰를 생성하고 크기와 위치를 설정한다. 이 타이틀 뷰에는 로고 이미지와 레이블들이 포함된다.
        
        var image = UIImage(named: "netflix") // "netflix"라는 이미지를 로드한다.
        image = image?.withRenderingMode(.alwaysOriginal) // 렌더링 모드를 .alwaysOriginal로 설정하면 이미지가 원본 색상으로 표시된다. -> 안 하면 그냥 파란색 로고
        
        // image: 이 바 버튼 아이템에 표시될 이미지를 설정한다. 이 코드에서 image 변수에는 "netflix" 이미지가 설정되어 있다.
        // style: 바 버튼 아이템의 스타일을 정의한다. .done 스타일은 일반적으로 확인 또는 완료 동작을 나타내는 스타일로, 체크 마크와 함께 표시된다.
        // target: 바 버튼 아이템이 탭되었을 때 이벤트가 전달될 대상 객체를 설정한다. 여기서 self는 현재 뷰 컨트롤러를 나타낸다. 즉, 뷰 컨트롤러 자체가 이 버튼의 탭 이벤트를 처리할 것임을 의미한다.
        // action: 바 버튼 아이템이 탭되었을 때 실행될 메서드를 설정한다. 이 경우 nil로 설정되어 있으므로 특정 메서드를 호출하지 않고, 기본적으로 바 버튼 아이템이 탭되었을 때 아무 동작도 수행하지 않는다.
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .done, target: self, action: nil)
        
        let tvShowsLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 80, height: 44))
        tvShowsLabel.text = "TV Shows"
        tvShowsLabel.textColor = .white
        tvShowsLabel.font = .systemFont(ofSize: 14)
        titleView.addSubview(tvShowsLabel)

        let moviesLabel = UILabel(frame: CGRect(x: 100, y: 0, width: 60, height: 44))
        moviesLabel.text = "Movies"
        moviesLabel.textColor = .white // 폰트 색상: white
        moviesLabel.font = .systemFont(ofSize: 14) // 폰트 크기 14
        titleView.addSubview(moviesLabel) // moviesLabel을 titleView에 추가한다.
        
        let myListLabel = UILabel(frame: CGRect(x: 190, y: 0, width: 60, height: 44))
        myListLabel.text = "My List"
        myListLabel.textColor = .white
        myListLabel.font = .systemFont(ofSize: 14)
        titleView.addSubview(myListLabel)

        // Set the custom title view as the navigation title
        navigationItem.titleView = titleView // 위에서 생성한 titleView를 네비게이션 바의 타이틀 뷰로 설정한다. -> 네비게이션 바에 로고 이미지와 레이블들이 포함된 사용자 정의 타이틀 뷰가 표시된다.
    }

    //이 코드는 화면의 크기나 회전 등 레이아웃이 변경될 때마다 테이블 뷰를 현재 뷰의 크기에 맞게 다시 조정하는 역할을 한다. 이렇게 하면 화면의 크기나 방향이 변경되더라도 테이블 뷰가 항상 뷰 컨트롤러의 전체 화면을 채우도록 보장된다.
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds // 테이블 뷰(tableView)의 프레임을 현재 뷰(view)의 경계(bounds)와 일치하도록 설정한다. 이렇게 하면 테이블 뷰가 뷰 컨트롤러의 전체 화면에 채워지게 된다.
    }

    
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource{
    // HomeViewController 클래스가 UITableViewDelegate와 UITableViewDataSource 두 개의 프로토콜을 채택한다는 것을 선언
    //HomeViewController 클래스는 테이블 뷰와 관련된 이벤트와 데이터를 처리하기 위한 필수적인 메서드들을 구현해야 한다.
    //이렇게 구현된 메서드들은 테이블 뷰의 동작을 컨트롤하고 테이블 뷰에 데이터를 제공하는 데 사용된다.
    
    // 이 아래부터는 테이블 뷰(tableView)와 관련된 동작과 데이터 관리를 정의하는 메서드들
    
    //테이블 뷰의 섹션 개수
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionTitles.count
    } //  테이블 뷰에 표시할 섹션(section)의 수를 반환, sectionTitles.count를 반환하여 sectionTitles 배열의 요소 수와 같은 수의 섹션을 생성한다.
    
    // 각 섹션의 행 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    } // 특정 섹션(section)에 포함된 행(row)의 수를 반환한다. 여기서는 각 섹션에 하나의 행만 표시하기 위해 항상 1을 반환하고 있다. 따라서 각 섹션에 한 개의 행만 표시된다.
    
    // 각 행에 표시할 셀을 관리 (재사용 가능한 셀이 있는지 먼저 확인하고, 있다면 재사용하며, 없다면 새로 만든다.)
    // 각 행(row)에 대한 테이블 뷰 셀(cell)을 반환한다.
    // "dequeueReusableCell(withIdentifier:for:)" 메서드를 사용하여 재사용 큐(reuse queue)에서 셀을 가져오려고 시도한다. CollectionViewTableViewCell.identifier를 사용하여 CollectionViewTableViewCell 클래스의 셀을 가져오려고 한다.
    // 만약 재사용 가능한 셀이 없거나 타입 캐스팅(type casting)에 실패하면 기본 UITableViewCell을 반환한다. 그러나 일반적으로는 재사용 가능한 CollectionViewTableViewCell 셀이 반환된다.
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CollectionViewTableViewCell.identifier, for: indexPath) as! CollectionViewTableViewCell
        
        // 배열에서 image 이름을 cell에 할당
        cell.imageNames = movies[indexPath.section]
        cell.backgroundColor = .black
        
        cell.selectionStyle = .none

        return cell
    }

    
    //  특정 행(row)의 높이를 반환
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 200
    } // 모든 행의 높이를 고정값으로 200 포인트로 설정하고 있으므로, 모든 행의 높이가 동일하게 된다.
    
    // 특정 섹션(section)의 헤더 뷰를 반환
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView() // UIView 타입의 headerView라는 인스턴스를 생성, 이 뷰는 섹션 헤더를 나타내는 역할
        headerView.backgroundColor = .black // 섹션 헤더의 배경색을 검은색으로 설정
        
        let label = UILabel() // UILabel 인스턴스인 label을 생성
        label.text = sectionTitles[section] // 각 섹션의 제목(sectionTitles[section])이 각 섹션 헤더에 표시될 텍스트를 나타낸다.
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        // label.frame = CGRect(x: 20, y: 0, width: tableView.frame.width - 20, height: 40)
        label.frame = CGRect(x: view.safeAreaInsets.left, y: 0, width: tableView.frame.width - (view.safeAreaInsets.left + 20), height: 40)
        // label의 프레임을 설정 -> label은 섹션 헤더의 일정한 위치와 크기에 표시된다.
        // view.safeAreaInsets.left: 안전한 영역(상태 바 또는 네비게이션 바가 있는 경우)에서 왼쪽 여백이다.
        // "tableView.frame.width - (view.safeAreaInsets.left + 20)"는 테이블 뷰의 너비에서 여백을 뺀 너비로, label의 너비를 설정
        
        headerView.addSubview(label) // label 레이블을 headerView에 서브뷰로 추가한다. 이로써 label이 섹션 헤더 내에서 표시된다.
        
        return headerView // 생성한 headerView를 반환한다. -> 각 섹션의 헤더로 사용될 커스텀 뷰가 테이블 뷰에 표시되게 된다.
    }
    
    // 특정 섹션의 헤더 뷰의 높이를 반환
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    } // 모든 섹션의 헤더 뷰 높이를 고정값으로 40 포인트로 설정하고 있으므로, 모든 섹션의 헤더 뷰 높이가 동일하게 된다.

//    // 특정 섹션의 헤더에 표시할 제목 문자열을 반환
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        print("header")
//        return sectionTitles[section]
//    } // sectionTitles 배열에서 해당 섹션의 제목을 가져와 반환
    

}


