#! /bin/sh
#这个脚本去除了原脚本内的 xterm  
./bin/linux/julius -C main.jconf -C am-dnn.jconf -demo -input vecnet $* &
sleep 10
python ./bin/common/dnnclient-gpu.py dnnclient.conf &
sleep 5
./bin/linux/adintool -in mic -out vecnet -server 127.0.0.1 -paramtype FBANK_D_A_Z -veclen 120 -htkconf model/dnn/config.lmfb -port 5532 -cvn -cmnload model/dnn/norm -cmnnoupdate
#adintool -in file可以替换成文件输入，结合shell管道交互+web框架实现语音识别api服务。
kill 0
