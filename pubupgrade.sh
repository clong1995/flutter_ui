#!/bin/bash

# 遍历当前目录下的所有子目录（一层）
for dir in */; do
    if [ -d "$dir" ]; then
        (
            echo "正在处理目录: $dir"
            cd "$dir" || exit 1

            # 检查是否是 Dart 模块目录
            if [ -f "pubspec.yaml" ]; then
                flutter pub upgrade
            else
                echo "警告: $dir 不是Dart模块目录，跳过"
            fi

            echo "目录 $dir 处理完成"
        ) &  # 放入后台执行
    fi
done

wait  # 等待所有后台任务完成
echo "所有目录处理完成"