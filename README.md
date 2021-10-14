# VlogrAnimationsSwiftPackage
이 프로젝트 활용 계획

<p align="left">
 <img width="500" src="https://user-images.githubusercontent.com/18760280/137248038-3bd01224-b5b8-4766-9953-c5dec7c078dd.png">
 </p>
  
 
 

### 애니메이션 원리 설명 (rightFall animation 예시)

<p align="left">
 <img width="500" src="https://user-images.githubusercontent.com/18760280/137101964-72fca1b3-ac0f-4547-9da6-730cee73c2d0.png">
 <img height="500" src="https://user-images.githubusercontent.com/18760280/137106584-6c327f0a-ebf9-4394-b622-533ad8b47fad.gif">
 </p>
 
 
(1) 이미지를 얹인 뷰를 애니메이션 하는 방법:
타이머를 돌려서 progress를 0부터 1까지 진행시키고 progress의 값에 해당하는 위치, 크기, 각도를 새롭게 읽어와 이미지를 얹인 뷰에 적용시키면 애니메이션되어 보임(이 프로젝트의 데모 코드처럼)

(2) 동영상 내에 삽입하여 애니메이션 하는 방법:
기본적으로 (1)과 동일하다. t1을 progress 0으로 가정하고, t2을 progress 1로 가정하여 progress의 값에 해당하는 위치, 크기, 각도를 새롭게 읽어와 렌더링하게되면, 동영상 플레이하면 애니메이션되어 보임
<p align="left">
 <img src="https://user-images.githubusercontent.com/18760280/137107064-1971ada3-e790-4a09-a0e5-4a570317dac8.png">
 </p>



즉, 위치, 크기, 각도 등을 애니메이션 종류에 맞춰, 그리고 progress에 맞춰 리턴해줄 수 있으면 애니메이션이 구현 가능하다.

이 프로젝트에서 구현된 애니메이션 객체들이 위 내용들을 구현하고 있다.

<p align="left">
 <img width="500" src="https://user-images.githubusercontent.com/18760280/137109165-d2d3f364-eb28-422a-b13a-d3253b7c1dc2.png">
</p>

func result(translation:inout CGPoint, rotation:inout CGFloat, scale:inout CGFloat, alpha: inout CGFloat, progress:CGFloat, inputVariable:VlogrAnimation.InputVariable) {
 //
 // return되는 값은 translation, rotation, scale, 그리고 alpha값
}
