# getstarted-webpage-gulp
Web制作用にhaml、bower、sassのコンパイルや配置をgulpで回すテンプレート。
（ベンダープレフィックス付与、Image圧縮、ローカルサーバー、browserSync有り）

### 準備するもの
* [node.js](https://nodejs.org/download/)

### cloneしたら
1. `npm install`
1. `bower install`
    - jQuery, jQuery-UI, font-Awesomeが導入
1. `gulp getstart`
    - ここでbowerからのライブラリを整理して、初期のコンパイルが走る
1. `gulp watch`
    - 上記のコンパイルをするためにフォルダを監視し、更新するたび自動でreloadするローカルテストサーバーが立ち上がる。コンパイルされたものは`dist/`にいく

### 制作の仕方
* hamlディレクトリの中でhamlまたはhtmlで作成
* jsは`app.js`に記述します。新しくファイルを作っても問題無いですが、`common.js`でjQuery含み外部JSファイルを読み込んでいるので、こちらにも記載してください。
* cssは`/sass/`の中で`style.scss`内に記述します。ベンダープレフィックスが自動で付与されます。
* 画像は`/images/`に配置してください。圧縮され、`/dist/images/`に配置されます。

すべて、`gulp watch`している状態であれば、`/dist/`にコンパイルされます。  
※`gulp watch`していない時の変更をコンパイルしたい場合は、`gulp`と実行してください。

成果物としては、`dist`となります。

### こんなとき
#### bowerで管理するライブラリを増やしたい
```
bower install jquery --save
gulp getstart
```

1行目でライブラリを指定します。bowerのcomponentディレクトリから引っ張ってくるため`gulp getstart`を実行します。なお、`--save`オプションを付けた場合、以降`bower install`で引っ張ってこれます。（詳しくは*bower.json*を確認するといいかもしれません。

また、`/js/common.js`に読み込み用の記述が必要です。

#### hamlを使いたくない
hamlディレクトリの中に`*.html`をおけば、そちらが優先されるようになってます。