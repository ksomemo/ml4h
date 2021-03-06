ml4h
# 入門機械学習で気づいたこと

## R Studioについて
* Option + _ を入力すると代入を表す「 <- 」が入力される
* Option + ¥ を入力してもバックスラッシュが入力されない
* バックスラッシュを入力するには、￥を全角入力してから変換する
* Consoleで大量のデータ操作を行うと消費メモリが多くなったままになる

## R2系と3系の違い
* 関数に違いがあるので書籍のままでは実行できないので注意する
* 上記、引数名の間違いの場合もあったので気をつける…

### read.delimのパラメータ

* sep = "\t" はデフォルトになっている
* stringAsFactors = FALSE は不要
* 上記はstringsAsFactorsの間違いのため、FALSEで追加した
* na.strings = "" は不要
* 上記もstringsAsFactorsの間違いのため、省いてしまったので追加した

### ncharについて
* 以下にエラー nchar(ufo$DateOccurred) : 'nchar()' は文字ベクトルを要求します
* ufo$DateOccurred は文字ベクトルでない？
* typeof(ufo$DateOccurred[1]) で型を調べるとinteger
* as.character(x) で文字列に変換してから行う

### 型について
* typeof(x) で型を調べることができる
* データフレームはlist型
* list型はlist()で作成できる
* list型は異なる型を含んで良い
* c()ではベクトルを作成する
* ベクトルは同じ型しか含めない
* 複数の型、例として、数値と文字列を含んだら文字列に変換された
* factorベクトル（追記：ベクトルではない※is.vectorより）に対して、as.list()を実行するととてもメモリを消費する
* 上記はfactorであったときのことである（追記：read.delimにfactorに関するオプションの指定なし）
* またtypeof(factor) の結果は、integerである
* しかし、is.integer() の結果はFALSEであり、is.factor() の結果はTRUEである
* typeof() で調べられる結果は実際の型であり、factorはintegerのaliasである？
* 上記のメモリを消費する問題はread.delim() に、stringsAsFactors=FALSEを指定したら問題なく通った。

## Rについて
* ?関数などの名前で Helpが表示される
* c() バラバラの値を１つにつなげる(ベクトルの作成？)
* ベクトル同士の足し算も出来るが、長さが一致しなければならない(数値)
* ベクトルのスカラー倍も可能である
* names(x) <- c() ヘッダーを変更する
* 数値のrangeは、start:endであり逆順も可能である
* 文字列のrangeは存在しない
* letters smallAlphabets
* lettersの要素は[]とindex(１からの指定)で取得できる
* []の指定はrangeによる指定も可能である
* Rオブジェクトを操作する
* 上記の列名にアクセスするには、Rオブジェクト[index]とする
* 上記の列名に名前でアクセスするには、Rオブジェクト$列名 とする
* 上記を実行すると列の値一覧を表示する
* よって列すべての値に対して操作を行うことが出来る
* asによる型変換を行うことができる
* ex) as.Dateによる日付フォーマット変換→不正なものは変換できない
* headを列に対して行ってもすぐに処理が終わらない
* whichによる条件を満たすレコードのみの取得
* Viewでデータフレームを2次元表として表示できる
* lapplyで適用した関数をfixしている fixとは?(メモリ消費量がやばい)
* fix() は、データを編集するウィンドウを表示する関数である
* 上記、適用した関数が文字列を要求していたのにfactor(実際integer)を渡していたため問題なしとする

```R
# 各属性を含むデータフレームとしてアクセス
typeof(train["job"])
typeof(train["age"])
is.factor(train["job"])
is.factor(train["age"])

# 各属性のみからなるベクトルとしてアクセス
typeof(train[["job"]])
typeof(train[["age"]])
is.factor(train[["job"]])
is.factor(train[["age"]])

# 上記同様
typeof(train$job)
typeof(train$age)
is.factor(train$job)
is.factor(train$age)
```
