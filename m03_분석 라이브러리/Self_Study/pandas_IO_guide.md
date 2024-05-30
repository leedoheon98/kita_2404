# How to Handle Input and Output in Pandas

To upload any local file to Colab
```
from google.colab import files

# 파일 업로드
uploaded = files.upload()

```
pandas.DataFrame  <-->  csv | excel  file
```
# read_csv()
import pandas as pd
df = pd.read_csv('data.csv')

# to_csv()
import pandas as pd
df = pd.to_csv('data.csv', index=False)   # index=True로 할 시 csv나 excel 파일에 의도치 않은 임의 인덱스가 추가될 수 있음.

# read_excel()
import pandas as pd
df = pd.read_excel('data.xlsx')

# to_excel()
import pandas as pd
df = pd.to_excel('data.xlsx', index=False)   # index=True로 할 시 csv나 excel 파일에 의도치 않은 임의 인덱스가 추가될 수 있음.
```
DataFrame Browse
```
# head
df.head()        >> Args : n= ( number, default=5 )

# tail
df.tail()        >> Args : n= ( number, default=5 )

# describe       >> Generate descriptive statistics
df.describe()

# info           >> Print a concise summary of a DataFrame
df.info()
