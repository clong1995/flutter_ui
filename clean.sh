#!/bin/bash

echo "开始清理当前目录下的Flutter项目及package中的example..."
echo

count=0

# 清理所有找到的项目（主项目和example）
clean_project() {
    local dir=$1
    if [ -f "$dir/pubspec.yaml" ]; then
        echo "找到Flutter项目: $dir"
        
        cd "$dir" || return
        echo "执行 flutter clean..."
        flutter clean
        count=$((count + 1))
        echo "✓ 已完成清理"
        echo
        cd - > /dev/null || return
    fi
}

# 清理当前目录下的项目
for dir in ./*/; do
    clean_project "$dir"
done

# 清理package中的example目录
for dir in ./*/example/; do
    clean_project "$dir"
done

if [ $count -eq 0 ]; then
    echo "当前目录下未找到Flutter项目或package example"
else
    echo "共清理了 $count 个Flutter项目"
fi

echo "完成!"