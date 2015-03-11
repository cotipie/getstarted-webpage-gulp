# getstarted-webpage-gulp
Web制作用にhaml、bower、sass、をgulpで回すテンプレート

### 準備するもの
* nodeとか

### cloneしたら
1. `npm install`
1. `bower install`
    - jQuery, jQuery-UI, font-Awesomeが導入済み
1. `gulp initstart`
    - ここでbowerからのライブラリを整理する
1. `gulp (default)`
    - コンパイルする。haml（Compile, Minify）, sass（AutoPrefix, Compile, Minify）, js（Minify）
1. `gulp watch`
    - 上記のコンパイルをするためにフォルダを監視する。基本的にコンパイルされたものは`webdev/`にいく


### 注意
* 特にエラーキャッチ等はしていません
* ServerSyncはなし
* Image圧縮もなし
