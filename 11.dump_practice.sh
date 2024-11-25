# 덤프파일 생성 : dumpfile.sql 이라는 이름으로 덤프파일 생성
mysqldump -u root -p board > dumpfile.sql

# 한글 깨질 때
mysqldump -u root -p board -r dumpfile.sql

# 덤프파일 적용
# board database 생성 후 해야함ㅇ
# < 가 특수문자로 인식되어, window에서는 적용이 안될경우, git bash 터미널창 이용
mysql -u root -p board < dumpfile.sql


