## 让你的cat命令学会哈气!


老东西曾经说过:
> cat也是猫，猫当然要哈气

### 基本原理

在shell的配置文件中添加一个cat函数来hook原本的cat命令，在正常执行cat命令的基础上加上哈气功能

### 手动哈气

`.bashrc`/`.zshrc`中:
```bash
cat() {
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
}
```

`config.fish`中:
```bash
function cat
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
end
```

添加完毕后记得执行下面的命令来立即应用更改
```bash
source ~/.bashrc
source ~/.zshrc
source YOUR_FISH_CONFIG_PATH
```

### 自动哈气

下载`install.sh`并执行，会自动添加到当前用户的终端配置文件中

### 不想当鉴猫了

当变成豪猫不再哈气的时候，只需要去到终端的配置文件中手动删除即可