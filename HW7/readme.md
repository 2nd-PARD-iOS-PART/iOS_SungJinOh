😎 7차 과제_오성진
===============

URL_SERVER 화면
-----------
* **Update 전 page**
<img src="https://github.com/2nd-PARD-iOS-PART/iOS_SungJinOh/assets/103707815/2bbd109d-dac8-4bab-b165-3fa292962f06" width="300" height="600">      

* **Update modal**
<img src="https://github.com/2nd-PARD-iOS-PART/iOS_SungJinOh/assets/103707815/3d55b681-cd30-4b38-b6ea-044870fea45e" width="300" height="600">      

* **Update 후 page**
<img src="https://github.com/2nd-PARD-iOS-PART/iOS_SungJinOh/assets/103707815/13a27595-eae4-4f18-9119-358e14020df7" width="300" height="600">      

* **서버에서 받은 데이터를 나열하고 서버에 나의 데이터를 추가하는 코드이다.**      
http://3.35.236.83/pard/all: 데이터를 요청하고 받아오는 주소    
viewController에서 "추가" 버튼을 누르면 DetailViewController로 넘어가서 detail page를 구성한다.

* **오류 찾기**      
문제: detailAge와 detailPart를 전역 변수로 선언했기 때문에, detailData가 할당될 때 한번만 값을 설정한다.
해결 방법: 각각이 보여질 때 동적으로 설정할 수 있어야 한다. ->  cell을 클릭할 때마다 detailData의 값을 참조하도록 함으로써, detailData가 변경될 때마다 해당 라벨의 텍스트가 업데이트 되게 한다.
