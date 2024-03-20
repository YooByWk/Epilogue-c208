# 플러터 무한 스크롤 구현을 위한 몸부림

> 인스타그램은 정말 엄청난 무한스크롤의 성지였다. 대단해.

## 무한 스크롤이란


## 무한 스크롤 구현 전 분석


### 구성요소
최상단요소 (여기서는 `screen`) :

```
Screen
|-- appBar  
    
|-- NestedScrollView : 스크롤을 공유시키기 위함
    |-- headerSliverBuilder :   
        |-- SliverList (screen 정보 출력 공간)  
    |-- body :
        |-- DetailTabBar : (탭 구분 후 이하 무한 스크롤 구현)
            |-- Column 
                |-- TabBar
                |-- Expanded
                      |-- TabBarView (무한스크롤)
                          |-- Tab1 (그리드 3) 
                          |   |-- CustomScrollView
                          |       |-- SlicverGrid
                          |           |-- Card
                          |-- Tab2 (그리드 1)
                          |    |-- 
                          |-- Tab3 ()


```
### 