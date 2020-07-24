

#laravel_base ~ 開発環境のベース ~

### 内容
**開発環境**: Docker（ Laradock https://laradock.io/ ）
**フレームワーク**: Laravel6.2
**言語**: PHP7.38

### 設計の概要
　パワポに図を書く

### テストのレシピ
実装内容のグラデーションの選択をする必要がある。要はどこまでテストを行うのかをプロジェクトで始動時に決めておく。
正常系だけ実装するか、異常系も実装するか、ユースケース、コントローラーなどどの層までテストを行うか
すべて行えれば良いが、テストコードを書くということは、開発期間が長くなってしまうので、書いて恩恵の得られにくい箇所は行わないなどの設定を考えて良い。

テストコードのレシピを考えるべきことは多く分けて二つある。
①影響範囲を網羅すること
リリース後のプログラムに変更などがあった際、テストコードを実行し、テストが失敗すれば、プログラムとして正常に動作しないことがわかるからである。ただし正しく動いているか、動いていないかは、テストで網羅されていないと逃してしまうので網羅すること。なので最悪正常系の動作のみテストを書くことは選択肢の一つである。
またコントローラーの正常系のテストを行えば、その下の層も正しく動いていることが確認できるので、★マークの部分は責めて行って欲しい、
ただし、浅いテストだと例えばif文で違うコードの実行がされていない場合があるので、なるべく全て網羅したいところである。

②振る舞いを考えられること
プログラムコードを書く前に、テストコードを書いて実装をすることをテスト駆動開発というが、これを行うことにより、
どのような実装にすることで、達成したいものを作成できるかを深く考えられるので、実際に出来上がった際の完成度が高くなる。
①と違いこのことを考えると、全てのレシピで実践することが望ましい。

これは各プロジェクトの温度感で決めると良いと思われるが、★マークがあるところは絶対やって欲しい。

 - [ ] コントローラー（リクエストも含む）
     - [ ] 正常 ★
     - [ ] 異常
 - [ ] ユースケース
     - [ ] 正常
     - [ ] 異常
- [ ] リポジトリ
     - [ ] 正常
     - [ ] 異常
- [ ] クエリサービス
     - [ ] 正常
     - [ ] 異常
- [ ] エンティティ
     - [ ] 正常
     - [ ] 異常

# 環境の作成
## Dockerのインストール
#### Windows10Home
事前にDocker Toolboxをインストールしておいてください。  
[Docker Toolbox](https://docs.docker.com/toolbox/toolbox_install_windows/)  
[Docker Toolboxのインストール：Windows編](https://qiita.com/maemori/items/52b1639fba4b1e68fccd)

#### Windows 10 Pro 
[Docker for Windowsをインストール](https://ops.jig-saw.com/techblog/docker-for-windows-install/)  
[Install Docker Desktop on Windows](https://docs.docker.com/docker-for-windows/install/)

#### Mac
事前にDocker Desktop for Macをインストールしてください。   
[Docker Hub](https://hub.docker.com/editions/community/docker-ce-desktop-mac)

---

### Windowsのマウントについて
※Windows10Proでは、作業するディレクトリを設定する場合はdocker for windowsの設定から  
shared drivesで該当ドライブを許可することで実行出来ます。  
Windows10Home　ではvirtualboxの設定から「共有ドライブ」を変更すると  
マウントできます。

### 開発環境作成の前に、Xdebug設定
windows 10 Home を使っている場合は、php.iniの設定で、  
xdebug.remote_hostをIPアドレスの仮想アダプタに設定してください。  
特にIPをいじってない人は `192.168.99.1`に設定すれば大丈夫です。  
```bash
cd docker
cp -n laravel/php.ini.example laravel/php.ini
```
  
docker/laravel/php.iniを以下のように修正
```
xdebug.remote_host=host.docker.internal
; xdebug.remote_host=192.168.99.1
```
↓
```
; xdebug.remote_host=host.docker.internal
xdebug.remote_host=192.168.99.1
```

開発環境作成コマンド
```bash
cd docker
sh initialize.sh
```

完了時に以下のメッセージが表示されていれば成功です。
```bash
------------INITIALIZE COMPLETE------------
PHP 7.4.1 (cli) (built: Dec 28 2019 20:56:41) ( NTS )
Copyright (c) The PHP Group
Zend Engine v3.4.0, Copyright (c) Zend Technologies
Laravel Framework 6.11.0
-------------------------------------------
指定されたパスが見つかりません。
      Name                    Command               State                 Ports
---------------------------------------------------------------------------------------------
docker_laravel_1   docker-php-entrypoint php-fpm    Up      9000/tcp
docker_mysql_1     docker-entrypoint.sh --inn ...   Up      0.0.0.0:3306->3306/tcp, 33060/tcp
docker_nginx_1     /bin/sh -c nginx -g 'daemo ...   Up      0.0.0.0:80->80/tcp
```

# コンテナ等
## PHP 7.4
## Laravel 6.11
### mysql
### nginx
### php-fpm


# コンテナの入りかた
```
docker-compose exec laravel bash
```

# 導入ライブラリ
## PHPCSFIXER(コード整形ツール)
コマンドによってコードを自動整形してくれます。複数開発をしてたときの
各開発者の癖をなくしてくれます。

### 使い方
```
sh scripts/code-fix.sh
diff or fix?
```
`diff`か `fix`を入力する。
diffを入力と整形前と整形後の差分を出力してくれます。

`fix`を入力すると
整形を行います。

### オプション
https://mlocati.github.io/php-cs-fixer-configurator/#version:2.16

## PHP_CodeSniffer(コードディング)
コードのコメントがしっかりされているかなどの検査を行ってくれるツール。  
役割がPHPCSFIXERと被る部分があるので、うまく付き合う必要がある。  
場合に応じては消しても良いと思われる。  

### 使い方
```bash
sh scripts/code-sniff.sh
check or fix?
```
`check`か `fix`を入力する。  
`check`を入力と、現在の問題を出力してくれます。  
  
`fix`を入力すると整形を行います。  
https://github.com/squizlabs/PHP_CodeSniffer/wiki/Configuration-Options

### オプション
よく分からないけど、これ、
https://mlocati.github.io/php-cs-fixer-configurator/#version:2.16
  
## PHPStan（静的解析）
https://github.com/nunomaduro/larastan  
静的解析ツールPHPStanをLaravelに対応させた「LaraStan」  
静的解析を行いコメント通りの挙動になっていない場合、エラーを出力してくれる。  
  
## オプション  
`phpstan.neon` か `phpstan.neon.dist`で設定する。  
設定方法は、GitHub、  
内容はPHPStanホームページhttps://phpstan.org/config-reference で確認

### 使い方
```bash
sh scripts/phpstan.sh
```
  
## PhpDocumentor(クラスの仕様書自動生成) 
※関与するライブラリが多いため、Dockerのサーバー側のComposerにGlobalインストールしてます。  
修正や、バージョンアップをする際は、`docker/laravel/Dockerfile`を修正してください。  

### オプション
`app/scripts/phpdocumentor.sh `でコマンド設定しており、アウトプットされる場所の指定などが行える。

### 使い方
```bash
sh scripts/phpdocumentor.sh 
```
