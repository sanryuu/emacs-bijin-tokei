# bijin-tokei.el

## 概要
bijin-tokei.elは[美人時計](http://www.bijint.com/)をEmacs上で閲覧するための拡張です。  
開始すると\*binin-tokei\*バッファ内の時計が毎分切り替わって対象時刻の画像が表示されます。

## インストール

### コマンドにて
```
M-x auto-install-from-url "https://raw.githubusercontent.com/sanryuu/emacs-bijin-tokei/master/bijin-tokei.el"
```
### 設定ファイルにて

設定ファイルに以下の追記をします。

```
(require 'bijin-tokei)
```
## 使い方

### 開始時
```
M-x bijin-tokei-start
```
### 終了時
```
M-x bijin-tokei-stop
```

## カスタマイズ

コンテンツのジャンルを変えて他のジャンルのものも見ることができます。  
以下は美男時計にする例。

```el
(setq bijin-tokei-genre "binan")
```

現状で使えるものはbijin-tokei-genre-listの変数にリストで入っていて
以下のようなものがあります。
+ jp
+ osaka
+ nagasaki
+ kanazawa
+ hiroshima
+ kagawa
+ tochigi
+ fukui
+ akita
+ gumma
+ chiba
+ hokkaido
+ kobe
+ niigata
+ kanagawa
+ binan
