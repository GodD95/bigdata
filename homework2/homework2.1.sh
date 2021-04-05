#!/bin/bash
##启动hadoop
cd /usr/local/hadoop
./sbin/start-dfs.sh
##关闭安全模式
hdfs dfsadmin -safemode leave
###############第一题###############
echo "第一题开始"
##检验HDFS中是否已存在该文件
hadoop fs -test -e test.txt
echo $? #0代表存在，1代表不存在
##不存在时上传
hadoop fs -put ~/hadoop/test.txt
##存在时追加到原有文件末尾
hadoop fs -appendToFile ~/hadoop/test.txt test.txt
##查看文件内容
hadoop fs -cat test.txt
##存在时覆盖原有的文件
hadoop fs -put -f ~/hadoop/test.txt
##查看文件内容
hadoop fs -cat test.txt
###############第二题###############
echo "第二题开始"
##if判断
if [ -f ~/hadoop/test.txt ];then
	hadoop fs -get test.txt ~/hadoop/newtest.txt
else
	hadoop fs -get test.txt ~/hadoop/test.txt
fi
###############第三题###############
echo "第三题开始"
hadoop fs -cat test.txt
###############第四题###############
echo "第四题开始"
hadoop fs -ls test.txt
###############第五题###############
echo "第五题开始"
hadoop fs -mkdir -p 1/2/3/4/5
hadoop fs -ls -R 1
###############第六题###############
echo "第六题开始"
##检查路径目录是否存在，不存在则创建
hadoop fs -test -d 1/6/7/8
if [ "$?" != "0" ];then
	hadoop fs -mkdir -p 1/6/7/8
fi
hadoop fs -touchz 1/6/7/8/a.txt
##展示运行结果
hadoop fs -ls -R 1
##删除文件
hadoop fs -rm 1/6/7/8/a.txt
###############第七题##############
echo "第七题开始"
##检查路径目录是否存在，不存在则创建
hadoop fs -test -d 1/9
if [ "$?" != "0" ];then
	hadoop fs -mkdir 1/9
fi
##删除目录
hadoop fs -rmdir 1/9
##目录不为空时仍继续删除
hadoop fs -rm -r 1/9
###############第八题###############
echo "第八题开始"
##加到开头
hadoop fs -get -f test.txt copy.txt
cat ~/hadoop/insert.txt copy.txt >> ~/hadoop/inserttest.txt
hadoop fs -put -f ~/hadoop/inserttest.txt test.txt
hadoop fs -cat test.txt
##加到结尾
hadoop fs -appendToFile ~/hadoop/insert.txt test.txt
hadoop fs -cat test.txt
###############第九题###############
echo "第九题开始"
hadoop fs -rm test.txt
###############第十题###############
echo "第十题开始"
hadoop fs -mv test.txt 1/test.txt
##关闭hadoop
./sbin/stop-dfs.sh
