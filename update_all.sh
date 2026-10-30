#!/bin/bash

set -e  # 如果希望单个失败时停止整个脚本，保留此行；否则注释掉

for dir in */; do
    # 去掉末尾的斜杠
    dir="${dir%/}"

    # 可选：跳过隐藏目录
    if [[ "$dir" == .* ]]; then
        continue
    fi

    # 检查是否为目录且包含 pubspec.yaml
    if [ -d "$dir" ] && [ -f "$dir/pubspec.yaml" ]; then
        echo "========================================"
        echo "Upgrading Dart dependencies in: $dir"
        echo "========================================"
        (
            cd "$dir" || exit 1
            echo "Running: dart pub upgrade"
            if dart pub upgrade; then
                echo "✅ Successfully upgraded $dir"
            else
                echo "❌ Failed to upgrade $dir" >&2
            fi
        )
    else
        echo "Skipping $dir: not a Dart project (no pubspec.yaml found)"
    fi
done

echo "All done."