# Groongaドキュメント読書会#4参加レポート

2014/8/25に開催されたGroongaドキュメント読書会#4の参加レポートです。

今回初めて参加させていただきました。

読書会で学んだことのうち、ドキュメントに記載されていないことを
中心にまとめています。

## 4.4.1. JavaScriptに似た文法での絞込・全文検索
[ドキュメント](http://groonga.org/ja/docs/tutorial/search.html#narrow-down-full-text-search-by-using-syntax-like-javascript)

* queryとfilterは書き方の違いだけなのか？
  * 書き方の違いだけで、処理的には同じ。
  * filterの方が表現力が高い。

## 4.4.2. scorer を利用したソート
[ドキュメント](http://groonga.org/ja/docs/tutorial/search.html#sort-by-using-scorer)

* --filter "1"
  * 全てのレコードにマッチさせる、という意味。
  * --filterすると結果として仮想テーブル的なものができる。
  * 仮想テーブル的なものに\_scoreがついてるイメージ。
* --scorer "\_score = rand()"
  * ランダム値を\_scoreに代入。
  * --scorerを使うと元々あるカラム(\_score以外のカラム)の値を変えることもできてしまうが、基本的には\_scoreの値を調整することを意図した機能。
* selectの結果で返されるデータの中で、最初の値が三つ入っている配列は何？
  * 第一要素: 結果ステータス (0 = 正常終了)
  * 第二要素: クエリの実行を開始した時間
  * 第三要素: 開始したのにかかった時間

## 4.4.3. 位置情報を用いた絞込・ソート
[ドキュメント](http://groonga.org/ja/docs/tutorial/search.html#narrow-down-sort-by-using-location-information)

* 緯度、経度の区切り文字にはカンマも使える。
* 距離計算や円の中にあるかどうか、矩形の中にあるかどうかなどが関数で計算できる。
* 球面を考慮して計算するモードや平面と見なして計算するモードがある。
* Groongaは内部表現はできるだけ整数にしている（計算誤差を減らすため）。
* 度数表記は60進数なので60をかけてミリ秒表記に変換できる。
* ミリ秒表記のデータをもっているならそのまま使った方がいい。

## 4.5. ドリルダウン
[ドキュメント](http://groonga.org/ja/docs/tutorial/drilldown.html)

* ドリルダウンとはRDBのGROUP BYのような処理ができる機能。
* サンプルコードで指定している--limit 0とは？
  * 出力件数を0にしている。
  * drilldownは普通のセレクト結果+drilldown結果を返す。
  * この例ではselectの出力は余計なので--limit 0で抑制している。
* \_nsubrecsはエヌサブレックスと読む。
* Groongaは複数のGROUP BYを一回でできる = 効率よくクエリを実行できる。
* drilldown対象のカラム
  * 文字列だと比較コストがかかる（一致しているかどうかは一文字ずつ調べないとわからない）。
  * 参照だとIDだけ入ってるイメージなので圧倒的に早くなる。

## 4.5.1. 複数のカラムでドリルダウン
[ドキュメント](http://groonga.org/ja/docs/tutorial/drilldown.html#drilldown-with-multiple-column)

特になし。

## 4.5.2. ドリルダウン結果をソートする
[ドキュメント](http://groonga.org/ja/docs/tutorial/drilldown.html#sorting-drildown-results)

特になし。

## 4.5.3. ドリルダウン結果の制限
[ドキュメント](http://groonga.org/ja/docs/tutorial/drilldown.html#limits-drildown-results)

* --drilldown-limitsは間違い。--drilldown-limitが正しい。

## 4.6.1. タグ検索
[ドキュメント](http://groonga.org/ja/docs/tutorial/index.html#tag-search)

* 「@」は転置インデックスを使うという意味
* —match-columns と--tags でも同じことができる、その場合は@不要
* Groonga では転置インデックスはただのカラムの１つ
  * インデックスカラムというカラムが存在する
  * インデックスを貼るというよりはインデックスカラムを作っている、という感じ？振り返ってみるとこの辺が曖昧。
