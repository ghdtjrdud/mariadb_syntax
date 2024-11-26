# 덤프파일 생성 : dumpfile.sql 이라는 이름으로 덤프파일 생성
mysqldump -u root -p board > dumpfile.sql

# 한글 깨질 때
mysqldump -u root -p board -r dumpfile.sql

# 덤프파일 적용
# board database 생성 후 해야함ㅇ
# < 가 특수문자로 인식되어, window에서는 적용이 안될경우, git bash 터미널창 이용
mysql -u root -p board < dumpfile.sql

# dump 실습 리눅스(명령어가 안먹으면 sudo 붙히기)
# 리눅스에서 mariadb 설치
sudo apt-get install mariadb-server

# mariadb 서버 실행
sudo systemctl start mariadb

# mariadb 접속 : 1234
sudo mariadb -u root -p

# board 데이터베이스 만들기
create database board;

# git 설치  (sql 나가서)
sudo apt install git

# git에서 repository clone  (sql 나가서)
git clone 레포지토리 주소

# mariadb 덤프파일 복원  (sql 나가서)
mysql -u root -p board < dumpfile.sql

# 잘 들어갔는지 확인
use board;
show tables;
