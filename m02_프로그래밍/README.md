# *'task_0424'*  
다양한 솔루션 : isalnum() 메서드 활용, re.match(r' ',x) 활용, isidentifier() 활용  

**정규 표현식** : 프로그래밍에서 문자열을 다룰 때, 문자열의 일정한 패턴을 표현하는 일종의 형식 언어를 말한다. 정규식이라고도 부르며, 보통 RegEx 혹은 RegExp라 많이 쓴다.  
  
^ ~ $
\b: 문자와 공백 사이를 의미한다.  
\c: 제어 문자를 의미한다.  
\d: 숫자에 해당하는 유니코드에 대응. [0-9]와 달리 아랍 문자, 페르시아 문자 등 다양한 숫자를 포괄한다.  
\f: 폼 피드  
\n: 개행 문자  
\s: 공백 문자  
\t: 탭 문자  
\v: 수직 탭  
\w: 단어 영문자+숫자+_(밑줄) [0-9a-zA-Z_]  
\x: 16진수 값  
\0: 8진수 값  
  
# 리스트
list.sort(reverse=True) : 내림차순  
list1[::-1] : 리스트 거꾸로 나열  
리스트명[start : end : step]  
  
# *'task_0425'*  
Q1. 리스트의 최소값, 최대값 구하기 : min(), max() 메서드 이용해서 하기, lst.sort() 이후 0번째 인덱스와 -1번째 인덱스를 출력하기. for 문으로 크기를 하나씩 비교하기  
Q2. 합계 / len() 도 가능하고, numpy 모듈을 import 해서 np.mean() 메서드 활용도 가능  
Q3. indexes=[index for index, value in enumerate() if value == target ] 와 같이도 풀이 가능  
 (index와 value 값을 enumerate(lst) 값에서 가져와서 value 는 target 과 비교하기위해 사용하고 index는 index 를 뽑기 위해 'index for index ---' 와 같이 사용  
Q4. 핵심은 연속적인 반복요소만 제거이기 때문에 리스트 안 요소 하나만 가져와서 -1 과 비교해서 같지않을때만 append. (만약 연속적인 리스트가 아니라면 sort를 하면 똑같이 사용가능)  
