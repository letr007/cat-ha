#!/bin/bash

# cat 函数
CAT_FUNCTION_BASH='cat() {
    if [ $# -gt 0 ]; then
        local file_count=0

        for arg in "$@"; do
            if [ -f "$arg" ]; then
                command cat "$arg"
                ((file_count++))
            else
                command cat "$arg"
            fi
        done

        if [ $file_count -gt 0 ]; then
            echo -e "\\n哈！"
        fi
    else
        command cat
    fi
}'

CAT_FUNCTION_FISH='function cat
    if count $argv > /dev/null
        set file_count 0
        
        for arg in $argv
            if test -f "$arg"
                command cat "$arg"
                set file_count (math $file_count + 1)
            else
                command cat "$arg"
            end
        end
        
        if test $file_count -gt 0
            echo -e "\\n哈！"
        end
    else
        command cat
    end
end'


# 检查是否已经安装过的标记
INSTALL_MARKER="# CUSTOM_CAT_FUNCTION"

# 获取当前用户的主目录
HOME_DIR="$HOME"

# 要检查的 Shell 配置文件
SHELL_CONFIGS=(
    "$HOME_DIR/.bashrc"
    "$HOME_DIR/.zshrc" 
    "$HOME_DIR/.config/fish/config.fish"
)

# 根据不同 Shell 的函数语法
BASH_STYLE_CONFIGS="$HOME_DIR/.bashrc"
ZSH_CONFIGS="$HOME_DIR/.zshrc"
FISH_CONFIG="$HOME_DIR/.config/fish/config.fish"

# 安装计数器
INSTALL_COUNT=0

# 为 Bash 风格 Shell 安装
for config in "${BASH_STYLE_CONFIGS[@]}"; do
    if [ -f "$config" ]; then
        if ! grep -q "$INSTALL_MARKER" "$config"; then
            echo "" >> "$config"
            echo "$INSTALL_MARKER" >> "$config"
            echo "$CAT_FUNCTION_BASH" >> "$config"
            echo "已安装到: $config"
            ((INSTALL_COUNT++))
        else
            echo "已在 $config 中安装过，跳过"
        fi
    fi
done

# 为 Zsh 安装
for config in "${ZSH_CONFIGS[@]}"; do
    if [ -f "$config" ]; then
        if ! grep -q "$INSTALL_MARKER" "$config"; then
            echo "" >> "$config"
            echo "$INSTALL_MARKER" >> "$config"
            echo "$CAT_FUNCTION_BASH" >> "$config"
            echo "已安装到: $config"
            ((INSTALL_COUNT++))
        else
            echo "已在 $config 中安装过，跳过"
        fi
    fi
done

# 为 Fish Shell 安装
if [ -f "$FISH_CONFIG" ]; then
    
    if ! grep -q "$INSTALL_MARKER" "$FISH_CONFIG"; then
        echo "" >> "$FISH_CONFIG"
        echo "$INSTALL_MARKER" >> "$FISH_CONFIG"
        echo "$CAT_FUNCTION_FISH" >> "$FISH_CONFIG"
        echo "已安装到: $FISH_CONFIG"
        ((INSTALL_COUNT++))
    else
        echo "已在 $FISH_CONFIG 中安装过，跳过"
    fi
fi

# 输出安装结果
if [ $INSTALL_COUNT -gt 0 ]; then
    echo ""
    echo "✅ 安装完成！哈气 cat 已添加到 $INSTALL_COUNT 个配置文件"
    echo ""
    echo "请执行以下命令之一来立即哈气："
    echo "  source ~/.bashrc    # 对于 Bash"
    echo "  source ~/.zshrc     # 对于 Zsh"  
    echo "  source $FISH_CONFIG # 对于 Fish"
else
    echo "ℹ️  所有支持的 Shell 配置文件中都已安装过哈气 cat"
fi