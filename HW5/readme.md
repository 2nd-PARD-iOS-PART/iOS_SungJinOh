😎 5차 과제_오성진
===============

ComingSoon Page 화면
-----------
<img src="https://github.com/2nd-PARD-iOS-PART/iOS_SungJinOh/assets/103707815/6ad84e1a-b645-4c8b-bde9-9d456cf7da46" width="300" height="600">

* **넷플릭스에서 새롭게 업데이트 되는 작품들을 나열한 화면이다.**
1. NavigationBar에 알람 image와 "Notification" text label이 있다.
2. 1개의 section에 3개의 cell이 있다.
3. 각 cell마다 image와 작품을 설명하는 text label이 있다.
4. cellForRowAt 메서드에서 cell을 구성했다.


Detail Page 화면
-------------

<img src="https://github.com/2nd-PARD-iOS-PART/iOS_SungJinOh/assets/103707815/c99cab21-b9bb-420c-8c7f-1e6cc7f53579" width="300" height="600">


* **Home page에서 특정 작품을 click하면 해당 작품에 대한 세부 정보를 제공하는 화면이다.**

1. 최상단에 click한 작품의 image가 있다.
2. image 위에는 close button과 play button이 있다.
3. 그 아래에는 제목, 세부 정보, play button, download button 등의 button과 image가 있다.

* dictionary를 사용하여 이미지 이름과 제목을 매핑했다. -> 사실 데이터 모델을 만들고 해당 데이터 모델에 따라 이미지와 제목을 관리하는 것이 더 좋음.
