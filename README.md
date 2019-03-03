# react app on docker hello world
docker入門

## 初回起動
```
docker-compose up --build -d
```

## 起動
```
docker-compose up -d
```

## 停止
```
docker-compose stop
```

# 説明用メモ
## プロジェクト を作る場所
mkdir react-app
cd react-app
mkdir hello-world

## dockerfile用意
vi Dockerfile

## dockerfileからdockerimageの生成
docker build --force-rm -t react-app:001 -f Dockerfile ./

## run command
sudo docker run --privileged \
    -d \
	--tmpfs /run:rw,noexec,nosuid,size=65536k \
    -p 3000:3000 \
    --name test \
    -it react-app:001 \
    /sbin/init
    
## 以下、ホストにアプリのソースを移動する場合

※コンテナ内でソースを入れ、ホストにソースがない状態の時の話

### 一旦ホストにコピーしてイメージを消す
sudo docker cp test:/var/www/src/hello-world/. $(pwd)/hello-world/.
docker stop test
docker container rm test
    
### ホストをマウントしてコンテナーを生成
sudo docker run --privileged \
    -d \
	--tmpfs /run:rw,noexec,nosuid,size=65536k \
    -p 3000:3000 \
    -v $(pwd)/hello-world:/var/www/src/hello-world \
    --name test \
    -it react-app:001 \
    /sbin/init 
    
### app起動 (一度起動するとreact devプロセスあがりっぱなしになります。)
docker exec -i test /bin/bash -c "cd /var/www/src/hello-world && npm start"
    